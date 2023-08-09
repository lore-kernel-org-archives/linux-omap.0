Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A175AEB64DD
	for <linux-omap@archiver.kernel.org>; Wed,  9 Aug 2023 09:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjHIJbU (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 9 Aug 2023 05:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjHIJbS (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 9 Aug 2023 05:31:18 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B2B81FEF;
        Wed,  9 Aug 2023 02:31:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A6BEB8105;
        Wed,  9 Aug 2023 09:31:16 +0000 (UTC)
Date:   Wed, 9 Aug 2023 12:31:15 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        maemo-leste@lists.dyne.org
Subject: Re: [PATCH v3] bus: omap_l3_smx: identify timeout cause before
 rebooting
Message-ID: <20230809093115.GF11676@atomide.com>
References: <20230801192240.1063764-1-absicsz@gmail.com>
 <20230802133659.kelu7tfz27ovi364@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802133659.kelu7tfz27ovi364@mercury.elektranox.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.com> [230802 13:37]:
> Hi,
> 
> On Tue, Aug 01, 2023 at 09:22:40PM +0200, Sicelo A. Mhlongo wrote:
> > Identify and print the error source before rebooting the board due to an l3
> > timeout error. This is helpful when debugging, e.g. via serial.
> > 
> > Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
> > ---
> >  drivers/bus/omap_l3_smx.c | 21 ++++++++++-----------
> >  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> nice, adding features with a negative diffstat :)
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Great, I'll add this to omap-for-v6.6/ti-sysc branch. The omap_l3_smx
deals with interconnect related issues and is closely coupled with
ti-sysc driver.

Regards,

Tony
