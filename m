Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E631C43334
	for <linux-omap@archiver.kernel.org>; Mon, 27 Jun 2022 10:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiF0K5F (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 27 Jun 2022 06:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233852AbiF0K5E (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2022 06:57:04 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 055A9646F;
        Mon, 27 Jun 2022 03:57:04 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 23E3F8106;
        Mon, 27 Jun 2022 10:51:53 +0000 (UTC)
Date:   Mon, 27 Jun 2022 13:57:02 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: am33xx: Map baseboard EEPROM on BeagleBone
 Black
Message-ID: <YrmM/nCKXwcqK6n1@atomide.com>
References: <20220620152150.708664-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620152150.708664-1-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [220620 18:17]:
> The identification EEPROM on the BeagleBone Black baseboard is supplied
> by VDD_3V3A which is supplied by LDO4 on the PMIC. Map this as per the DT
> binding for the EEPROM. Since this supply is always-on this has no
> practical impact but it does silence a warning at boot due to using a dummy
> regulator.

Thanks applying into omap-for-v5.20/dt. Sorry looks like I missed your
earlier patch somehow.

Regards,

Tony
