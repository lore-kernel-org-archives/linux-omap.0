Return-Path: <SRS0=y1lp=C2=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C115C433E2
	for <linux-omap@archiver.kernel.org>; Thu, 17 Sep 2020 18:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C86302075B
	for <linux-omap@archiver.kernel.org>; Thu, 17 Sep 2020 18:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cC6pZQe6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgIQSun (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 17 Sep 2020 14:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgIQSug (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 17 Sep 2020 14:50:36 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7F6C06174A;
        Thu, 17 Sep 2020 11:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Q8VF9smAnRjFS0P3NC4Izw/nS3vTJ+bH1/J/rL7LP4=; b=cC6pZQe6zDxvf3f3ImKC0hNfP
        bWOfQlntbC48RzdQlXmr0LDkFSGL155T3CXmkwUBSHr/bcLSi0CYDn2SoBczcYa+kmmqzXTSJ2nRx
        XsK7xC91w/HB6/h0gINjtU8jIfXRlmhmDNr/wUAq8rHhHYjjjZHbu3UKV7HgAKf46Z3f/SYigOp5y
        5Ey9q185lXCbLXSK7YU074l9W8DCEwv9D99S4BJD2GyKk4jWAxwW2khYrhcNhJ6nblq9Jug7N+9tg
        VKZIMQ2hyta3ahZvH/dVKBo5JoQdXrJXOwTFiNvtSVY6sqMxeGgnsbH5kAq+FOqttlhVNqxQd2ah5
        xnrLyTd/g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34894)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kIyz6-00065L-Je; Thu, 17 Sep 2020 19:50:20 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kIyyw-0005xb-3Z; Thu, 17 Sep 2020 19:50:10 +0100
Date:   Thu, 17 Sep 2020 19:50:10 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 3/4] ARM/dma-mapping: don't handle NULL devices in
 dma-direct.h
Message-ID: <20200917185009.GB1559@shell.armlinux.org.uk>
References: <20200917173229.3311382-1-hch@lst.de>
 <20200917173229.3311382-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917173229.3311382-4-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Thu, Sep 17, 2020 at 07:32:28PM +0200, Christoph Hellwig wrote:
> The DMA API removed support for not passing in a device a long time
> ago, so remove the NULL checks.

What happens with ISA devices?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
