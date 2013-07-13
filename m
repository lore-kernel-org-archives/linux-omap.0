From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v5 0/4] mtd:nand:omap2: clean-up of supported ECC schemes
Date: Sat, 13 Jul 2013 21:13:16 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9E7FDB@DBDE04.ent.ti.com>
References: <1373748891-7779-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36216 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab3GMVOG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Jul 2013 17:14:06 -0400
In-Reply-To: <1373748891-7779-1-git-send-email-pekon@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "dedekind1@gmail.com" <dedekind1@gmail.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>, "N, Mugunthan V" <mugunthanvnm@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "benoit.cousson@linaro.org" <benoit.cousson@linaro.org>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>

> 
> Changes v4 -> v5
> - Rebased to linux-next
> IMPORTANT: Need to revert commit fb1585b, [PATCH 2/4] part of previous
> version
> 	http://lists.infradead.org/pipermail/linux-mtd/2013-July/047441.html
> 
> - Swapped PATCH-1 & PATCH-2 to maintain bisectibility & compilation
> dependency
> 	http://lists.infradead.org/pipermail/linux-mtd/2013-July/047461.html
> 
> - PATCH-2: re-ordered call to is_elm_present() for later updates ELM driver
> 	- dropped changes in include/linux/platform_data/elm.h (not
> needed)
> - PATCH-3: re-ordered call to is_elm_present() for later updates ELM driver
> - Re-formated patch description (replaced tabs with white-spaces)
> 

Hi Olof, Arnd,

I have re-submitted patch with minor updates and re-ordered PATCH-1 & 2
to preserve bisectibility. And there is no comment | objection from
maintainers about the DT bindings. So request you to please Ack | Review
this series for it to be picked by Artem | David Woodhouse in MTD tree.

Also please revert commit fb1585b in linux-next, as its left-over piece of
same series v4.

- This series is the base for further clean-up of omap2-nand driver, hence
its important for it to be up-streamed for future work.


with regards, pekon


