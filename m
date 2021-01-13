Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAADC433E0
	for <linux-omap@archiver.kernel.org>; Wed, 13 Jan 2021 17:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B803923406
	for <linux-omap@archiver.kernel.org>; Wed, 13 Jan 2021 17:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbhAMR3c (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 13 Jan 2021 12:29:32 -0500
Received: from muru.com ([72.249.23.125]:44732 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbhAMR3c (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 13 Jan 2021 12:29:32 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2AD4B80A7;
        Wed, 13 Jan 2021 17:28:50 +0000 (UTC)
Date:   Wed, 13 Jan 2021 19:28:47 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH 13/18] ARM: dts: Use simple-pm-bus for genpd for am3
 l4_wkup
Message-ID: <X/8tz/2v4bnbF0TZ@atomide.com>
References: <20201026112222.56894-1-tony@atomide.com>
 <20201026112222.56894-14-tony@atomide.com>
 <CAMuHMdWribr=eg1LkKce=Hamm+JwSz5UFEXLKUmKkqqz1RpL_w@mail.gmail.com>
 <X/8ei0o9ULpRdx7T@atomide.com>
 <CAMuHMdW+y5Y+0U1beebq7EGiarBKYdHszL+vW5r4xG6HBspVgQ@mail.gmail.com>
 <X/8kDzoADvcnNHxC@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/8kDzoADvcnNHxC@atomide.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [210113 16:48]:
> * Geert Uytterhoeven <geert@linux-m68k.org> [210113 16:42]:
> > On Wed, Jan 13, 2021 at 5:23 PM Tony Lindgren <tony@atomide.com> wrote:
> > > Strange, bbb has been working for me with NFSroot, that's with
> > > omap2plus_defconfig. Care to send your .config so I can give it a
> > > try tomorrow?
> > 
> > Sent by private email.
> 
> OK thanks.
> 
> > Just tried omap2plus_defconfig, and it also hangs during boot.

Hmm and I just tried and bbb still boots NFSroot for me at commit
5a230524f879 ("ARM: dts: Use simple-pm-bus for genpd for am3 l4_wkup").

> Hmm OK. Will give it a try tomorrow.

Later,

Tony
