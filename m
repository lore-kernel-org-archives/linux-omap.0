From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Fri, 01 Apr 2016 19:02:47 +0200
Message-ID: <xa1tmvpdz2h4.fsf@mina86.com>
References: <Pine.LNX.4.44L0.1603311255560.1516-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1603311255560.1516-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 31 2016, Alan Stern wrote:
> Michal, I'm not sure how you intended to handle this.

=46or legacy/nokia setting no_configfs should be a valid solution:

---- >8 ---------------------------------------------------------------=
-
diff --git a/drivers/usb/gadget/legacy/nokia.c b/drivers/usb/gadget/leg=
acy/nokia.c
index 0997504..e4bc607 100644
--- a/drivers/usb/gadget/legacy/nokia.c
+++ b/drivers/usb/gadget/legacy/nokia.c
@@ -223,6 +223,7 @@ static int nokia_bind_config(struct usb_configurati=
on *c)
        }
=20
        fsg_opts =3D fsg_opts_from_func_inst(fi_msg);
+       fsg_opts->no_configfs =3D true;
=20
        status =3D fsg_common_run_thread(fsg_opts->common);
        if (status)
---- >8 ---------------------------------------------------------------=
-

This is what other legacy gadgets do after all.

=46or configfs, why not simply check if the thread has already been
started:

---- >8 ---------------------------------------------------------------=
-
diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb=
/gadget/function/f_mass_storage.c
index acf210f..62854b6 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2984,8 +2984,10 @@ int fsg_common_run_thread(struct fsg_common *com=
mon)
        common->thread_task =3D
                kthread_create(fsg_main_thread, common, "file-storage")=
;
        if (IS_ERR(common->thread_task)) {
+               int ret =3D PTR_ERR(common->thread_task);
+               common->thread_task =3D NULL;
                common->state =3D FSG_STATE_TERMINATED;
-               return PTR_ERR(common->thread_task);
+               return ret;
        }
=20
        DBG(common, "I/O thread pid: %d\n", task_pid_nr(common->thread_=
task));
@@ -3005,6 +3007,7 @@ static void fsg_common_release(struct kref *ref)
        if (common->state !=3D FSG_STATE_TERMINATED) {
                raise_exception(common, FSG_STATE_EXIT);
                wait_for_completion(&common->thread_notifier);
+               common->thread_task =3D NULL;
        }
=20
        for (i =3D 0; i < ARRAY_SIZE(common->luns); ++i) {
@@ -3050,9 +3053,11 @@ static int fsg_bind(struct usb_configuration *c,=
 struct usb_function *f)
                if (ret)
                        return ret;
                fsg_common_set_inquiry_string(fsg->common, NULL, NULL);
-               ret =3D fsg_common_run_thread(fsg->common);
-               if (ret)
-                       return ret;
+               if (common->thread_task) {
+                       ret =3D fsg_common_run_thread(fsg->common);
+                       if (ret)
+                               return ret;
+               }
        }
=20
        fsg->gadget =3D gadget;
---- >8 ---------------------------------------------------------------=
