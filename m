From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v10 04/10] mtd: nand: omap: fix device scan:
 NAND_CMD_READID, NAND_CMD_RESET, CMD_CMD_PARAM use only x8 bus
Date: Wed, 23 Oct 2013 13:15:20 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA2A0CB@DBDE04.ent.ti.com>
References: <1382172254-12448-1-git-send-email-pekon@ti.com>
 <1382172254-12448-5-git-send-email-pekon@ti.com>
 <20131022201624.GL23337@ld-irv-0074.broadcom.com>
 <20980858CB6D3A4BAE95CA194937D5E73EA29DB8@DBDE04.ent.ti.com>
 <5267690C.9080005@gmail.com> <20131023125516.GA2458@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20131023125516.GA2458@localhost>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Brian Norris <computersforpeace@gmail.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "tony@atomide.com" <tony@atomide.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "Balbi,
 Felipe" <balbi@ti.com>, "olof@lixom.net" <olof@lixom.net>, "robherring2@gmail.com" <robherring2@gmail.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "ivan.djelic@parrot.com" <ivan.djelic@parrot.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi,

> From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.com]
[...]
> FWIW, I have a Beaglebone with a 16-bit bus NAND attached to it.
> 
> Coincidentally, yesterday I was doing some tests as I'm ramping up the
> NAND and I found that weird double nand_scan_ident() call.
> The whole thing looks buggy to me, so I'm happy to help, review, test
> and patches to take care of this.
> 
Yes, thanks .. that would be of great help.. 
And may be your experience of Atmel drivers would help me here..

*Correct, should not be double calls to nand_scan_ident()..*
But there is a constrain in nand_base.c, that it does not allow ONFI
page reading in x16 mode.. So how to overcome that..

I see the similar implementation in your ATMEL driver, it does not use
NAND_BUSWIDTH_AUTO so how do you perform ONFI read
for x16 devices ?
drivers/mtd/nand/atmel_nand.c @@atmel_nand_probe()
/* here you move to x16 mode based on your DT or platform data */
	if (host->board.bus_width_16)	/* 16-bit bus width */
		nand_chip->options |= NAND_BUSWIDTH_16;
/* And then you call nand_scan_ident */
/* first scan to find the device and get the page size */
	if (nand_scan_ident(mtd, 1, NULL)) {
		res = -ENXIO;
		goto err_scan_ident;
	}

Wouldn't this fail, _unless_ your device is listed in nand_flash_id[] ?
because it would not be able to read ONFI params.. 
Refer below commit.. 
commit 0ce82b7f7b7373b16ecf7b5725e21e2975204500
Author:     Matthieu CASTET <matthieu.castet@parrot.com>
AuthorDate: 2013-01-16

Thanks for pitching in, this would help me to understand this better.



> I'm using some TI SDK with some ancient v3.2.x (with no git history!),
> but from this discussion it seems the issue is still present in
> mainline.
> 
Aah sorry, then you might have some problem here in rebasing the
patches. But still if you can, thanks much ..


with regards, pekon
______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
