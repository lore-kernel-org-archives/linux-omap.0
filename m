From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.15-rc8
Date: Mon, 9 Jun 2014 05:46:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406090543001.21441@utopia.booyaka.com>
References: <alpine.DEB.2.02.1406020749100.21503@utopia.booyaka.com> <538C39BB.9020809@compulab.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59555 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752793AbaFIFqO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jun 2014 01:46:14 -0400
In-Reply-To: <538C39BB.9020809@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel-build-reports@lists.infradead.org

On Mon, 2 Jun 2014, Dmitry Lifshitz wrote:

> CM-T3517 is a bare-bone CoM without MMC/SD card slot (NAND option).
> MMC/SD card interface (and some other peripherals) are properties of the
> carrier base board SB-T35, which turns this CoM into fully functional board
> SBC-T3517.
> 
> Please, use omap3-sbc-t3517.dtb target.
> 
> Attached Linux v3.15-rc8 boot log using omap2plus_defconfig.

Thanks.  My mistake.  Here's the updated bootlog for that board for 
v3.15-rc8:

http://www.pwsan.com/omap/testlogs/test_v3.15-rc8/20140608202958/boot/cmt3517/cmt3517_log.txt

- Paul
