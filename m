From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Run make savedefconfig on omap2plus_defconfig
 to shrink it
Date: Thu, 10 Oct 2013 19:07:54 -0500
Message-ID: <5257415A.7090600@ti.com>
References: <20131010230325.8152.27727.stgit@localhost> <20131010230440.8152.29871.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38629 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066Ab3JKAIP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Oct 2013 20:08:15 -0400
In-Reply-To: <20131010230440.8152.29871.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

On Thursday 10 October 2013 06:04 PM, Tony Lindgren wrote:
> -CONFIG_TI_DAVINCI_MDIO=y
> -CONFIG_TI_DAVINCI_CPDMA=y
> -CONFIG_TI_CPSW=y
> -CONFIG_AT803X_PHY=y
Can you keep the above defines as AM335x EVM, Beagle bone, Beagle bone
black can use ethernet with omap2plus_defconfig

Regards
Mugunthan V N
