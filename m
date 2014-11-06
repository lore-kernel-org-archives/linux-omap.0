From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv4 4/7] hwspinlock/core: add common OF helpers
Date: Thu, 6 Nov 2014 12:24:11 -0600
Message-ID: <545BBCCB.7030107@ti.com>
References: <1389658764-39199-1-git-send-email-s-anna@ti.com> <1389658764-39199-5-git-send-email-s-anna@ti.com> <CAJAp7Oj-3ZxvN8o=rg8YeTiXYWyQ1iowgisdU1R5UcZeh4VmOQ@mail.gmail.com> <5425938C.6070007@ti.com> <CAK=WgbYf3++K4MVXW_n4zj-8fMEee61XG5+r40cW=trapRtJ7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK=WgbYf3++K4MVXW_n4zj-8fMEee61XG5+r40cW=trapRtJ7w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Ohad,

On 10/06/2014 04:44 AM, Ohad Ben-Cohen wrote:
> On Fri, Sep 26, 2014 at 7:25 PM, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org> wrote:
>> I am yet to receive any comments on v6, but that series should address
>> both your need for a probe deferral and Ohad's request to not change any
>> return types. Please give it a try and let me know if you have any comments.
> 
> Guys,
> 
> Just to let you know we have several holidays around here these days,
> and I intend to review all pending patches immediately soon after.
> 

Ping on this. Can you review the latest series v6 [1] and pick it up for
3.19? The MSM spinlock driver is also blocked/dependent on that series.

regards
Suman

[1] http://marc.info/?l=linux-arm-kernel&m=141055365513902&w=2
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
