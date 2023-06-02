Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86865C7EE24
	for <linux-omap@archiver.kernel.org>; Fri,  2 Jun 2023 09:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjFBJeK (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 2 Jun 2023 05:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbjFBJeH (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jun 2023 05:34:07 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7E6CCE;
        Fri,  2 Jun 2023 02:34:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9D5DE8111;
        Fri,  2 Jun 2023 09:34:05 +0000 (UTC)
Date:   Fri, 2 Jun 2023 12:34:04 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>
Cc:     linux-omap@vger.kernel.org, paul@pwsan.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: Re: [PATCH] ARM: omap2: Fix checkpatch issues
Message-ID: <20230602093404.GQ14287@atomide.com>
References: <20230531170427.42199-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531170427.42199-1-franziska.naepelt@gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Franziska Naepelt <franziska.naepelt@googlemail.com> [230531 20:04]:
> The following checkpatch issues have been resolved:
> 
> arch/arm/mach-omap2/omap-wakeupgen.c
> WARNING: Missing a blank line after declarations
> 
> arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> ERROR: space prohibited before that ',' (ctx:WxE)
> WARNING: Use lore.kernel.org archive links when possible
> 
> arch/arm/mach-omap2/omap_phy_internal.c
> WARNING: Block comments should align the * on each line
> 
> arch/arm/mach-omap2/sdrc2xxx.c
> WARNING: It's generally not useful to have the filename in the file
> 
> arch/arm/mach-omap2/ti81xx-restart.c
> ERROR: trailing statements should be on next line

Thanks applying into omap-for-v6.5/cleanup.

Tony
