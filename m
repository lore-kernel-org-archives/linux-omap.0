Return-Path: <SRS0=u7e7=4P=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C6DC3567B
	for <linux-omap@archiver.kernel.org>; Thu, 27 Feb 2020 17:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75DD246AF
	for <linux-omap@archiver.kernel.org>; Thu, 27 Feb 2020 17:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgB0RgD (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:36:03 -0500
Received: from muru.com ([72.249.23.125]:58086 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbgB0RgD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 27 Feb 2020 12:36:03 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CB30180C0;
        Thu, 27 Feb 2020 17:36:47 +0000 (UTC)
Date:   Thu, 27 Feb 2020 09:35:59 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Dave Gerlach <d-gerlach@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: dts: am33xx/am4372: Add cpuidle dt states
Message-ID: <20200227173559.GH37466@atomide.com>
References: <20191213041725.16831-1-d-gerlach@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213041725.16831-1-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [191212 20:16]:
> Hi,
> This series adds DT idle states for TI am33xx and am4372 platforms.
> The mpu_gate is added for both platforms which gates the MPU clock
> to save power during idle. It depends on the driver series sent
> here [1].
> 
> Regards,
> Dave
> 
> [1] https://marc.info/?l=linux-kernel&m=157620644400324&w=2

Thanks applying into omap-for-v5.7/dt.

Regards,

Tony
