Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9AFC433F5
	for <linux-omap@archiver.kernel.org>; Fri, 11 Mar 2022 03:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343915AbiCKDcn (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 10 Mar 2022 22:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346146AbiCKDcl (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2022 22:32:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CE1F47F6;
        Thu, 10 Mar 2022 19:31:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD0B361380;
        Fri, 11 Mar 2022 03:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EBEC340EC;
        Fri, 11 Mar 2022 03:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646969453;
        bh=yQgLT6INXh2ZDqOeSIO/CGHPppSnFK0VrabHlonfxZw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HLP295bS1Im2TiL53dVHkMH6bEPrJCMVx79fjX3jXZf81GGT2ClPGqz89rVmXBX2F
         Ack1iy7eB8s9y9AqjcoMTNGTLgT4d2M1xQJEUuS5MS4SpTCpVzq9Vi+uNaG274lZtF
         D0VIBSMC725Ctg4cfK5Keee5ebwbeNewYCRxwxgQ1t8CPUIR7cHgH0YRee/BHnN9Bo
         ghnyd4XpWcULUG1oK1vPTcepWM7HiuW753YlUuViU2trLhLoj3msKOHRuf3N/75z5b
         RIlfnx7Lg8IUhXJdyZkj0k9C8YEsJ21XAYwTvCQKDq9WYMDZZDJLRbkwDu6qu4jOU1
         zFlh297NZJubg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220204071449.16762-2-tony@atomide.com>
References: <20220204071449.16762-1-tony@atomide.com> <20220204071449.16762-2-tony@atomide.com>
Subject: Re: [PATCH 1/8] clk: ti: Constify clkctrl_name
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org
To:     Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org
Date:   Thu, 10 Mar 2022 19:30:51 -0800
User-Agent: alot/0.10
Message-Id: <20220311033053.09EBEC340EC@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Quoting Tony Lindgren (2022-02-03 23:14:42)
> We can constify clkctrl_name in preparation for making use of the
> clock-output-names property.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Applied to clk-next
