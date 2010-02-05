From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 1/4] Regulator: OMAP: Creating TWL4030 file having
 supplies & init data
Date: Thu, 4 Feb 2010 17:39:59 -0800
Message-ID: <20100205013959.GF22747@atomide.com>
References: <1263287632-10135-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56245 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab0BEBja (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 20:39:30 -0500
Content-Disposition: inline
In-Reply-To: <1263287632-10135-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk

Hi,

* Anuj Aggarwal <anuj.aggarwal@ti.com> [100112 01:12]:
> A new file for TWL4030/TPS65950 is created which has common supplies
> and regulator init data structures. They will be referenced from the
> various board-evm files depending upon the EVM requirements, using
> the twl4030-pmic.h header file.

Looks like this series needs to be rebased on omap-for-linus branch
in the linux-omap tree. Please also check that the patches apply
against the current for-next branch in the linux-omap tree.

Also, please check that each patch in the series builds (and boots)
with arch/arm/config/omap3_defconfig.

Regards,

Tony

