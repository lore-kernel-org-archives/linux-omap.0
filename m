Return-Path: <SRS0=VBw6=7F=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B67C433E1
	for <linux-omap@archiver.kernel.org>; Sat, 23 May 2020 18:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660BC208C7
	for <linux-omap@archiver.kernel.org>; Sat, 23 May 2020 18:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgEWSJ7 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sat, 23 May 2020 14:09:59 -0400
Received: from muru.com ([72.249.23.125]:55602 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbgEWSJ7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Sat, 23 May 2020 14:09:59 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D732780F3;
        Sat, 23 May 2020 18:10:48 +0000 (UTC)
Date:   Sat, 23 May 2020 11:09:55 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        kernel@pyra-handheld.com, letux-kernel@openphoenux.org,
        linux-omap@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] w1: omap-hdq: cleanup to add missing newline for
 some dev_dbg
Message-ID: <20200523180955.GE37466@atomide.com>
References: <cover.1590255176.git.hns@goldelico.com>
 <cd0d55749a091214106575f6e1d363c6db56622f.1590255176.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd0d55749a091214106575f6e1d363c6db56622f.1590255176.git.hns@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [200523 17:34]:
> Otherwise it will corrupt the console log during debugging.

Acked-by: Tony Lindgren <tony@atomide.com>
