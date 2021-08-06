Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07CF6C4338F
	for <linux-omap@archiver.kernel.org>; Fri,  6 Aug 2021 06:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2D6611C9
	for <linux-omap@archiver.kernel.org>; Fri,  6 Aug 2021 06:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241771AbhHFGbx (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 6 Aug 2021 02:31:53 -0400
Received: from muru.com ([72.249.23.125]:36910 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229581AbhHFGbw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 6 Aug 2021 02:31:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8A3508061;
        Fri,  6 Aug 2021 06:31:56 +0000 (UTC)
Date:   Fri, 6 Aug 2021 09:31:35 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-omap@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Paul Barker <paul.barker@sancloud.com>,
        linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2] ARM: dts: am335x-bone: switch to new cpsw switch drv
Message-ID: <YQzXR19MOwrJFL2S@atomide.com>
References: <20210805230956.7379-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805230956.7379-1-grygorii.strashko@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [210806 02:10]:
> The dual_mac mode has been preserved the same way between legacy and new
> driver, and one port devices works the same as 1 dual_mac port - it's safe
> to switch drivers.
> 
> So, Switch BeagleBone boards to use new cpsw switch driver. Those boards
> have or 2 Ext. port wired and configured in dual_mac mode by default, or
> only 1 Ext. port.
> 
> For am335x-sancloud-bbe-common.dtsi also removed duplicated davinci_mdio DT
> nodes which already defined in am335x-bone-common.dtsi.

Applying this too into omap-for-v5.15/dt.

Regards,

Tony
