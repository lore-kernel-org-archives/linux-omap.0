From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 1a/3] watchdog: omap: clearify device tree documentation
Date: Sun, 26 Apr 2015 08:29:20 -0700
Message-ID: <553D0450.6050403@roeck-us.net>
References: <20150424190207.GU19431@pengutronix.de> <1429906850-5420-1-git-send-email-u.kleine-koenig@pengutronix.de> <20150425021024.GA14963@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150425021024.GA14963-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, =?windows-1252?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 04/24/2015 07:10 PM, Felipe Balbi wrote:
> On Fri, Apr 24, 2015 at 10:20:50PM +0200, Uwe Kleine-K=F6nig wrote:
>> ti,hwmods doesn't belong into the compatible section but is a proper=
ty
>> on it's own. Also reformat the section of required properties to mat=
ch the
>> usual style of dt binding documents.
>>
>> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>
> looks great to me, thanks
>
> Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>

Reviewed-by: and Acked-by: are mutually exclusive.

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
