Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33434C001DC
	for <linux-omap@archiver.kernel.org>; Wed, 26 Jul 2023 15:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjGZPjT (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 26 Jul 2023 11:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjGZPjS (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jul 2023 11:39:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4504A1B0;
        Wed, 26 Jul 2023 08:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD6CC61B5D;
        Wed, 26 Jul 2023 15:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA2EC433C7;
        Wed, 26 Jul 2023 15:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690385957;
        bh=mIOGi0gBMHEqkGdNbDH6LW1lZ3Ao6lr4wjejxd0zmN4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rKGZlp8LCfTHU4nOTm5q1zIvNpqloNGZQT5n5WzPRJ02MVLq4ePApKs/YcHVrX+er
         KZ4/TCKkW1ETlfevpKlFrhg39pu0ZZ7roInTfdqAXsyrQE/yWMhiY8GVKqOoDWWiw0
         VPKwLJmW++zUTqwR3/16foXuKSOpXnIamtITS0RvoRuqM+obd2mOuKwpUrSTmQ/77K
         2wXRQkuq/RFwGkjunUqBUrXwfjnyZezX9sZ/tGD50YMPTJmyL71g62GrVMudd8mBY1
         9S2EevaUtdF0zxMdl37QDa1Gg+xQvDPbBtfUc/Auv5ypPDvrsadTPIB8eF2sMiAoot
         wEzY0euh6PYfw==
Date:   Wed, 26 Jul 2023 08:39:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Md Danish Anwar <a0501179@ti.com>
Cc:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXTERNAL] Re: [PATCH v11 07/10] net: ti: icssg-prueth: Add
 ICSSG Stats
Message-ID: <20230726083915.1323c501@kernel.org>
In-Reply-To: <296b0e98-4012-09f6-84cd-6f87a85f095f@ti.com>
References: <20230724112934.2637802-1-danishanwar@ti.com>
        <20230724112934.2637802-8-danishanwar@ti.com>
        <20230725205014.04e4bba3@kernel.org>
        <296b0e98-4012-09f6-84cd-6f87a85f095f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Wed, 26 Jul 2023 16:06:06 +0530 Md Danish Anwar wrote:
> > Are the bucket sizes configurable? Can we set the bucket sizes
> > to standard RMON ones and use ethtool RMON stats?  
> 
> The bucket sizes are not configurable. Bucket size is read from hardware and is
> fixed. I don't think we can configure bucket size and use ethtool RMON stats.
> It's better to dump bucket sizes via ethtool -S.

The buckets in the ethtool API are up to the device to define.
Driver returns bucket ranges via struct ethtool_rmon_hist_range
from struct ethtool_ops::get_rmon_stats.
