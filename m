Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8F1CDB47E
	for <linux-omap@archiver.kernel.org>; Wed, 18 Oct 2023 17:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjJRRwk (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 18 Oct 2023 13:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjJRRwj (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 18 Oct 2023 13:52:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5DF112;
        Wed, 18 Oct 2023 10:52:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5B0C433C7;
        Wed, 18 Oct 2023 17:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697651557;
        bh=pEMo/s1CYzAXTPRWhiJJZWc3Q7TNy0usITMHoUHBgzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fQvQZrbmuIBukMHt5kZ5fRWijKo2QPDyG6ixF8pVw3gBvDoUySHEd05VlWGIOJ+XW
         T3mnsgcSOG4K9qW5O+gb7T3tOmbUIBI+LG9JDcEciLFuy5aOQ1J1JX/v5xvquShwvl
         nbsJaphSqgUan5oKQtIBW8lfBwR2PvrcLTybLza5hYH0D+TTykjcrAtMn7TIu0E7Dw
         jWry0UXDwiX9quGh+KuG8+JgiegQGLkjATFMAYz5OpbQEIdcwQR9RMJ0+aPB4UaV2N
         vZBm27pASprqFHXvc7iU3PWVLl2nTcm7YCbe24ZVaKZLNRa/Qp6NUzKysbKgv3vZqu
         qvm/t3EgiCgbA==
Date:   Wed, 18 Oct 2023 10:52:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <rogerq@ti.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
        <horms@kernel.org>, <linux-omap@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <srk@ti.com>, Thejasvi Konduru <t-konduru@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: davinci_mdio: Fix the
 revision string for J721E
Message-ID: <20231018105236.347b2354@kernel.org>
In-Reply-To: <20231018154448.vlunpwbw67xeh4rj@unfasten>
References: <20231018140009.1725-1-r-gunasekaran@ti.com>
        <20231018154448.vlunpwbw67xeh4rj@unfasten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Wed, 18 Oct 2023 10:44:48 -0500 Nishanth Menon wrote:
> A) netdev maintainers could provide me an rc1 based immutable tag

FWIW that shouldn't be a problem, assuming my script to do so didn't
bit rot :)

Does it really have to be rc1 or something more recent would work?
