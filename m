Return-Path: <SRS0=EIKI=B5=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407C3C433E4
	for <linux-omap@archiver.kernel.org>; Wed, 19 Aug 2020 07:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2961B207DA
	for <linux-omap@archiver.kernel.org>; Wed, 19 Aug 2020 07:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHSHaE (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:30:04 -0400
Received: from muru.com ([72.249.23.125]:41016 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbgHSH3q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Wed, 19 Aug 2020 03:29:46 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3C18C807A;
        Wed, 19 Aug 2020 07:29:46 +0000 (UTC)
Date:   Wed, 19 Aug 2020 10:30:14 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Johnson CH Chen =?utf-8?B?KOmZs+aYreWLsyk=?= 
        <JohnsonCH.Chen@moxa.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: am335x: add common dtsi for MOXA UC-8100 series
Message-ID: <20200819073014.GD2994@atomide.com>
References: <HK2PR01MB3281D019E03891638F4B422AFA480@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK2PR01MB3281D019E03891638F4B422AFA480@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Johnson CH Chen (陳昭勳) <JohnsonCH.Chen@moxa.com> [200806 05:29]:
> Add am335x-moxa-uc-8100-common.dtsi for many products of MOXA UC-8100
> series, and remove common nodes from am335x-moxa-uc-8100-me-t.dts.

Thanks applying into omap-for-v5.10/dt.

Tony
