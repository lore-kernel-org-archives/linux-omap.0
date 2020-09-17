Return-Path: <SRS0=y1lp=C2=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3342DC433E2
	for <linux-omap@archiver.kernel.org>; Thu, 17 Sep 2020 17:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9C2208E4
	for <linux-omap@archiver.kernel.org>; Thu, 17 Sep 2020 17:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QFp4HORQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgIQRik (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 17 Sep 2020 13:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgIQRfw (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 17 Sep 2020 13:35:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51182C061756;
        Thu, 17 Sep 2020 10:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4maTmDv4AP9a2BVWoeVpaTsF7J85VdHKVOCXW2UepmM=; b=QFp4HORQVPspQyGcNMbSL/1M6h
        1sRHDmXrzXxAaFTyenkhdDUzIMqP/3+LRa350pLnLpT27G2DmCVVkxHUjnP33eNWr1Xe/Ns7Bvptw
        vOPfeREcXNIfZqhfq8jWWDP0i0ha8XUbevEgNwzzX/Y1e0aFpnylsDHlGF3R0u+iYrWP+M6dA0XrE
        iYAo6gjMsKD6ohHAWMaam19wPmRXH9esO6hN7Lel1JKz9Df1pKIq1/nEtH9JMN98jM/CTg7Ximrup
        IcCrMulugPrDBiaLexpCbwKTzRuGq9nAw4/d0fvsBfSnenDIsLffBWaspUXE/HOhiaP5vI2OcA790
        CPS34y1A==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIxns-0002tg-8A; Thu, 17 Sep 2020 17:34:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Subject: RFC: remove the need for <asm/dma-direct.h> on ARM
Date:   Thu, 17 Sep 2020 19:32:25 +0200
Message-Id: <20200917173229.3311382-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi Russell,

as Robin pointed out there is not much need for the ARM specific
routines to translated to and from a dma_addr_t given that we have
the dma offset (and now offset range) functionality.  This series
converts ARM over to the generic helpers.  This has only been tested
on qemu, and specificall not on omap1 and footbridge given that I
do not have the hardware.

The patches are on to of the dma-mapping for-next tree, to make
review and testing easier a git tree is also available here:

    git://git.infradead.org/users/hch/misc.git arm-dma-direct-cleanups

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/arm-dma-direct-cleanups


Diffstat:
 arch/arm/include/asm/dma-direct.h                |   66 -----------------------
 b/arch/arm/Kconfig                               |    1 
 b/arch/arm/common/dmabounce.c                    |   14 ++--
 b/arch/arm/include/asm/memory.h                  |    2 
 b/arch/arm/mach-footbridge/cats-pci.c            |    7 +-
 b/arch/arm/mach-footbridge/common.c              |   40 ++++++++++---
 b/arch/arm/mach-footbridge/common.h              |    3 +
 b/arch/arm/mach-footbridge/ebsa285-pci.c         |    7 +-
 b/arch/arm/mach-footbridge/include/mach/memory.h |    4 -
 b/arch/arm/mach-footbridge/netwinder-pci.c       |    7 +-
 b/arch/arm/mach-footbridge/personal-pci.c        |    7 +-
 b/arch/arm/mach-omap1/include/mach/memory.h      |   31 ----------
 b/arch/arm/mach-omap1/usb.c                      |   22 +++++++
 b/arch/arm/mm/dma-mapping.c                      |   20 +++---
 14 files changed, 91 insertions(+), 140 deletions(-)
