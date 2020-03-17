Return-Path: <SRS0=+36Y=5C=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF7EC10F29
	for <linux-omap@archiver.kernel.org>; Tue, 17 Mar 2020 17:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E157A2073E
	for <linux-omap@archiver.kernel.org>; Tue, 17 Mar 2020 17:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCQRBo (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:01:44 -0400
Received: from muru.com ([72.249.23.125]:60646 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbgCQRBo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 17 Mar 2020 13:01:44 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8B79A810D;
        Tue, 17 Mar 2020 17:02:29 +0000 (UTC)
Date:   Tue, 17 Mar 2020 10:01:40 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     hch@lst.de, robin.murphy@arm.com, robh+dt@kernel.org, nm@ti.com,
        t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@kernel.org
Subject: Re: [PATCH] ARM: dts: omap5: Add bus_dma_limit for L3 bus
Message-ID: <20200317170140.GM37466@atomide.com>
References: <20200316102731.15467-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316102731.15467-1-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [200316 03:28]:
> The L3 interconnect's memory map is from 0x0 to
> 0xffffffff. Out of this, System memory (SDRAM) can be
> accessed from 0x80000000 to 0xffffffff (2GB)
> 
> OMAP5 does support 4GB of SDRAM but upper 2GB can only be
> accessed by the MPU subsystem.
> 
> Add the dma-ranges property to reflect the physical address limit
> of the L3 bus.

Thanks applying into fixes.

Tony
