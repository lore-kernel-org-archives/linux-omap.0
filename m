From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: OMAP3530 with no TWL4030 power controller
Date: Tue, 7 Feb 2012 12:53:59 +0200
Message-ID: <CANOLnOP-fxPyzS2qa4egxgnXOhYyYGeBe3XJ_TUtgE9VJ5sthw@mail.gmail.com>
References: <4F301177.4020008@mlbassoc.com>
	<20120206234531.GW1426@atomide.com>
	<4F30683E.2030509@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-13
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43589 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556Ab2BGKyA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Feb 2012 05:54:00 -0500
Received: by iacb35 with SMTP id b35so9950908iac.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Feb 2012 02:53:59 -0800 (PST)
In-Reply-To: <4F30683E.2030509@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Kevin Hilman <khilman@ti.com>

On Tue, Feb 7, 2012 at 1:54 AM, Gary Thomas <gary@mlbassoc.com> wrote:
> This will be a bit more of a change than just another PMIC since
> this device isn't much of a power manager (other than at the very
> lowest level to handle power up sequencing, etc). =A0It's good to
> hear that it _should_ work and I look forward to ideas on how
> to _make_ it work.
>
> For now, I've left PM and REGULATOR enabled so I can at least
> build the kernel and with just a few changes, I can get the
> kernel to boot to a prompt. =A0I do need to work out the uglyness
> of what I've had to do though :-)

You might still want to have CONFIG_PM on since it's more about things
like turning off clocks when they are no longer used and is suspend to
RAM prerequisite. REGULATOR also doesn't imply PMIC, it has things
like always-on or GPIO controlled power sources. I think you want to
disable CONFIG_TWL4030_CORE that's the actual PMIC core driver that
all it's subchip drivers depend on.


--=20
Gra=FEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
