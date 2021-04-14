Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23565C433ED
	for <linux-omap@archiver.kernel.org>; Wed, 14 Apr 2021 15:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9797611C9
	for <linux-omap@archiver.kernel.org>; Wed, 14 Apr 2021 15:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhDNP7h (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 14 Apr 2021 11:59:37 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50802 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352677AbhDNP7X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 14 Apr 2021 11:59:23 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1lWhue-00GiQJ-96; Wed, 14 Apr 2021 17:58:44 +0200
Date:   Wed, 14 Apr 2021 17:58:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Vadym Kochan <vkochan@marvell.com>,
        Taras Chornyi <tchornyi@marvell.com>,
        Jiri Pirko <jiri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ivan Vecera <ivecera@redhat.com>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH net-next 2/2] net: bridge: switchdev: include local flag
 in FDB notifications
Message-ID: <YHcRNIgI9lVs6MDj@lunn.ch>
References: <20210414151540.1808871-1-olteanv@gmail.com>
 <20210414151540.1808871-2-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414151540.1808871-2-olteanv@gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

> Let us now add the 'is_local' bit to bridge FDB entries, and make all
> drivers ignore these entries by their own choice.

Hi Vladimir

This goes to the question about the missing cover letter. Why should
drivers get to ignore them, rather than the core? It feels like there
should be another patch in the series, where a driver does not
actually ignore them, but does something?

	 Andrew
