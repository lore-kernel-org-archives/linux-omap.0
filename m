From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/8] ARM: dts: OMAP5: ocp address space and few updates
Date: Fri, 15 Mar 2013 15:54:47 +0530
Message-ID: <5142F6EF.7010900@ti.com>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52448 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab3COKX1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Mar 2013 06:23:27 -0400
In-Reply-To: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Benoit,

On Wednesday 20 February 2013 09:08 PM, Santosh Shilimkar wrote:
> Few updates for OMAP5 found during testing OMAP5 DT builds. Couple
> of patches were already posted on the list. The series also contains
> a patch which adds DMA request, IRQ lines and IO address space 
> DT extraction support to hwmod code so that we can get rid of
> such information from hwmod data files. It has been tested on OMAP5
> and OMAP4 devices.
> 
[..]

>   ARM: OMAP: hwmod: extract module address space from DT blob
Above patch even though dt extraction code touches the hwmod file.
Are you ok to keep this patch is the current series considering
both the patches needs to go through your tree. If it needs to
be in separate branch, then I can add that as part of the
other generic patches with your ack.

>  arch/arm/boot/dts/omap5-evm.dts  |    2 +-
>  arch/arm/boot/dts/omap5.dtsi     |  282 +++++++++++++++++++++++++++++++++++---
>  arch/arm/mach-omap2/omap_hwmod.c |   31 ++++-
>  3 files changed, 293 insertions(+), 22 deletions(-)
> 

Let me know your preference. Either way is fine by me.

Regards,
Santosh

