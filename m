From: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: null pointer dereference in omap_wdt
Date: Mon, 2 Nov 2015 02:17:08 +0000
Message-ID: <CALeDE9OMJBKAcDK6Gr5ibwW+dY_AYWgwf+gWiEPWEhJrFr0=gA@mail.gmail.com>
References: <CALeDE9O3nU1j_eu4v7JbmKr1-+C1L-qBk3qu3XCcQcnGbbtssA@mail.gmail.com>
	<56369ED4.9070001@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56369ED4.9070001-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Sun, Nov 1, 2015 at 11:23 PM, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org> wrote:
> On 11/01/2015 03:11 PM, Peter Robinson wrote:
>>
>> Hi Lars,
>>
>> I'm seeing the following crash in omap_wdt in omap_wdt_get_timeleft
>> when I just run wdctl on a couple of different TI devices, the
>> beaglebone black/green or panda ES. I'm seeing it on both 4.2.3 and
>> 4.3rc7, looking at git it looks like you added the fuction in June,
>> have you seen this on any of your platforms?
>>
>
> I think that
>         struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
> in omap_wdt_get_timeleft() needs to be
>         struct omap_wdt_dev *wdev = to_omap_wdt_dev(wdog);
>
> Looks like there was an overlap between commit d2f78268ba58 ("watchdog:
> omap: put struct watchdog_device into driver data") and commit 452fafed839e
> ("watchdog: omap_wdt: implement get_timeleft").
>
> Can someone test this and send a patch to fix the problem ?

Yes, that fixed it, tested on the panda-es. I'll send a patch through
in a moment.

Peter
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
