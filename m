From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Prevent potential crash if GPMC probe
 fails
Date: Sat, 9 Feb 2013 12:55:49 -0300
Message-ID: <20130209155547.GA5253@localhost>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
 <1359736726-10193-2-git-send-email-jon-hunter@ti.com>
 <20130201220804.GZ22517@atomide.com>
 <51158293.8010101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:36531 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760747Ab3BIPzq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Feb 2013 10:55:46 -0500
Content-Disposition: inline
In-Reply-To: <51158293.8010101@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Afzal Mohammed <afzal@ti.com>

On Fri, Feb 08, 2013 at 04:56:19PM -0600, Jon Hunter wrote:
>=20
> On 02/01/2013 04:08 PM, Tony Lindgren wrote:
> > * Jon Hunter <jon-hunter@ti.com> [130201 08:42]:
> >> If the GPMC probe fails, devices that use the GPMC (such as ethern=
et
> >> chips, flash memories, etc) can still allocate a GPMC chip-select =
and
> >> register the device. On the OMAP2420 H4 board, this was causing th=
e
> >> kernel to crash after the gpmc probe failed and the board attempte=
d
> >> to start networking. Prevent this by marking all the chip-selects =
as
> >> reserved by default and only make them available for devices to re=
quest
> >> if the GPMC probe succeeds.
> >=20
> > Thanks applying into omap-for-v3.9/gpmc.
>=20
> Hi Tony, this one appears to be merged incorrectly. The unreserve end=
ed=20
> up in the gpmc_calc_timings() function. Here is a patch to fix.
>=20
> Cheers
> Jon
>=20
> From ebc0613fb5a70f36fcb119cbe58724f9b442903a Mon Sep 17 00:00:00 200=
1
> From: Jon Hunter <jon-hunter@ti.com>
> Date: Fri, 8 Feb 2013 16:48:25 -0600
> Subject: [PATCH] ARM: OMAP2+: Fix-up gpmc merge error
>=20
> Commit "ARM: OMAP2+: Prevent potential crash if GPMC probe fails" add=
ed
> code to ensure that GPMC chip-selects could not be requested until th=
e
> device probe was successful. The chip-selects should have been
> unreserved at the end of the probe function, but the code to unreserv=
e
> them appears to have ended up in the gpmc_calc_timings() function and
> hence, this is causing problems requesting chip-selects. Fix this mer=
ge
> error by unreserving the chip-selects at the end of the probe, but
> before we call the gpmc child probe functions (for device-tree) which
> request a chip-select.
>=20
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Without this patch, GPMC is currently broken on my igep board setup,
if initialized through a device tree.

Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Thanks a lot for the fix,

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
