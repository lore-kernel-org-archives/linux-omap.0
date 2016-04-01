From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Fri, 1 Apr 2016 15:18:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1604011452580.1957-100000@iolanthe.rowland.org>
References: <xa1tmvpdz2h4.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <xa1tmvpdz2h4.fsf-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, 1 Apr 2016, Michal Nazarewicz wrote:

> On Thu, Mar 31 2016, Alan Stern wrote:
> > Michal, I'm not sure how you intended to handle this.
> 
> For legacy/nokia setting no_configfs should be a valid solution:
> 
> ---- >8 ----------------------------------------------------------------
> diff --git a/drivers/usb/gadget/legacy/nokia.c b/drivers/usb/gadget/legacy/nokia.c
> index 0997504..e4bc607 100644
> --- a/drivers/usb/gadget/legacy/nokia.c
> +++ b/drivers/usb/gadget/legacy/nokia.c
> @@ -223,6 +223,7 @@ static int nokia_bind_config(struct usb_configuration *c)
>         }
>  
>         fsg_opts = fsg_opts_from_func_inst(fi_msg);
> +       fsg_opts->no_configfs = true;
>  
>         status = fsg_common_run_thread(fsg_opts->common);
>         if (status)
> ---- >8 ----------------------------------------------------------------
> 
> This is what other legacy gadgets do after all.

Okay, that makes sense.  Legacy gadgets aren't meant to be used with 
configfs anyway.

> For configfs, why not simply check if the thread has already been
> started:
> 
> ---- >8 ----------------------------------------------------------------
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index acf210f..62854b6 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -2984,8 +2984,10 @@ int fsg_common_run_thread(struct fsg_common *common)
>         common->thread_task =
>                 kthread_create(fsg_main_thread, common, "file-storage");
>         if (IS_ERR(common->thread_task)) {
> +               int ret = PTR_ERR(common->thread_task);
> +               common->thread_task = NULL;
>                 common->state = FSG_STATE_TERMINATED;
> -               return PTR_ERR(common->thread_task);
> +               return ret;
>         }
>  
>         DBG(common, "I/O thread pid: %d\n", task_pid_nr(common->thread_task));
> @@ -3005,6 +3007,7 @@ static void fsg_common_release(struct kref *ref)
>         if (common->state != FSG_STATE_TERMINATED) {
>                 raise_exception(common, FSG_STATE_EXIT);
>                 wait_for_completion(&common->thread_notifier);
> +               common->thread_task = NULL;
>         }
>  
>         for (i = 0; i < ARRAY_SIZE(common->luns); ++i) {
> @@ -3050,9 +3053,11 @@ static int fsg_bind(struct usb_configuration *c, struct usb_function *f)
>                 if (ret)
>                         return ret;
>                 fsg_common_set_inquiry_string(fsg->common, NULL, NULL);
> -               ret = fsg_common_run_thread(fsg->common);
> -               if (ret)
> -                       return ret;
> +               if (common->thread_task) {

Do you mean: if (!common->thread_task)?

> +                       ret = fsg_common_run_thread(fsg->common);
> +                       if (ret)
> +                               return ret;
> +               }
>         }
>  
>         fsg->gadget = gadget;
> ---- >8 ----------------------------------------------------------------
> 
> With that, the whole fsg_common_run_thread call should be moved outside
> of the if (!no_configfs) and legacy should no longer call it IMO.

I'm not so sure about this.  Earlier I was undecided about what to do
if there are multiple mass-storage interfaces in the same config, but
now I realize that one thread won't work in that situation.  The
difficulty is exception handling.  If an error occurs in one of the
interfaces, it shouldn't affect the others -- but with only one thread
you can't make that work.

I don't know the details of how the composite core works (I don't even
remember the difference between a usb_function and a
usb_function_instance).  Suppose there are several interfaces in one
config, each bound to the mass-storage driver.  Then won't the driver's
bind routine get called several times whenever the config is installed?

If so, then each of those calls should create a new thread.  There's no
need to check if the thread has already been started.

If not, then there's no way to use f_mass_storage on multiple 
interfaces in a single config.  The driver should refuse to run on more 
than one interface at a time.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
