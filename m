Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9033C77B7D
	for <linux-omap@archiver.kernel.org>; Fri,  5 May 2023 08:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjEEIiU (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 5 May 2023 04:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjEEIiU (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 5 May 2023 04:38:20 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19EE51885E;
        Fri,  5 May 2023 01:38:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3D4C480FC;
        Fri,  5 May 2023 08:38:18 +0000 (UTC)
Date:   Fri, 5 May 2023 11:38:16 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BISECTED REGRESSION] OMAP1 GPIO breakage
Message-ID: <20230505083816.GQ14287@atomide.com>
References: <20230425173241.GF444508@darkstar.musicnaut.iki.fi>
 <20230425201117.457f224c@aktux>
 <20230425183857.GG444508@darkstar.musicnaut.iki.fi>
 <20230425212040.5a4d5b09@aktux>
 <20230425193637.GH444508@darkstar.musicnaut.iki.fi>
 <20230425215848.247a936a@aktux>
 <20230426071910.GE14287@atomide.com>
 <20230504055156.GO14287@atomide.com>
 <CACRpkdY9ShRATHa776KyzeArmQdKxdwGxJC11YnmhWiCdSGzEA@mail.gmail.com>
 <20230504144521.1b3a3574@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230504144521.1b3a3574@aktux>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [230504 12:45]:
> Hi,
> 
> On Thu, 4 May 2023 14:13:32 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > On Thu, May 4, 2023 at 7:52 AM Tony Lindgren <tony@atomide.com> wrote:
> > > * Tony Lindgren <tony@atomide.com> [230426 07:20]:  
> > > > Seems that we should just revert this patch for now and try again after
> > > > the issues have been fixed.  
> > >
> > > Looking at the proposed fixes being posted seems like they are quite
> > > intrusive.. How about we partially revert this patch so omap1 still
> > > uses static assigment of gpios?  
> > 
> > I think Andreas patch (commit 92bf78b33b0b463b00c6b0203b49aea845daecc8)
> > kind of describes the problem with that: the probe order is now unpredictable,
> > so if we revert the patch then that problem returns, but I don't know how
> > serious that problem is.
> > 
> well, I think we can even fully revert 92bf78b33b0b463b00c6b0203b49aea845daecc8
> after my patch
> 
> gpiolib: fix allocation of mixed dynamic/static GPIOs
> 
> is in as a short time solution. That should only leave unpredictable
> numbers of multiple dynamic gpio controllers.

OK thanks sounds good to me.

Regards,

Tony
