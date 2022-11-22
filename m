Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB896C4332F
	for <linux-omap@archiver.kernel.org>; Tue, 22 Nov 2022 01:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKVBCn (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 21 Nov 2022 20:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiKVBCl (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 21 Nov 2022 20:02:41 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CBC1116F;
        Mon, 21 Nov 2022 17:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=W2nfk7sYOCq+1VT5YUgYpmiGCr6J+zO0iGjA64uRB3Y=; b=CBRArT89E3fBZWMJm/Fw3JaUjF
        4o2LvmWiG1XXMfjd2psFwHfHlCbxIhcavrGwYgG9ijVvhtkCGXjFt1y9Wy8FVUcD8Zr1JB5Kr5z6m
        GWxA0oKjLJm1WXFZRNBLXkEb559onnHSmVCL7GiGThV2rlnxwNIpP2JWWI7m4HJUdz6A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oxHgD-0034LU-Ao; Tue, 22 Nov 2022 02:02:29 +0100
Date:   Tue, 22 Nov 2022 02:02:29 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     Roger Quadros <rogerq@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] net: ethernet: ti: am65-cpsw-nuss: Remove
 redundant ALE_CLEAR
Message-ID: <Y3wfpd1p8zbyYByy@lunn.ch>
References: <20221121142300.9320-1-rogerq@kernel.org>
 <20221121142300.9320-3-rogerq@kernel.org>
 <Y3u6iSiJOgcy38cL@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3u6iSiJOgcy38cL@boxer>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Mon, Nov 21, 2022 at 06:51:05PM +0100, Maciej Fijalkowski wrote:
> On Mon, Nov 21, 2022 at 03:22:58PM +0100, Roger Quadros wrote:
> > ALE_CLEAR command is issued in cpsw_ale_start() so no need
> > to issue it before the call to cpsw_ale_start().
> > 
> > Fixes: fd23df72f2be ("net: ethernet: ti: am65-cpsw: Add suspend/resume support")
> 
> Not a fix to me, can you send it to -next tree? As you said, it's an
> optimization.

commit fd23df72f2be317d38d9fde0a8996b8e7454fd2a
Author: Roger Quadros <rogerq@kernel.org>
Date:   Fri Nov 4 15:23:07 2022 +0200

The change being fixed is in net-next.

Roger, please take a look at the netdev FAQ and fix your Subject line.

       Andrew
