From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] wlcore: Add support runtime PM
Date: Tue, 15 May 2018 09:25:46 -0700
Message-ID: <20180515162546.GO98604@atomide.com>
References: <20180515161315.1997-1-tony@atomide.com>
 <20180515161315.1997-3-tony@atomide.com>
 <CAOf5uwkT4Vg1kQn5k=_z9XjXOLWbA0vioqH6KSdikZbCwyaYbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOf5uwkT4Vg1kQn5k=_z9XjXOLWbA0vioqH6KSdikZbCwyaYbA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> [180515 16:19]:
> On Tue, May 15, 2018 at 6:13 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > @@ -315,15 +319,17 @@ static ssize_t dynamic_fw_traces_write(struct file *file,
> >         if (unlikely(wl->state != WLCORE_STATE_ON))
> >                 goto out;
> >
> > -       ret = wl1271_ps_elp_wakeup(wl);
> > -       if (ret < 0)
> > +       ret = pm_runtime_get_sync(wl->dev);
> > +       if (ret < 0) {
> > +               pm_runtime_put_noidle(wl->dev);
> >                 goto out;
> > +       }
> >
> 
> Can you just change ps_elp_wakeup with
>        ret = pm_runtime_get_sync(wl->dev);
>        if (ret < 0) {
>                pm_runtime_put_noidle(wl->dev);
>                  goto out;
>        }
> 
> >         ret = wl18xx_acx_dynamic_fw_traces(wl);
> >         if (ret < 0)
> >                 count = ret;
> >
> > -       wl1271_ps_elp_sleep(wl);
> > +       pm_runtime_put(wl->dev);
> 
> and elp_sleep with this one

That's what I started with, but they really behave in a different way. And
there is no usage count. It's really best to just get rid of the custom PM
calls in favor of generic calls. That's because then we have much better
control for future changes in the driver with pm_runtime_use_autosuspend()
and pm_runtime_put_sync() for example.

Regards,

Tony
