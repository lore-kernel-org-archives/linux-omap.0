Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9938CC001DB
	for <linux-omap@archiver.kernel.org>; Mon, 14 Aug 2023 10:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjHNKut convert rfc822-to-8bit (ORCPT
        <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 14 Aug 2023 06:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjHNKui (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 14 Aug 2023 06:50:38 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D3F4D2;
        Mon, 14 Aug 2023 03:50:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 8E54F80E0;
        Mon, 14 Aug 2023 10:50:36 +0000 (UTC)
Date:   Mon, 14 Aug 2023 13:50:35 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     bcousson@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: am335x-bone-common: Add GPIO PHY reset
 on revision C3 board
Message-ID: <20230814105035.GO11676@atomide.com>
References: <20230806085044.1917-1-wiagn233@outlook.com>
 <TY3P286MB26113797A3B2EC7E0348BBB2980FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230809072846.GD11676@atomide.com>
 <TY3P286MB2611D8048AC78466459C47759812A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20230810062717.GI11676@atomide.com>
 <TY3P286MB26110563ACD4C197532D0C8E9813A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <TY3P286MB26110563ACD4C197532D0C8E9813A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Shengyu Qu <wiagn233@outlook.com> [230810 13:48]:
> Hi Tony,
> 
> No commit is fixed by this, since this is a hardware design problem on
> 
> older revision board.  :(

OK no worries, I'll add both to omap-for-v6.5/fixes. Depending how the
current -rc cycle goes, it may not get merged until for v6.6-rc1 FYI.

Thanks,

Tony
