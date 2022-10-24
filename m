Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2854FA373D
	for <linux-omap@archiver.kernel.org>; Mon, 24 Oct 2022 05:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJXFu7 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 24 Oct 2022 01:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJXFuy (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 24 Oct 2022 01:50:54 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4717542E54;
        Sun, 23 Oct 2022 22:50:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E8F748945;
        Mon, 24 Oct 2022 05:41:34 +0000 (UTC)
Date:   Mon, 24 Oct 2022 08:50:47 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-omap@vger.kernel.org,
        Cory Maccarrone <darkstar6262@gmail.com>,
        Fabrice Crohas <fcrohas@gmail.com>, linux-spi@vger.kernel.org
Subject: Re: [PATCH 16/17] spi: remove omap 100K driver
Message-ID: <Y1Ynt42XqQ4iFjpm@atomide.com>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-16-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019150410.3851944-16-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@kernel.org> [221019 15:12]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The OMAP7xx/OMAP8xx support was removed since all of its boards
> have no remaining users. Remove its spi driver as well.

Acked-by: Tony Lindgren <tony@atomide.com>
