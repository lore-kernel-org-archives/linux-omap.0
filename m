Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA611C47084
	for <linux-omap@archiver.kernel.org>; Tue, 25 May 2021 06:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5234613F9
	for <linux-omap@archiver.kernel.org>; Tue, 25 May 2021 06:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhEYGqA (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 25 May 2021 02:46:00 -0400
Received: from muru.com ([72.249.23.125]:60078 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231197AbhEYGp7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Tue, 25 May 2021 02:45:59 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3D5CB807E;
        Tue, 25 May 2021 06:44:35 +0000 (UTC)
Date:   Tue, 25 May 2021 09:44:26 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Suman Anna <s-anna@ti.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        devicetree@vger.kernel.org,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: mailbox: Convert omap-mailbox.txt binding
 to YAML
Message-ID: <YKycytr9RaqCMKhk@atomide.com>
References: <20210518172022.10562-1-s-anna@ti.com>
 <c666919f-cc10-3ca5-a1e3-5062c260e827@ti.com>
 <20210520000831.GA3927464@robh.at.kernel.org>
 <f60764c8-9100-0c8d-96d6-76689ed8acc6@ti.com>
 <CAL_JsqLxmGHK_AEdth3M7Uhw4+A+2wNTzw_j74tRLjfp6z+UXg@mail.gmail.com>
 <5b879123-4367-ef95-3239-4549fcc24501@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b879123-4367-ef95-3239-4549fcc24501@ti.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Suman Anna <s-anna@ti.com> [210520 23:07]:
> Tony,
> 
> Any chance you can add a 'ti-sysc' binding and address the 'segment' warnings
> for 5.14? Those alone should bring the warning numbers down drastically.

Sure I'll do that. However, from what I recall there are still tons of dts
clock warnings left for the legacy clocks.

Regards,

Tony
