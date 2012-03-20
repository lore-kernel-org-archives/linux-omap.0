From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/5 RESEND] ARM: OMAP: USB: HOST TLL platform driver
Date: Tue, 20 Mar 2012 14:22:12 +0530
Message-ID: <4F68453C.9040605@ti.com>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com>	<1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>	<4F66FF47.7000800@ti.com> <CAP05o4+A7AZ0SmMLgCfbBHs+zhsN-c2zM8caYe8M3-OC3YmZzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAP05o4+A7AZ0SmMLgCfbBHs+zhsN-c2zM8caYe8M3-OC3YmZzg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Munegowda, Keshava" <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, govindraj.raja-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Keshava,

On Tuesday 20 March 2012 12:58 PM, Munegowda, Keshava wrote:<Snip>
>>> +}
>>> +
>>> +static const struct dev_pm_ops usbtllomap_dev_pm_ops = {
>>> +     .runtime_suspend        = usbtll_runtime_suspend,
>>> +     .runtime_resume         = usbtll_runtime_resume,
>>> +};
>>> +
>> Also how about using runtime_pm_ops ?
> Sorry I din't get this? what exact alternative are you suggesting here?

SET_RUNTIME_PM_OPS(usbtll_runtime_suspend,
                                usbtll_runtime_resume, NULL)

I should have been clearer.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
