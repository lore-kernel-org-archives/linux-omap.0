From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v2 0/2] add parallel NAND support for TI's new OMAPx and
 AMxx platforms
Date: Thu, 27 Mar 2014 07:19:10 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EAB5FA6@DBDE04.ent.ti.com>
References: <1394617547-25240-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44550 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbaC0HTS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Mar 2014 03:19:18 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>

HI Tony,

>From: Gupta, Pekon
[...]
>I see following patches in your tree/branch  "omap-for-v3.15/dt"
>But probably they were omitted in the pull request. Is there something, I need to do for these ?
>
>	f68e355  2014-03-02  ARM: dts: am43xx: add support for parallel NAND flash
>	c06c527  2014-03-02  ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
>	91994fa  2014-03-02  ARM: dts: am335x-evm: NAND: update MTD partition table
>	0611c41  2014-03-02  ARM: OMAP2+: gpmc: update gpmc_hwecc_bch_capable() for new platforms and ECC schemes
>
>
>Also, I had sent a [v2] for one of the patches, dropped by you. Please see if that can be picked
>	[Patch v2 1/2] ARM: dts: dra7: add support for parallel NAND flash
>	[Patch v2 1/2] ARM: dts: am43xx: fix starting offset of NAND.filesystem MTD partition
>
>
Please let me know, if I need to rebase any of the patches in follow series
against your for_3.15/dt  or any other branch.

(1) [Partly Merged] "add parallel NAND support for TI's new OMAPx and AMxx platforms"
http://www.spinics.net/lists/linux-omap/msg104305.html

(2) [New Patches] "add parallel NAND support for TI's new OMAPx and AMxx platforms (part-2)"
http://www.spinics.net/lists/linux-omap/msg104668.html


with regards, pekon
