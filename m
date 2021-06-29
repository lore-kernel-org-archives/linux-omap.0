Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432D2C11F66
	for <linux-omap@archiver.kernel.org>; Tue, 29 Jun 2021 12:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA8561DF0
	for <linux-omap@archiver.kernel.org>; Tue, 29 Jun 2021 12:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhF2M4b (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 29 Jun 2021 08:56:31 -0400
Received: from muru.com ([72.249.23.125]:58584 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232498AbhF2M4a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 29 Jun 2021 08:56:30 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C6DF580FC;
        Tue, 29 Jun 2021 12:54:13 +0000 (UTC)
Date:   Tue, 29 Jun 2021 15:53:58 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-omap@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH v2 3/3] arm: extend pfn_valid to take into accound freed
 memory map alignment
Message-ID: <YNsX5pyqNeRlwtyf@atomide.com>
References: <20210519141436.11961-1-rppt@kernel.org>
 <20210519141436.11961-4-rppt@kernel.org>
 <YNmiW6CYzy9lG8ks@atomide.com>
 <YNnLxFM4ZeQ5epX3@linux.ibm.com>
 <YNnqIv3PApHFZMgp@atomide.com>
 <YNqwl8EPVYZJV0EF@linux.ibm.com>
 <YNrfqtBpKsNj033w@atomide.com>
 <YNr6+wOiR7/Yx9M1@linux.ibm.com>
 <YNsJh7trg4up5l26@atomide.com>
 <YNsXDEgreCpshZxb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNsXDEgreCpshZxb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Mike Rapoport <rppt@linux.ibm.com> [210629 12:50]:
> On Tue, Jun 29, 2021 at 02:52:39PM +0300, Tony Lindgren wrote:
> > * Mike Rapoport <rppt@linux.ibm.com> [210629 10:51]:
> > > As it seems, the new version of pfn_valid() decides that last pages are not
> > > valid because of the overflow in memblock_overlaps_region(). As the result,
> > > __sync_icache_dcache() skips flushing these pages.
> > > 
> > > The patch below should fix this. I've left the prints for now, hopefully
> > > they will not appear anymore. 
> > 
> > Yes this allows the system to boot for me :)
> > 
> > I'm still seeing these three prints though:
> > 
> > ...
> > smp: Brought up 1 node, 2 CPUs
> > SMP: Total of 2 processors activated (3994.41 BogoMIPS).
> > CPU: All CPU(s) started in SVC mode.
> > pfn_valid(__pageblock_pfn_to_page+0x14/0xa8): pfn: afe00: is_map: 0 overlaps: 1
> > pfn_valid(__pageblock_pfn_to_page+0x28/0xa8): pfn: affff: is_map: 0 overlaps: 1
> > pfn_valid(__pageblock_pfn_to_page+0x38/0xa8): pfn: afe00: is_map: 0 overlaps: 1
> 
> These pfns do have memory map despite they are stolen in
> arm_memblock_steal():
> 
> memblock_free: [0xaff00000-0xafffffff] arm_memblock_steal+0x50/0x70
> memblock_remove: [0xaff00000-0xafffffff] arm_memblock_steal+0x5c/0x70
> ...
> memblock_free: [0xafe00000-0xafefffff] arm_memblock_steal+0x50/0x70
> memblock_remove: [0xafe00000-0xafefffff] arm_memblock_steal+0x5c/0x70
> 
> But the struct pages there are never initialized.
> 
> I'll resend v3 of the entire set with an addition patch to take care of
> that as well.

OK sounds good to me :)

Thanks,

Tony
