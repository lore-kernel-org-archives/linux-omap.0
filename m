Return-Path: <SRS0=SDee=CS=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984F8C43461
	for <linux-omap@archiver.kernel.org>; Wed,  9 Sep 2020 05:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638B2215A4
	for <linux-omap@archiver.kernel.org>; Wed,  9 Sep 2020 05:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgIIF51 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 9 Sep 2020 01:57:27 -0400
Received: from muru.com ([72.249.23.125]:44330 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIIF50 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 9 Sep 2020 01:57:26 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9F6B580A4;
        Wed,  9 Sep 2020 05:57:23 +0000 (UTC)
Date:   Wed, 9 Sep 2020 08:58:05 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz,
        "David S. Miller" <davem@davemloft.net>, guido.gunther@puri.sm,
        konradybcio@gmail.com, arnd@arndb.de, martin.botka1@gmail.com
Subject: Re: Mailing list about low levels of Linux on cellphones
Message-ID: <20200909055805.GB2747@atomide.com>
References: <20200908225610.GA25399@duo.ucw.cz>
 <20200908230833.GA27644@Gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908230833.GA27644@Gentoo>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Bhaskar Chowdhury <unixbhaskar@gmail.com> [200908 23:08]:
> On 00:56 Wed 09 Sep 2020, Pavel Machek wrote:
> > Would it be possible to create a mailing list on vger.kernel.org?
> > Probably phones@ or phone-devel@? I believe it would be useful to
> > cover hardware-dependend pieces of the phone stack (ofono,
> > modemmanager) as well as kernel.

Good idea, probably phone-devel list would be better for Linux kernel
stuff.

Regards,

Tony
