From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v2 09/10] arm/dts: omap3-beagle: Add twl4030 and i2c
 EEPROM
Date: Mon, 9 Jan 2012 23:24:42 +0000
Message-ID: <CAOZdJXU9w1O69ZgNEmgUZfezXEyn1JTyZxgmmLXAb3-mtJLnOA@mail.gmail.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
	<1323439361-1647-10-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:4872
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932131Ab2AIXYp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Jan 2012 18:24:45 -0500
In-Reply-To: <1323439361-1647-10-git-send-email-b-cousson@ti.com>
Content-Language: en-US
Content-ID: <B4EED714ED150A41A6C9E97EF2E66DEC@freescale.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Dec 9, 2011 at 8:02 AM, Benoit Cousson <b-cousson@ti.com> wrote=
:
>
> + =A0 =A0 =A0 eeprom@50 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "ti,eeprom";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x50>;
> + =A0 =A0 =A0 };

Why is this "ti,"?  For EDID, isn't the I2C device actually on the
monitor itself, and DVI cable just connects to the I2C bus?

The reason I ask is that I'm trying to do the same thing for a PowerPC
board.  I need to defined an EDID I2C node.

--=20
Timur Tabi
Linux kernel developer at Freescale
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
