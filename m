Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDCAFA373D
	for <linux-omap@archiver.kernel.org>; Fri, 28 Oct 2022 00:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiJ1AlO (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 27 Oct 2022 20:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiJ1AlO (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 27 Oct 2022 20:41:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A034E60A;
        Thu, 27 Oct 2022 17:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EEA66255E;
        Fri, 28 Oct 2022 00:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88078C433C1;
        Fri, 28 Oct 2022 00:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666917672;
        bh=ppmtY7LtsXtOE0Tu82bTFljW5h5jmKFRbXlzY6mSSRc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fZwa0wu8kngOAvkpJDLYXMhLu2VlibkjLd8PW71+I1VY+PPr5SdTypeHyFBYCQ2aL
         P/T8l5y5i/Kim4Xpx6pA/kGwPEXRLJEUIrOwo1SIMTTJW6I8ZIRomnbyB4QeFTXLAK
         D8pNnNY2QANF42lGMg4pahbiiouh2l4Ywlm+pUXoH4L78bZJYkuJBxIiKo55sUsqsj
         Q2lWbt9ise5/+HC96aekxB5dd0tGYi99Z8AgWjOTP1q89KAFXprll0pOFsUdTNht8a
         9cWSE4H6d6Qeu3oEZwvOy9phDNkPdxr/B8dnvkjDe9VUlttIjaVsX8GafAwCJ+llBL
         iitQ4/aIws+Ew==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221017164646.4193618-1-dario.binacchi@amarulasolutions.com>
References: <20221017164646.4193618-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH] clk: ti: mux: don't free `parent_names' on kzalloc() failure
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 27 Oct 2022 17:41:09 -0700
User-Agent: alot/0.10
Message-Id: <20221028004112.88078C433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Quoting Dario Binacchi (2022-10-17 09:46:46)
> Although no operation is performed by kfree() on a NULL pointer, it's
> however suboptimal and semantically wrong doing it.

Passing NULL to kfree() is fine. This is trying to optimize an error
path as well. No thanks.
