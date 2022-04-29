Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E2AC433F5
	for <linux-omap@archiver.kernel.org>; Fri, 29 Apr 2022 05:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347551AbiD2FfX (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 29 Apr 2022 01:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344891AbiD2FfX (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 29 Apr 2022 01:35:23 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0EC758388;
        Thu, 28 Apr 2022 22:32:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9AAE880C1;
        Fri, 29 Apr 2022 05:28:58 +0000 (UTC)
Date:   Fri, 29 Apr 2022 08:32:04 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jmkrzyszt@gmail.com, aaro.koskinen@iki.fi, vireshk@kernel.org,
        shiraz.linux.kernel@gmail.com, nsekhar@ti.com, brgl@bgdev.pl,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 5/6] ARM: omap2: fix missing declaration warnings
Message-ID: <Ymt4VG5NqZ2j4Uy1@atomide.com>
References: <20220428133210.990808-1-arnd@kernel.org>
 <20220428133210.990808-6-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428133210.990808-6-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@kernel.org> [220428 13:32]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Moving the plat-omap files triggered a sparse warning for omap1 and
> omap2 that is now in a different file from before. Found some more sparse
> warnings here that I address by making sure the declaration is visible
> to both the caller and the callee, or they are static

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
