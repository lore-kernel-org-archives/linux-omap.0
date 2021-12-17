Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21571C433FE
	for <linux-omap@archiver.kernel.org>; Fri, 17 Dec 2021 12:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhLQMO4 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 17 Dec 2021 07:14:56 -0500
Received: from muru.com ([72.249.23.125]:39476 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229891AbhLQMOz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 17 Dec 2021 07:14:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D549480FB;
        Fri, 17 Dec 2021 12:15:37 +0000 (UTC)
Date:   Fri, 17 Dec 2021 14:14:53 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     robh+dt@kernel.org, bcousson@baylibre.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: am335x-wega: Fix typo in mcasp property
 rx-num-evt
Message-ID: <Ybx/PQyBCVl+9Y9K@atomide.com>
References: <20211125105326.17000-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125105326.17000-1-j-choudhary@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Jayesh Choudhary <j-choudhary@ti.com> [211125 12:56]:
> Fix the property name 'rx-num-evt'.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
> The modification has not been tested. It needs to be tested
> to ensure that there are no regressions.

Thanks adding into omap-for-v5.17/fixes-not-urgent.

Tony
