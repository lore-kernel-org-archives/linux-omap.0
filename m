From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCHv2 1/4] Regulator: OMAP: Creating TWL4030 file having
 supplies & init data
Date: Tue, 2 Mar 2010 16:19:07 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0321B9E00C@dbde02.ent.ti.com>
References: <1263287632-10135-1-git-send-email-anuj.aggarwal@ti.com>
 <20100205013959.GF22747@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59284 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752181Ab0CBKtT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 05:49:19 -0500
In-Reply-To: <20100205013959.GF22747@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Friday, February 05, 2010 7:10 AM
> To: Aggarwal, Anuj
> Cc: linux-omap@vger.kernel.org; broonie@opensource.wolfsonmicro.com;
> lrg@slimlogic.co.uk
> Subject: Re: [PATCHv2 1/4] Regulator: OMAP: Creating TWL4030 file having
> supplies & init data
> 
> Hi,
> 
> * Anuj Aggarwal <anuj.aggarwal@ti.com> [100112 01:12]:
> > A new file for TWL4030/TPS65950 is created which has common supplies
> > and regulator init data structures. They will be referenced from the
> > various board-evm files depending upon the EVM requirements, using
> > the twl4030-pmic.h header file.
> 
> Looks like this series needs to be rebased on omap-for-linus branch
> in the linux-omap tree. Please also check that the patches apply
> against the current for-next branch in the linux-omap tree.
> 
> Also, please check that each patch in the series builds (and boots)
> with arch/arm/config/omap3_defconfig.
Tony,

I have rebased the patch set (version 3) against for-next tip. I have
also checked that each patch builds (and boots) with omap3_defconfig
individually.

Please pull.

