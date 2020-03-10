Return-Path: <SRS0=sshs=43=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0680C10F27
	for <linux-omap@archiver.kernel.org>; Tue, 10 Mar 2020 18:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998A5208C3
	for <linux-omap@archiver.kernel.org>; Tue, 10 Mar 2020 18:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgCJScV (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:32:21 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:38929 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgCJScU (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2020 14:32:20 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 59EF3E0004;
        Tue, 10 Mar 2020 18:32:18 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 13/14] mtd: rawnand: ams-delta: Make the driver custom I/O ready
Date:   Tue, 10 Mar 2020 19:32:17 +0100
Message-Id: <20200310183217.19087-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200212003929.6682-14-jmkrzyszt@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: f789426780b4d3db466e23904bcbd2c3dec06841
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Wed, 2020-02-12 at 00:39:28 UTC, Janusz Krzysztofik wrote:
> In order to be merged with "gpio-nand", the driver must support custom
> (non-GPIO) I/O accessors.
> 
> Allow platforms to omit data GPIO port as well as NWE pin info from
> device setup.  For the driver to still work on such platform, custom
> I/O accessors as well as a custom probe function which initialises the
> driver private structure with those accessors must be added to the
> driver.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
