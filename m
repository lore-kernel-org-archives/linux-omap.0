From: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 2/2] wlcore: Add support runtime PM
Date: Wed, 16 May 2018 12:27:46 +0300
Message-ID: <87a7t0lzl9.fsf@kamboji.qca.qualcomm.com>
References: <20180515161315.1997-1-tony@atomide.com>
        <20180515161315.1997-3-tony@atomide.com>
        <CAOf5uwkT4Vg1kQn5k=_z9XjXOLWbA0vioqH6KSdikZbCwyaYbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOf5uwkT4Vg1kQn5k=_z9XjXOLWbA0vioqH6KSdikZbCwyaYbA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
        (Michael Nazzareno Trimarchi's message of "Tue, 15 May 2018 18:17:39
        +0200")
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Guy Mishol <guym-l0cyMroinI0@public.gmane.org>, Luca Coelho <luciano.coelho-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Maital Hahn <maitalm-l0cyMroinI0@public.gmane.org>, Maxim Altshul <maxim.altshul-l0cyMroinI0@public.gmane.org>, Shahar Patury <shaharp-l0cyMroinI0@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Michael Nazzareno Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org> writes:

>> @@ -315,15 +319,17 @@ static ssize_t dynamic_fw_traces_write(struct file *file,
>>         if (unlikely(wl->state != WLCORE_STATE_ON))
>>                 goto out;
>>
>> -       ret = wl1271_ps_elp_wakeup(wl);
>> -       if (ret < 0)
>> +       ret = pm_runtime_get_sync(wl->dev);
>> +       if (ret < 0) {
>> +               pm_runtime_put_noidle(wl->dev);
>>                 goto out;
>> +       }
>>
>
> Can you just change ps_elp_wakeup with
>        ret = pm_runtime_get_sync(wl->dev);
>        if (ret < 0) {
>                pm_runtime_put_noidle(wl->dev);
>                  goto out;
>        }
>
>>         ret = wl18xx_acx_dynamic_fw_traces(wl);
>>         if (ret < 0)
>>                 count = ret;
>>
>> -       wl1271_ps_elp_sleep(wl);
>> +       pm_runtime_put(wl->dev);
>
> and elp_sleep with this one
>
>>  out:
>>         mutex_unlock(&wl->mutex);
>>         return count;
>> @@ -374,9 +380,11 @@ static ssize_t radar_debug_mode_write(struct file *file,
>>         if (unlikely(wl->state != WLCORE_STATE_ON))
>>                 goto out;
>>
>> -       ret = wl1271_ps_elp_wakeup(wl);
>> -       if (ret < 0)
>> +       ret = pm_runtime_get_sync(wl->dev);
>> +       if (ret < 0) {
>> +               pm_runtime_put_noidle(wl->dev);
>>                 goto out;
>> +       }
>>
>>         wl12xx_for_each_wlvif_ap(wl, wlvif) {
>>                 wlcore_cmd_generic_cfg(wl, wlvif,
>> @@ -384,7 +392,7 @@ static ssize_t radar_debug_mode_write(struct file *file,
>>                                        wl->radar_debug_mode, 0);
>>         }
>>
>> -       wl1271_ps_elp_sleep(wl);
>> +       pm_runtime_put(wl->dev);
>
> Michael

<over 1600 lines of unnecessary quotation cut out>

PLEASE edit your quotes, your behaviour makes use of patchwork really
annoying:

https://patchwork.kernel.org/patch/10401591/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#do_not_top_post_and_edit_your_quotes

-- 
Kalle Valo
