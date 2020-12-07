Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA7AC433FE
	for <linux-omap@archiver.kernel.org>; Mon,  7 Dec 2020 14:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83CD6235DD
	for <linux-omap@archiver.kernel.org>; Mon,  7 Dec 2020 14:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgLGOBH (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 7 Dec 2020 09:01:07 -0500
Received: from muru.com ([72.249.23.125]:49838 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgLGOBG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 7 Dec 2020 09:01:06 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 32D298057;
        Mon,  7 Dec 2020 14:00:34 +0000 (UTC)
Date:   Mon, 7 Dec 2020 16:00:22 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: omap2plus_defconfig: enable SPI GPIO
Message-ID: <20201207140022.GB26857@atomide.com>
References: <20201201191237.15808-1-andreas@kemnade.info>
 <826AB7B5-E860-40D4-8E33-08F9FF820A98@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <826AB7B5-E860-40D4-8E33-08F9FF820A98@goldelico.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [201201 19:23]:
> 
> > Am 01.12.2020 um 20:12 schrieb Andreas Kemnade <andreas@kemnade.info>:
> > 
> > GTA04 uses that for controlling the td028ttec1 panel. So
> > for easier testing/bisecting it is useful to have it
> > enabled in the defconfig.
> 
> ++

Applying into omap-for-v5.11/defconfig-take2 thanks.

Tony
