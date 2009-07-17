From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: android-omap-2.6.29 for gumstix overo
Date: Sat, 18 Jul 2009 01:27:25 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F56F1558@dbde02.ent.ti.com>
References: <3B4B1B95-38FA-4F26-8CD9-6A50346F9C76@mac.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F5679BDF@dbde02.ent.ti.com>
 <B78C377E-8474-4310-BAAF-1877111EA730@mac.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F5679BE1@dbde02.ent.ti.com>
 <44A80450-2A36-402C-9E41-940C0F400C89@mac.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F5679BEA@dbde02.ent.ti.com>
 <53FB694B-B432-4E7B-A2B1-42367D3741B3@mac.com>
 <FCCFB4CDC6E5564B9182F639FC35608702F56F1524@dbde02.ent.ti.com>
 <6E1CBACD-F7A7-45AB-9803-71A410B2D291@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36460 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053AbZGQT5l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jul 2009 15:57:41 -0400
In-Reply-To: <6E1CBACD-F7A7-45AB-9803-71A410B2D291@mac.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Elvis Dowson [mailto:elvis.dowson@mac.com]
>Sent: Friday, July 17, 2009 12:11 PM
>To: Pandita, Vikram
>Cc: Linux OMAP Users
>Subject: Re: android-omap-2.6.29 for gumstix overo
>Importance: High
>
>Hi Vikram,
>			I'm just facing a weird situation. I just deleted my local repo,
>and cloned the android-omap-2.6.29 branch once again, afresh,
>
>and still I do not get all the OMAP SRF updated to board-overo.c
>
>If I look at it right now, I get
>
>static void __init overo_init_irq(void)
>{
>	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
>	omap_init_irq();
>	omap_gpio_init();
>}
>
>It should actually be
>
>static void __init overo_init_irq(void)
>{
>	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, null, null, null);
>	omap_init_irq();
>	omap_gpio_init();
>}
>
>What could be going wrong?

The snapshot was taken from linux-omap:2.6.29 
Maybe overo file is not in sync. Check on pm-2.6.29 branch that is on kevin's tree.

>
>Best regards,
>
>Elvis
>

