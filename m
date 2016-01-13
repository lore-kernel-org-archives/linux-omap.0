From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging
 of backup battery
Date: Wed, 13 Jan 2016 12:31:28 -0600
Message-ID: <56969800.5010206@ti.com>
References: <CCB763BE-5D1F-4A53-BF9A-C12C08A6EFC4@goldelico.com>
 <20160111202421.GA12777@atomide.com> <20160112000917.GC12777@atomide.com>
 <417BBA32-A7DC-40CD-8A6B-EA910B1C9C13@goldelico.com>
 <E4C8F6CA-37C1-406F-9804-46055253BED9@goldelico.com>
 <001346CD-CF31-4FEF-B406-B89EEBDFA063@goldelico.com>
 <56966558.1070608@ti.com> <569669C5.2070200@ti.com>
 <20160113164856.GF12777@atomide.com> <5696896F.4090309@ti.com>
 <20160113180006.GJ12777@atomide.com>
 <2B99611A-5D2E-4D17-A17D-0150516109FD@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2B99611A-5D2E-4D17-A17D-0150516109FD-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, =?UTF-8?Q?Gra=c5=bevydas_Ignotas?= <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 01/13/2016 12:08 PM, H. Nikolaus Schaller wrote:
[...]

>> OK. So are we sure the TWL driver will never have to toggle this pin?
> 
> After studying the Palmas TRM it appears that this pin just should be "high"
> to be able to write to RTC and some scratchpad register. If the Palmas OTP
> is programmed to use gpio7 as msecure input.

Thanks for digging it up. we dont use the scratchpad, but in some cases
where SoC cold reset is involved, those registers may store additional
information.

> 
> Since the scratchpad is not used we can permanently enable msecure. Which
> means that we must somehow get the driving output to be "1".
> 
> This can be either done by
> * a gpio with pull-up - switched to input mode as I proposed, or

I think you intended to suggest to do a mux to gpio with just pinmux
pull? The internal pull on padconf is very weak - for typical needs like
these, it is rather suggested to stick with real GPIO drive to prevent
conditions like noise interference(for example).


-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
