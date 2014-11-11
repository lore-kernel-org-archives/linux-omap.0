From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl4030-power: Fix poweroff with PM configuration
 enabled
Date: Tue, 11 Nov 2014 12:31:46 +0000
Message-ID: <20141111123146.GB24004@x1>
References: <20141102180756.GH31454@atomide.com>
 <20141110124019.GZ21424@x1>
 <20141110175343.GB4047@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:54643 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbaKKMbw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2014 07:31:52 -0500
Received: by mail-ig0-f179.google.com with SMTP id r10so875981igi.6
        for <linux-omap@vger.kernel.org>; Tue, 11 Nov 2014 04:31:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141110175343.GB4047@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

On Mon, 10 Nov 2014, Russell King - ARM Linux wrote:

> On Mon, Nov 10, 2014 at 12:40:19PM +0000, Lee Jones wrote:
> > On Sun, 02 Nov 2014, Tony Lindgren wrote:
> >=20
> > > Commit e7cd1d1eb16f ("mfd: twl4030-power: Add generic reset
> > > configuration") enabled configuring the PM features for twl4030.
> > >=20
> > > This caused poweroff command to fail on devices that have the
> > > BCI charger on twl4030 wired, or have power wired for VBUS.
> > > Instead of powering off, the device reboots. This is because
> > > voltage is detected on charger or VBUS with the default bits
> > > enabled for the power transition registers.
> > >=20
> > > To fix the issue, let's just clear VBUS and CHG bits as we want
> > > poweroff command to keep the system powered off.
> > >=20
> > > Fixes: e7cd1d1eb16f ("mfd: twl4030-power: Add generic reset confi=
guration")
> > > Cc: stable@vger.kernel.org # v3.16+
> > > Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> >=20
> > Applied to -fixes.
> >=20
> > Not sure whether that was an Ack from Russell or not?
>=20
> A Tested-by would've been more appropriate than an ack.

Applied.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
