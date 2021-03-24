Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5387C433DB
	for <linux-omap@archiver.kernel.org>; Wed, 24 Mar 2021 11:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BB4619FB
	for <linux-omap@archiver.kernel.org>; Wed, 24 Mar 2021 11:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhCXLy1 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 24 Mar 2021 07:54:27 -0400
Received: from muru.com ([72.249.23.125]:46484 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhCXLyK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 24 Mar 2021 07:54:10 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A1B178117;
        Wed, 24 Mar 2021 11:55:02 +0000 (UTC)
Date:   Wed, 24 Mar 2021 13:54:02 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Carl Philipp Klemm <philipp@uvos.xyz>
Cc:     Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/5] ARM: dts: add battery phandle to cpcap_charger
Message-ID: <YFsoWjUYhhzo5Tdo@atomide.com>
References: <20210117224502.0f9a0e80dfd4841ad26a9914@uvos.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117224502.0f9a0e80dfd4841ad26a9914@uvos.xyz>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Carl Philipp Klemm <philipp@uvos.xyz> [210117 23:45]:
> --- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
> +++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
> @@ -61,6 +61,7 @@ &cpcap_adc 2 &cpcap_adc 5
>  			io-channel-names = "battdetb", "battp",
>  					   "vbus", "chg_isense",
>  					   "batti";
> +			battery = <&cpcap_battery>;
>  		};

This seems like good standard stuff to have, picking up this patch into
omap-for-v5.13/dt thanks.

Tony
