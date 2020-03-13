Return-Path: <SRS0=/C/u=46=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73726C10DCE
	for <linux-omap@archiver.kernel.org>; Fri, 13 Mar 2020 14:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC382074F
	for <linux-omap@archiver.kernel.org>; Fri, 13 Mar 2020 14:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgCMOlk (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:41:40 -0400
Received: from muru.com ([72.249.23.125]:60008 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgCMOlk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 13 Mar 2020 10:41:40 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CA6AD8087;
        Fri, 13 Mar 2020 14:42:25 +0000 (UTC)
Date:   Fri, 13 Mar 2020 07:41:36 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     hch@lst.de, robin.murphy@arm.com, robh+dt@kernel.org, nm@ti.com,
        t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH v2] ARM: dts: dra7: Add bus_dma_limit for L3 bus
Message-ID: <20200313144136.GA37466@atomide.com>
References: <20200313094717.6671-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313094717.6671-1-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [200313 02:48]:
> The L3 interconnect's memory map is from 0x0 to
> 0xffffffff. Out of this, System memory (SDRAM) can be
> accessed from 0x80000000 to 0xffffffff (2GB)
> 
> DRA7 does support 4GB of SDRAM but upper 2GB can only be
> accessed by the MPU subsystem.
> 
> Add the dma-ranges property to reflect the physical address limit
> of the L3 bus.
> 
> Issues ere observed only with SATA on DRA7-EVM with 4GB RAM
> and CONFIG_ARM_LPAE enabled. This is because the controller
> supports 64-bit DMA and its driver sets the dma_mask to 64-bit
> thus resulting in DMA accesses beyond L3 limit of 2G.
> 
> Setting the correct bus_dma_limit fixes the issue.

Thanks applying into fixes.

Tony
