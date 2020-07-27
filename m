Return-Path: <SRS0=9aII=BG=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE310C433E1
	for <linux-omap@archiver.kernel.org>; Mon, 27 Jul 2020 06:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF8620759
	for <linux-omap@archiver.kernel.org>; Mon, 27 Jul 2020 06:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgG0GrN (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:47:13 -0400
Received: from muru.com ([72.249.23.125]:38132 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgG0GrM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 27 Jul 2020 02:47:12 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 6FB078107;
        Mon, 27 Jul 2020 06:47:10 +0000 (UTC)
Date:   Sun, 26 Jul 2020 23:47:16 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     David Shah <dave@ds0.me>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        "; kernel@pyra-handheld.com; Linux-OMAP" <linux-omap@vger.kernel.org>
Subject: Re: Lockup inside omap4_prminst_read_inst_reg on OMAP5 uEVM
Message-ID: <20200727064716.GA2811@atomide.com>
References: <115bcd43a5d01f2df26b58ffcd7e1a9f9e551c83.camel@ds0.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <115bcd43a5d01f2df26b58ffcd7e1a9f9e551c83.camel@ds0.me>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* David Shah <dave@ds0.me> [200726 17:59]:
> Hi all,
> 
> I am looking into random lockups - significantly rarer than once a day
> in typical usage, various patterns like lots of bursty network traffic
> increase frequency - that affect both the uEVM and the Pyra (also
> OMAP5432 based) on newer kernels (currently testing with 5.6 but I have
> seen lockups with 5.7 too).

Just wondering.. Is this with USB Ethernet or with WLAN?

Regards,

Tony
