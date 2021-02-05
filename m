Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FA8C433E6
	for <linux-omap@archiver.kernel.org>; Fri,  5 Feb 2021 13:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1196B64FBC
	for <linux-omap@archiver.kernel.org>; Fri,  5 Feb 2021 13:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhBENU5 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 5 Feb 2021 08:20:57 -0500
Received: from vm6.ganeti.dyne.org ([195.169.149.119]:36716 "EHLO
        vm6.ganeti.dyne.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhBENSy (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2021 08:18:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: parazyd@dyne.org)
        with ESMTPSA id 3F840F604E8
Date:   Fri, 5 Feb 2021 14:17:36 +0100
From:   "Ivan J." <parazyd@dyne.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: omap2plus_defconfig: Update for dropped options.
Message-ID: <20210205131736.3jivrc5lln4t2onr@fq>
User-Agent: rp
References: <20210203113426.18964-1-parazyd@dyne.org>
 <20210203113426.18964-2-parazyd@dyne.org>
 <YBuankYwwMsG4MN9@atomide.com>
 <4b32f566-92ad-3c49-0453-b44df23f1384@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b32f566-92ad-3c49-0453-b44df23f1384@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Fri, Feb 05, 2021 at 03:15:00PM +0200, Grygorii Strashko wrote:
> 
> 
> On 04/02/2021 08:56, Tony Lindgren wrote:
> > * Ivan Jelincic <parazyd@dyne.org> [210203 13:35]:
> > > Update omap2plus_defconfig for options that have been dropped:
> > > 
> > > - SIMPLE_PM_BUS no longer selected.
> > 
> > Oh right, we now need to always select it. Will queue this for
> > fixes after the merge window. The other one I'll be queueing
> > for v5.13 as the merge window is about to open and I'll only
> > queue fixes for the next few weeks :)
> 
> "- MICREL_PHY no longer selected."
> 
> I do not agree with above as MICREL_PHY is selected by KS8851, but on many boards there is no
> explicit dependency from KS8851, but MICREL PHYs are in use.
> So, I'd prefer to have it enabled explicitly in omap2plus_defconfig.
> 
> And not sure what exactly "no longer selected" means.

"no longer selected" means it went away after `make savedefconfig`.

Best regards,
Ivan
