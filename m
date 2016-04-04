From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Mon, 04 Apr 2016 14:57:25 +0200
Message-ID: <xa1ty48tilai.fsf@mina86.com>
References: <Pine.LNX.4.44L0.1604021031030.19366-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1604021031030.19366-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Apr 02 2016, Alan Stern wrote:
> On Sat, 2 Apr 2016, Michal Nazarewicz wrote:
>> At the same time, mass storage should work fine if it=E2=80=99s boun=
d to
>> multiple configurations.  Only one configuration can be active at an=
y
>> given time so interfaces on different configurations cannot interfer=
e
>> with each other.

> Yes, it _should_.  But it doesn't with the nokia legacy driver.
> I don't know if this has any connection with configfs; it could be
> a problem with the way f_mass_storage interacts with the composite
> core.

I believe the failure is related to the thread being started twice wher=
e
it indeed shouldn=E2=80=99t.

>> The problem we are having is that when mass storage is added to
>> a configuration, fsg_bind is called and it starts the thread.

> This is what I'm not sure about.  Which callbacks does the composite
> core invoke when a config is installed or uninstalled?

usb_add_config is what is called to create a usb_configuration.  It
initialises the structure and passes it to a callback bind function
(most code removed for brevity):

int usb_add_config(struct usb_composite_dev *cdev,
		struct usb_configuration *config,
		int (*bind)(struct usb_configuration *))
{
	usb_add_config_only(cdev, config);
	bind(config);
	/* set_alt(), or next bind(), sets up ep->claimed as needed */
	usb_ep_autoconfig_reset(cdev->gadget);
	return 0;
}

The bind callback calls usb_add_function to add usb_function to a newly
created usb_configuration (again, most code removed for brevity):

int usb_add_function(struct usb_configuration *config,
		struct usb_function *function)
{
	function->config =3D config;
	value =3D function->bind(config, function);
	return 0;
}

=46or mass_storage, function->bind is fsg_bind (ditto):

static struct usb_function *fsg_alloc(struct usb_function_instance *fi)
{
	struct fsg_dev *fsg kzalloc(sizeof(*fsg), GFP_KERNEL);
	fsg->function.name	=3D FSG_DRIVER_DESC;
	fsg->function.bind	=3D fsg_bind;	/* !!! */
	fsg->function.unbind	=3D fsg_unbind;
	fsg->function.setup	=3D fsg_setup;
	fsg->function.set_alt	=3D fsg_set_alt;
	fsg->function.disable	=3D fsg_disable;
	fsg->function.free_func	=3D fsg_free;
	fsg->common               =3D common;
	return &fsg->function;
}

> Those callbacks should be where the thread is started and stopped.

Starting thread in that callback is what is happening right now and
because single usb_function_instance can have multiple usb_function
structures each binding to separate usb_configuration, this causes
problem where the thread is started multiple times.

This is also why the thread is not stopped in fsg_unbind but only once
fsg_common structure is released.

Conceptually, the thread should be started when fsg_common structure is
created (which is at the same time when usb_function_instance is
created) and stopped when fsg_common is released.

At this point, I=E2=80=99m not entirely sure if there is a reason why t=
his isn=E2=80=99t
the case.  The only reason I can think of is that starting the thread
right away may be considered wasteful since the thread won=E2=80=99t ha=
ve
anything to do until the function is bound to a configuration.  In the
current code, there may also be issues where perhaps the thread would
not get stopped if fsg_bind has never been called.

Because of all that, I think the best course of action is to just check
whether the thread is running and conditionally start it in fsg_bind,
i.e.:

--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2979,20 +2979,7 @@ EXPORT_SYMBOL_GPL(fsg_common_set_inquiry_string)=
;
=20
 int fsg_common_run_thread(struct fsg_common *common)
 {
-       common->state =3D FSG_STATE_IDLE;
-       /* Tell the thread to start working */
-       common->thread_task =3D
-               kthread_create(fsg_main_thread, common, "file-storage")=
;
-       if (IS_ERR(common->thread_task)) {
-               common->state =3D FSG_STATE_TERMINATED;
-               return PTR_ERR(common->thread_task);
-       }
-
-       DBG(common, "I/O thread pid: %d\n", task_pid_nr(common->thread_=
task));
-
-       wake_up_process(common->thread_task);
-
-       return 0;
+       /* kill this function and all call sites */
 }
 EXPORT_SYMBOL_GPL(fsg_common_run_thread);
=20
@@ -3005,6 +2992,7 @@ static void fsg_common_release(struct kref *ref)
        if (common->state !=3D FSG_STATE_TERMINATED) {
                raise_exception(common, FSG_STATE_EXIT);
                wait_for_completion(&common->thread_notifier);
+               common->thread_task =3D NULL;
        }
=20
        for (i =3D 0; i < ARRAY_SIZE(common->luns); ++i) {
@@ -3050,9 +3038,21 @@ static int fsg_bind(struct usb_configuration *c,=
 struct usb_function *f)
                if (ret)
                        return ret;
                fsg_common_set_inquiry_string(fsg->common, NULL, NULL);
-               ret =3D fsg_common_run_thread(fsg->common);
-               if (ret)
+       }
+
+       if (!common->thread_task) {
+               common->state =3D FSG_STATE_IDLE;
+               common->thread_task =3D
+                       kthread_create(fsg_main_thread, common, "file-s=
torage");
+               if (IS_ERR(common->thread_task)) {
+                       int ret =3D PTR_ERR(common->thread_task);
+                       common->thread_task =3D NULL;
+                       common->state =3D FSG_STATE_TERMINATED;
                        return ret;
+               }
+               DBG(common, "I/O thread pid: %d\n",
+                   task_pid_nr(common->thread_task));
+               wake_up_process(common->thread_task);
        }
=20
        fsg->gadget =3D gadget;

This should get rid of all the confusion and just do the right thing.

--=20
Best regards
=E3=83=9F=E3=83=8F=E3=82=A6 =E2=80=9C=F0=9D=93=B6=F0=9D=93=B2=F0=9D=93=B7=
=F0=9D=93=AA86=E2=80=9D =E3=83=8A=E3=82=B6=E3=83=AC=E3=83=B4=E3=82=A4=E3=
=83=84
=C2=ABIf at first you don=E2=80=99t succeed, give up skydiving=C2=BB
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
