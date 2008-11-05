From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/4] HSMMC: Add support for the second controller
Date: Wed, 5 Nov 2008 15:54:23 -0800
Message-ID: <200811051554.24055.david-b@pacbell.net>
References: <1225418657-31775-1-git-send-email-tony@atomide.com> <5e088bd90811031454q622f0ad9w274e0225dc885967@mail.gmail.com> <5e088bd90811031536o17969766o3632e99ed8add54d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:37406 "HELO
	smtp114.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752677AbYKEXy0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Nov 2008 18:54:26 -0500
In-Reply-To: <5e088bd90811031536o17969766o3632e99ed8add54d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Steve Sakoman <sakoman@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Monday 03 November 2008, Steve Sakoman wrote:
> >
> > I used David's appended patch plus Tony's 4 HSMMC patches.
> >
> > I used version 8.73.7p3 of the Marvell SD8686 firmware and helper
> > binaries and placed them in /lib/firmware.
>=20
> I just tried version 9.70.3p24 of the firmware & helper and have
> confirmed that it also works.

Ditto ... at least in terms of "iwlist scan" finding a decent set
of networks.  I think something probably should be done to keep
that chip powered down when it's not in use; it's quite toasty.
I'm not sure whether that issue comes from the libertas driver,
the SDIO stack, or somewhere else (hsmmc glue).


> This version is much more easily available from the Marvell site. =A0=
Go to:
>=20
> http://www.marvell.com/drivers/search.do
>=20
> Select "Network Controller" for device type (it's the only choice),
> and "Linux 2.6 - Fedora" for the OS.
>=20
> You will then be offered two choices, pick
> SD-8686-LINUX26-SYSKT-9.70.3.p24-26409.P45-GPL. =A0Extract (and then
> extract the tar image contained within) and look in the FWImage
> directory. =A0Copy both .bin files to your omap system's /lib/firmwar=
e
> directory and rename helper_sd.bin to sd8686.bin.

Or, for the record, add them to your kernel "firmware" directory
and using Kconfig set

CONFIG_FIRMWARE_IN_KERNEL=3Dy
CONFIG_EXTRA_FIRMWARE=3D"sd8686_helper.bin sd8686.bin"
CONFIG_EXTRA_FIRMWARE_DIR=3D"firmware"

It adds some bloat to the kernel (128+ KBytes) but is painless
in terms of rootfs configuration.

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
