From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v9 6/9] mtd: nand: omap: clean-up ecc layout for BCH
 ecc schemes
Date: Wed, 16 Oct 2013 19:06:58 -0700
Message-ID: <20131017020658.GB23337@ld-irv-0074.broadcom.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
 <1381816197-20477-7-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35117 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761431Ab3JQCHF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Oct 2013 22:07:05 -0400
Content-Disposition: inline
In-Reply-To: <1381816197-20477-7-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, olof@lixom.net, dedekind1@gmail.com, tony@atomide.com, bcousson@baylibre.com, robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Oct 15, 2013 at 11:19:54AM +0530, Pekon Gupta wrote:
> In current implementation omap3_init_bch_tail() is a common function to
> define ecc layout for different BCHx ecc schemes.This patch:
> (1) removes omap3_init_bch_tail() and defines ecc layout for individual
>     ecc-schemes along with populating their nand_chip->ecc data in
>     omap_nand_probe(). This improves the readability and scalability of
>     code for add new ecc schemes in future.
> (2) removes 'struct nand_bbt_descr bb_descrip_flashbased' because default
>     nand_bbt_descr in nand_bbt.c matches the same (.len=1 for x8 devices).
> (3) add the check to see if NAND device has enough OOB/Spare bytes to
>     store ECC signature of whole page, as defined by ecc-scheme.
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>

This patch also looks OK.

Brian
