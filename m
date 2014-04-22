From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH v3 0/3] ARM: OMAP2+: AM437x: L2 cache support
Date: Tue, 22 Apr 2014 14:20:43 -0400
Message-ID: <5356B2FB.5090205@ti.com>
References: <cover.1398149526.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48308 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811AbaDVSVL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 14:21:11 -0400
In-Reply-To: <cover.1398149526.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

On Tuesday 22 April 2014 04:28 AM, Sekhar Nori wrote:
> This patch series adds L2 cache support for AM437x
> and does some clean-ups for existing OMAP4 support
> along the way (no functional changes). On OMAP4 Panda,
> the Aux control value remains 0x7e470000 before and
> after the series.
> 
> Tested on OMAP4 Panda and AM437x EPOS EVMs.
> 
> It is based on RMK's 75 patch series titled "l2c series" +
> the patch contained in https://www.mail-archive.com/linux-omap@vger.kernel.org/msg103439.html
> 
> Sekhar Nori (3):
>   ARM: OMAP2+: L2 cache: get rid of init call
>   ARM: OMAP2+: L2 cache: git rid of redundant cache replacement policy
>     setting
>   ARM: OMAP2+: AM43x: L2 cache support
> 
For the whole series,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

