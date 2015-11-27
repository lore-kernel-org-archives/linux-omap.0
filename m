From: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
Date: Fri, 27 Nov 2015 09:44:51 +0100
Message-ID: <CAOf5uwn_3gY=xE8gBS2hZ-O4ZBZruxYRN8a_hO0bqCHy-yA2Gg@mail.gmail.com>
References: <20150713131902.GH26485@atomide.com>
	<20151123144545.GD24147@pali>
	<20151125181644.GI2517@atomide.com>
	<17134653.86P3dFyQKK@wuerfel>
	<20151125210310.GT2517@atomide.com>
	<56568849.5080103@gmail.com>
	<20151126090739.GD14190@pali>
	<20151126203930.GW2517@atomide.com>
	<20151127083833.GA430@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151127083833.GA430@pali>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Laura Abbott <lauraa-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi

On Fri, Nov 27, 2015 at 9:38 AM, Pali Roh=C3=A1r <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=
 wrote:
> On Thursday 26 November 2015 12:39:30 Tony Lindgren wrote:
>> Just to explore options.. How about make a minimal device driver tha=
t
>> just loads the atags blob from /lib/firmware and then shows it in
>> /proc/atags? Of course some checking on the atags should be done by
>> the driver..
>
> And who can dynamically create that blob file in /lib/firmware? If
> kernel does not export those atags (somehow) from bootloader, then
> userspace is not able to create that blob... cyclic problem.
>

Are those atags from bootloader fix or they change device by device. If=
 they
are fixed they can be included in some firmware and get from the disk.

Michael

> So no, problem is that bootloader provides via custom atags dynamic
> information like: boot reason (how was device started, by rtc alarm? =
by
> reboot? by usb charger? by power button?), boot mode (should be enter
> into firmware update mode?, is this normal boot mode?), ... and those
> information are needed for some proprietary software (e.g. firmware
> upgrade/flash) but also by any other open source applications (based =
on
> usb charger we enter different runlevel -- for just only charging
> device).
>
> --
> Pali Roh=C3=A1r
> pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
