From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 0/2] ARM: omap/dts: Add support for Gumstix Overo with
 Tobi expansion
Date: Mon, 10 Sep 2012 11:25:22 +0200
Message-ID: <504DB202.5050500@epfl.ch>
References: <1346429172-5902-1-git-send-email-florian.vaussard@epfl.ch> <20120906205227.GM1303@atomide.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.218]:41508 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754552Ab2IJJZ0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 05:25:26 -0400
In-Reply-To: <20120906205227.GM1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Benoit Cousson <b-cousson@ti.com>, Steve Sakoman <steve@sakoman.com>, Philippe Retornaz <philippe.retornaz@epfl.ch>, linux-arm-kernel@lists.infradead.org

Le 06/09/2012 22:52, Tony Lindgren a =E9crit :
> * Florian Vaussard <florian.vaussard@epfl.ch> [120831 09:07]:
>> The Gumstix Overo is a computer on module using an OMAP3 processor.
>> This module must be plugged into an expansion board.
>>
>> This patchset adds a first device tree support for the Overo, using =
the
>> Tobi expansion board. The current support is able to boot and mount
>> the rootfs from MMC, with a few extra features.
>>
>> The first patch creates the device tree for both the Overo and the
>> Tobi expansion board, and updates the dtb build target.
>>
>> The second patch updates the omap/dts documentation.
>>
>> This patchset applies on tony's tree [1], devel-dt branch.
> Great, I'm assuming Benoit will pick this up as well.

What is the status Benoit?

Thank you,
=46lorian

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
