Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD393C433FE
	for <linux-omap@archiver.kernel.org>; Thu, 21 Apr 2022 10:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388542AbiDUKvu (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 21 Apr 2022 06:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240995AbiDUKvt (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2022 06:51:49 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1BAE129836;
        Thu, 21 Apr 2022 03:49:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1CC728106;
        Thu, 21 Apr 2022 10:46:08 +0000 (UTC)
Date:   Thu, 21 Apr 2022 13:48:58 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-omap@vger.kernel.org, aford@beaconembedded.com,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: logicpd-som-lv: Move pinmuxing to
 peripheral nodes
Message-ID: <YmE2mhSqstTHykrN@atomide.com>
References: <20220303171818.11060-1-aford173@gmail.com>
 <20220303171818.11060-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303171818.11060-2-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [220303 19:17]:
> Move some pinmux references to their respective peripherals.
> This keeps the pins in safe-mode until they are requested.

Applying into omap-for-v5.19/dt thanks.

Tony
