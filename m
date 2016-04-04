From: Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Mon, 4 Apr 2016 19:18:48 +0300
Message-ID: <570293E8.2060406@gmail.com>
References: <Pine.LNX.4.44L0.1604021031030.19366-100000@netrider.rowland.org>
 <xa1ty48tilai.fsf@mina86.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <xa1ty48tilai.fsf-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, =?UTF-8?Q?pali_Roh=c3=a1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On  4.04.2016 15:57, Michal Nazarewicz wrote:
> On Sat, Apr 02 2016, Alan Stern wrote:
>> On Sat, 2 Apr 2016, Michal Nazarewicz wrote:
>
> Because of all that, I think the best course of action is to just check
> whether the thread is running and conditionally start it in fsg_bind,
> i.e.:
>
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -2979,20 +2979,7 @@ EXPORT_SYMBOL_GPL(fsg_common_set_inquiry_string);
>
>   int fsg_common_run_thread(struct fsg_common *common)
>   {
> -       common->state = FSG_STATE_IDLE;
> -       /* Tell the thread to start working */
> -       common->thread_task =
> -               kthread_create(fsg_main_thread, common, "file-storage");
> -       if (IS_ERR(common->thread_task)) {
> -               common->state = FSG_STATE_TERMINATED;
> -               return PTR_ERR(common->thread_task);
> -       }
> -
> -       DBG(common, "I/O thread pid: %d\n", task_pid_nr(common->thread_task));
> -
> -       wake_up_process(common->thread_task);
> -
> -       return 0;
> +       /* kill this function and all call sites */
>   }
>   EXPORT_SYMBOL_GPL(fsg_common_run_thread);
>
> @@ -3005,6 +2992,7 @@ static void fsg_common_release(struct kref *ref)
>          if (common->state != FSG_STATE_TERMINATED) {
>                  raise_exception(common, FSG_STATE_EXIT);
>                  wait_for_completion(&common->thread_notifier);
> +               common->thread_task = NULL;
>          }
>
>          for (i = 0; i < ARRAY_SIZE(common->luns); ++i) {
> @@ -3050,9 +3038,21 @@ static int fsg_bind(struct usb_configuration *c, struct usb_function *f)
>                  if (ret)
>                          return ret;
>                  fsg_common_set_inquiry_string(fsg->common, NULL, NULL);
> -               ret = fsg_common_run_thread(fsg->common);
> -               if (ret)
> +       }
> +
> +       if (!common->thread_task) {
> +               common->state = FSG_STATE_IDLE;
> +               common->thread_task =
> +                       kthread_create(fsg_main_thread, common, "file-storage");
> +               if (IS_ERR(common->thread_task)) {
> +                       int ret = PTR_ERR(common->thread_task);
> +                       common->thread_task = NULL;
> +                       common->state = FSG_STATE_TERMINATED;
>                          return ret;
> +               }
> +               DBG(common, "I/O thread pid: %d\n",
> +                   task_pid_nr(common->thread_task));
> +               wake_up_process(common->thread_task);
>          }
>
>          fsg->gadget = gadget;
>
> This should get rid of all the confusion and just do the right thing.
>

Who and when is going to destroy the thread if one does 
"/sys/bus/platform/drivers/musb-hdrc# echo musb-hdrc.0.auto > unbind"? 
Wouldn't some kind of refcounting make sense here?

Regards,
Ivo
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
