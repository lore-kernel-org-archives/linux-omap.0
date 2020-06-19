Return-Path: <SRS0=zfJz=AA=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF01C433DF
	for <linux-omap@archiver.kernel.org>; Fri, 19 Jun 2020 15:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6303820809
	for <linux-omap@archiver.kernel.org>; Fri, 19 Jun 2020 15:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405330AbgFSPsM (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:48:12 -0400
Received: from utopia.booyaka.com ([74.50.51.50]:37698 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393431AbgFSPZc (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jun 2020 11:25:32 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jun 2020 11:25:32 EDT
Received: (qmail 29577 invoked by uid 1019); 19 Jun 2020 15:18:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Jun 2020 15:18:50 -0000
Date:   Fri, 19 Jun 2020 15:18:50 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Chen Tao <chentao107@huawei.com>
cc:     tony@atomide.com, linux@armlinux.org.uk,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP2+: Fix possible memory leak in
 omap_hwmod_allocate_module
In-Reply-To: <20200619104240.55978-1-chentao107@huawei.com>
Message-ID: <alpine.DEB.2.21.999.2006191518380.26224@utopia.booyaka.com>
References: <20200619104240.55978-1-chentao107@huawei.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Fri, 19 Jun 2020, Chen Tao wrote:

> Fix memory leak in omap_hwmod_allocate_module not freeing in
> handling error path.
> 
> Fixes: 8c87970543b17("ARM: OMAP2+: Add functions to allocate module data from device tree")
> Signed-off-by: Chen Tao <chentao107@huawei.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>

- Paul
