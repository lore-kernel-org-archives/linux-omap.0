From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 0/2] Fixes in hwmod reset code
Date: Tue, 13 Mar 2012 08:22:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1203130819480.22211@utopia.booyaka.com>
References: <1331647435-31666-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57639 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137Ab2CMOWx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Mar 2012 10:22:53 -0400
In-Reply-To: <1331647435-31666-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Rajendra

On Tue, 13 Mar 2012, Rajendra Nayak wrote:

> This fixes a couple of issues around hwmod reset
> APIs'.
> Patches are based on 3.3.-rc7.
> 
> Rajendra Nayak (2):
>   ARM: omap: hwmod: Restore sysc after a reset
>   ARM: omap: hwmod: Make omap_hwmod_softreset wait for reset status
> 
>  arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++------------
>  1 files changed, 6 insertions(+), 12 deletions(-)

Could you base this on either my 'hwmod_code_cleanup_3.4' branch or 
'hwmod_enable_remaining_hwmods_devel_3.4' branch?  There are some reset 
changes in there also.


- Paul
