Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0198BC48BD1
	for <linux-omap@archiver.kernel.org>; Fri, 11 Jun 2021 07:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB49E61364
	for <linux-omap@archiver.kernel.org>; Fri, 11 Jun 2021 07:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFKHbn (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 11 Jun 2021 03:31:43 -0400
Received: from muru.com ([72.249.23.125]:41800 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhFKHbm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 11 Jun 2021 03:31:42 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4565680BA;
        Fri, 11 Jun 2021 07:29:53 +0000 (UTC)
Date:   Fri, 11 Jun 2021 10:29:41 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Vignesh R <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 0/3] ARM: dts: ti: Fix DT warnings for ecap nodes
Message-ID: <YMMQ5eo8K/JwFZ64@atomide.com>
References: <20210601092457.5039-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601092457.5039-1-lokeshvutla@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [210601 12:25]:
> Fix DT warnings for all the ecap nodes on TI platforms. This is in
> preparation for converting pwm-tiecap documentation to YAML.

Applying into omap-for-v5.14/dt thanks.

Tony
