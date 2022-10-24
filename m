Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2B4C38A2D
	for <linux-omap@archiver.kernel.org>; Mon, 24 Oct 2022 05:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiJXFu3 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 24 Oct 2022 01:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJXFu2 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 24 Oct 2022 01:50:28 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 139303120D;
        Sun, 23 Oct 2022 22:50:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B337783BC;
        Mon, 24 Oct 2022 05:41:12 +0000 (UTC)
Date:   Mon, 24 Oct 2022 08:50:25 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, Helge Deller <deller@gmx.de>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-omap@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Angelo Arrifano <miknix@gmail.com>,
        Imre Deak <imre.deak@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 15/17] fbdev: omapfb: remove unused board support
Message-ID: <Y1YnoRYA2wfJ5qqF@atomide.com>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-15-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019150410.3851944-15-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@kernel.org> [221019 15:11]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A number of omap1 based board files got removed, so the corresponding
> framebuffer drivers are no longer used. The remaining ones are for
> ams_delta, osk and palmTE, which are still part of the mainline kernel.

Acked-by: Tony Lindgren <tony@atomide.com>
