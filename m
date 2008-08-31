From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 16/33] add omap led drivers
Date: Sun, 31 Aug 2008 14:01:44 -0700
Message-ID: <200808311401.44554.david-b@pacbell.net>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-16-git-send-email-me@felipebalbi.com> <1220116593-862-17-git-send-email-me@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:27516 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758104AbYHaVTL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 31 Aug 2008 17:19:11 -0400
In-Reply-To: <1220116593-862-17-git-send-email-me@felipebalbi.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

On Saturday 30 August 2008, Felipe Balbi wrote:
> +config LEDS_OMAP_DEBUG
> +=A0=A0=A0=A0=A0=A0=A0boolean "LED Support for OMAP debug board LEDs"
> +=A0=A0=A0=A0=A0=A0=A0depends on LEDS_CLASS=3Dy && ARCH_OMAP
> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 =A0Enables support for the LEDs on the debug b=
oard used with OMAP
> +=A0=A0=A0=A0=A0=A0=A0 =A0reference boards like H2/H3/H4 and Perseus2=
=2E =A0Up to six of these
> +=A0=A0=A0=A0=A0=A0=A0 =A0may be claimed by the original ARM debug LE=
D API.

This stuff is ancient and should not be pushed upstream.
Anything not using arch/arm/plat-omap/debug-leds.c should
be converted immediately.  Ditto anything using the legacy
ARM led framework.


> +config LEDS_OMAP
> +=A0=A0=A0=A0=A0=A0=A0tristate "LED Support for OMAP GPIO LEDs"
> +=A0=A0=A0=A0=A0=A0=A0depends on LEDS_CLASS && ARCH_OMAP
> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 =A0This option enables support for the LEDs on=
 OMAP processors.

Similarly obsolete.  Use drivers/leds/leds-gpio.c ...
Best to just remove this driver and convert its clients.


> +config LEDS_OMAP_PWM
> +=A0=A0=A0=A0=A0=A0=A0tristate "LED Support for OMAP PWM-controlled L=
EDs"
> +=A0=A0=A0=A0=A0=A0=A0depends on LEDS_CLASS && ARCH_OMAP && OMAP_DM_T=
IMER
> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 =A0This options enables support for LEDs conne=
cted to GPIO lines
> +=A0=A0=A0=A0=A0=A0=A0 =A0controlled by a PWM timer on OMAP CPUs.

This is more plausible.  But looking -- briefly! -- at the code, I
don't see why it needs a work_struct at all, or why it's not using
the blink_set() method to control the hardware blink rate.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
