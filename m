Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D3EEB64D7
	for <linux-omap@archiver.kernel.org>; Fri, 30 Jun 2023 07:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjF3HW6 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 30 Jun 2023 03:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjF3HW5 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jun 2023 03:22:57 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A329D10EC;
        Fri, 30 Jun 2023 00:22:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1B0A380FE;
        Fri, 30 Jun 2023 07:22:56 +0000 (UTC)
Date:   Fri, 30 Jun 2023 10:22:54 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeroen Hofstee <jhofstee@victronenergy.com>
Subject: Re: [RESEND][PATCH] net: cpsw: fix obtaining mac address for am3517
Message-ID: <20230630072254.GL14287@atomide.com>
References: <20230624121211.19711-1-mans@mansr.com>
 <ad0ec6ac-2760-4a03-8cee-0d933aea98eb@lunn.ch>
 <yw1x352h3plc.fsf@mansr.com>
 <457ae95b-8838-4c10-821c-379ed622ef41@lunn.ch>
 <yw1xy1k92ahj.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xy1k92ahj.fsf@mansr.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

* Måns Rullgård <mans@mansr.com> [230624 14:36]:
> Andrew Lunn <andrew@lunn.ch> writes:
> > I assume you also want this back ported to stable? Please add a Fixed:
> > tag, and a Cc: stable@vger.kernel.org tag. And set the patch subject
> > to [PATCH net v3] to indicate this is for the net tree, not net-next.
> 
> I give up.  It's not worth my time.  This is why people hoard patches
> rather than sending them upstream.

Maybe just give it one more go filing the proper paperwork :) It would be
nice to have it in stable too so IMO it's worth the few more hoops to
addthe tags for automating picking it to stable kernels.

Regards,

Tony
