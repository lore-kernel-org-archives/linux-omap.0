Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF95C433E9
	for <linux-omap@archiver.kernel.org>; Tue, 26 Jan 2021 12:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD8D23120
	for <linux-omap@archiver.kernel.org>; Tue, 26 Jan 2021 12:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392357AbhAZMFK (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:05:10 -0500
Received: from muru.com ([72.249.23.125]:53262 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390381AbhAZLZU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 26 Jan 2021 06:25:20 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 855D9814C;
        Tue, 26 Jan 2021 11:24:36 +0000 (UTC)
Date:   Tue, 26 Jan 2021 13:24:29 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Alexander Shiyan <shc_work@mail.ru>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH] ARM: dts: am335x-myirtech-*: Add DT for AM335X MYIR Tech
 Limited board
Message-ID: <YA/77XX8hMxAMUIL@atomide.com>
References: <20210125105011.7887-1-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125105011.7887-1-shc_work@mail.ru>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Alexander Shiyan <shc_work@mail.ru> [210125 12:50]:
> This patch adds basic support for MYIR Tech MYC-AM335X CPU Module:
> - Up to 1GHz TI AM335X Series ARM Cortex-A8 Processors
> - Up to 512MB DDR3 SDRAM
> - Up to 512MB Nand Flash
> 
> and MYD-AM335X Development Board:
> - MYC-AM335X CPU Module as Controller Board
> - Serial ports, 4 x USB Host, OTG, 2 x Gigabit Ethernet, CAN, RS485,
>   TF, Audio
> - Supports HDMI and LCD Display

Thanks applying into omap-for-v5.12/dt.

Tony
