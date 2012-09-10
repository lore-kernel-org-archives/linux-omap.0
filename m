From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 0/2] ARM: omap/dts: Add support for Gumstix Overo with
 Tobi expansion
Date: Mon, 10 Sep 2012 13:38:16 +0200
Message-ID: <504DD128.1000803@ti.com>
References: <1346429172-5902-1-git-send-email-florian.vaussard@epfl.ch> <20120906205227.GM1303@atomide.com> <504DB202.5050500@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46084 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688Ab2IJLij (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Sep 2012 07:38:39 -0400
In-Reply-To: <504DB202.5050500@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Steve Sakoman <steve@sakoman.com>, Philippe Retornaz <philippe.retornaz@epfl.ch>, linux-arm-kernel@lists.infradead.org

On 09/10/2012 11:25 AM, Florian Vaussard wrote:
> Le 06/09/2012 22:52, Tony Lindgren a =E9crit :
>> * Florian Vaussard <florian.vaussard@epfl.ch> [120831 09:07]:
>>> The Gumstix Overo is a computer on module using an OMAP3 processor.
>>> This module must be plugged into an expansion board.
>>>
>>> This patchset adds a first device tree support for the Overo, using=
 the
>>> Tobi expansion board. The current support is able to boot and mount
>>> the rootfs from MMC, with a few extra features.
>>>
>>> The first patch creates the device tree for both the Overo and the
>>> Tobi expansion board, and updates the dtb build target.
>>>
>>> The second patch updates the omap/dts documentation.
>>>
>>> This patchset applies on tony's tree [1], devel-dt branch.
>> Great, I'm assuming Benoit will pick this up as well.
>=20
> What is the status Benoit?

Patches looks good to me. I just adding them right now in my for_3.7/dt=
s tree.

I've just slightly changed the subjects:

Documentation: dt: Update the OMAP documentation with Overo/Toby
ARM: dts: OMAP3: Add support for Gumstix Overo with Tobi expansion boar=
d

If you want to give it a try, here is the branch that contains all the =
DTS series I
already pulled. It includes your gpio-twl4030 patches as well.

git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.gi=
t for_3.7/dts

Regards,
Benoit
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
