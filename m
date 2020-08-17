Return-Path: <SRS0=Bddr=B3=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F038C433E1
	for <linux-omap@archiver.kernel.org>; Mon, 17 Aug 2020 11:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D3F207DA
	for <linux-omap@archiver.kernel.org>; Mon, 17 Aug 2020 11:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHQL11 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:27:27 -0400
Received: from muru.com ([72.249.23.125]:40542 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgHQL1Z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 17 Aug 2020 07:27:25 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5C48780A3;
        Mon, 17 Aug 2020 11:27:24 +0000 (UTC)
Date:   Mon, 17 Aug 2020 14:27:51 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-omap@vger.kernel.org,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: logicpd-som-lv-baseboard: Fix missing video
Message-ID: <20200817112751.GH2994@atomide.com>
References: <20200814122441.2425966-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814122441.2425966-1-aford173@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [200814 15:24]:
> A previous commit removed the panel-dpi driver, which made the
> SOM-LV video stop working because it relied on the DPI driver
> for setting video timings.  Now that the simple-panel driver is
> available in omap2plus, this patch migrates the SOM-LV dev kits
> to use a similar panel and remove the manual timing requirements.
> A similar patch was already done and applied to the Torpedo family.

Thanks applying into fixes.

Tony
