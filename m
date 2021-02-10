Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AD8C433E0
	for <linux-omap@archiver.kernel.org>; Wed, 10 Feb 2021 23:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB51964ED7
	for <linux-omap@archiver.kernel.org>; Wed, 10 Feb 2021 23:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbhBJXe6 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 10 Feb 2021 18:34:58 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:48210 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhBJXeu (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2021 18:34:50 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 7D8694D25BDAF;
        Wed, 10 Feb 2021 15:34:07 -0800 (PST)
Date:   Wed, 10 Feb 2021 15:34:06 -0800 (PST)
Message-Id: <20210210.153406.1774734837784815987.davem@davemloft.net>
To:     olteanv@gmail.com
Cc:     kuba@kernel.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org,
        roopa@nvidia.com, nikolay@nvidia.com, jiri@resnulli.us,
        idosch@idosch.org, claudiu.manoil@nxp.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        vkochan@marvell.com, tchornyi@marvell.com,
        grygorii.strashko@ti.com, ioana.ciornei@nxp.com,
        ivecera@redhat.com, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 net-next 07/11] net: prep switchdev drivers for
 concurrent SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210210091445.741269-8-olteanv@gmail.com>
References: <20210210091445.741269-1-olteanv@gmail.com>
        <20210210091445.741269-8-olteanv@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Wed, 10 Feb 2021 15:34:08 -0800 (PST)
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>
Date: Wed, 10 Feb 2021 11:14:41 +0200

> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> Because the bridge will start offloading SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
> while not serialized by any lock such as the br->lock spinlock, existing
> drivers that treat that attribute and cache the brport flags might no
> longer work correctly.
> 
> The issue is that the brport flags are a single unsigned long bitmask,
> and the bridge only guarantees the validity of the changed bits, not the
> full state. So when offloading two concurrent switchdev attributes, such
> as one for BR_LEARNING and another for BR_FLOOD, it might happen that
> the flags having BR_FLOOD are written into the cached value, and this in
> turn disables the BR_LEARNING bit which was set previously.
> 
> We can fix this across the board by keeping individual boolean variables
> for each brport flag. Note that mlxsw and prestera were setting the
> BR_LEARNING_SYNC flag too, but that appears to be just dead code, so I
> removed it.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>


This needs updating because, as discussed, there is no race.
