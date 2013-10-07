From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v7 5/6] ARM: dts: AM33xx: updated default ECC scheme in
 nand-ecc-opt
Date: Mon, 7 Oct 2013 12:14:02 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA1F483@DBDE04.ent.ti.com>
References: <1380916188-24206-1-git-send-email-pekon@ti.com>
 <1380916188-24206-6-git-send-email-pekon@ti.com>
 <20131007114029.GC15365@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41934 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519Ab3JGMOs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Oct 2013 08:14:48 -0400
In-Reply-To: <20131007114029.GC15365@e106331-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "computersforpeace@gmail.com" <computersforpeace@gmail.com>
Cc: "robherring2@gmail.com" <robherring2@gmail.com>, "olof@lixom.net" <olof@lixom.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>, Pawel Moll <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "tony@atomide.com" <tony@atomide.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

> From: Mark Rutland [mailto:mark.rutland@arm.com]
> > On Fri, Oct 04, 2013 at 08:49:47PM +0100, Pekon Gupta wrote:
> > DT property values for OMAP based gpmc-nand have been updated
> > to match changes in commit:
> > 	6faf096 ARM: OMAP2+: cleaned-up DT support of various ECC
> schemes
> > Refer: Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> 
Sorry that's an old commit. I probably missed out updating the commit log.
So please ignore it here, I should remove that from commit log.


> Doesn't this mean these dts were broken between the changes to the
> driver and the changes to the dts?
> 
But the DTS updates are kept separate from driver updates because
- DTS updates go into "Benoit's tree" or "Tony's tree"
- whereas driver updates go into MTD tree.
So, it was suggested in earlier patch revisions that I keep the driver
and the DTS patches separate, so that there is no merge conflict
between the trees when they are finally accepted.


> I think the existing properties need to continue to be supoprted for
> backwards compatibility. The dts can be fixed up to have the preferred
> binding style, but they shouldn't _have_ to be modified to continue to
> function...
> 
However, there should be a way to remove legacy code which can
no longer be maintained. Here following ecc-schemes are such
legacy code, which are neither supported nor encouraged
to use since long time.
- OMAP_ECC_CODE_HAMMING_HW,
- OMAP_ECC_CODE_HAMMING_DEFAULT,
- OMAP_ECC_CODE_HAMMING_HW_ROMCODE

Also backward compatibility is maintained by keeping a common
symbol for all 3 above implementations OMAP_ECC_CODE_HAM1_HW
I don't think there is a point to continue keeping these  symbols
in kernel driver if they are unused, and make driver bulky and unreadable.

In actual it shouldn't matter to user what symbols I use inside
the driver, what matters is backward compatibility right ?


with regards, pekon
