Return-Path: <SRS0=8dcx=7O=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C858C433E0
	for <linux-omap@archiver.kernel.org>; Mon,  1 Jun 2020 15:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E3C20810
	for <linux-omap@archiver.kernel.org>; Mon,  1 Jun 2020 15:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgFAPBp (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:01:45 -0400
Received: from muru.com ([72.249.23.125]:56606 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726073AbgFAPBp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 1 Jun 2020 11:01:45 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0B184804F;
        Mon,  1 Jun 2020 15:02:34 +0000 (UTC)
Date:   Mon, 1 Jun 2020 08:01:41 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     linux-omap@vger.kernel.org, kbuild-all@lists.01.org,
        "Andrew F . Davis" <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 2/5] bus: ti-sysc: Use optional clocks on for enable and
 wait for softreset bit
Message-ID: <20200601150141.GB37466@atomide.com>
References: <20200531193941.13179-3-tony@atomide.com>
 <202006011003.QfaxujI6%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006011003.QfaxujI6%lkp@intel.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* kbuild test robot <lkp@intel.com> [200601 02:21]:
> drivers/bus/ti-sysc.c: In function 'sysc_wait_softreset':
> >> drivers/bus/ti-sysc.c:228:6: warning: variable 'sysc_offset' set but not used [-Wunused-but-set-variable]
> 228 |  int sysc_offset, syss_offset, error = 0;
> |      ^~~~~~~~~~~

Oh thanks, I'll just drop sysc_offset from the patch then. Sounds like
I need to also update my cross compiler too to see these warnings.

Regards,

Tony

