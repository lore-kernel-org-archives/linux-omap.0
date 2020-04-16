Return-Path: <SRS0=0/1+=6A=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5A7C2BB55
	for <linux-omap@archiver.kernel.org>; Thu, 16 Apr 2020 18:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A5E2087E
	for <linux-omap@archiver.kernel.org>; Thu, 16 Apr 2020 18:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgDPSqo (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:46:44 -0400
Received: from muru.com ([72.249.23.125]:49822 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbgDPSqn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 16 Apr 2020 14:46:43 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 933BC804F;
        Thu, 16 Apr 2020 18:47:29 +0000 (UTC)
Date:   Thu, 16 Apr 2020 11:46:38 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Evgeniy Polyakov <zbr@ioremap.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Adam Ford <aford173@gmail.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCHv3] w1: omap-hdq: Simplify driver with PM runtime
 autosuspend
Message-ID: <20200416184638.GI37466@atomide.com>
References: <20191217004048.46298-1-tony@atomide.com>
 <7B8C7DD9-095B-48FC-9642-695D07B79E97@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7B8C7DD9-095B-48FC-9642-695D07B79E97@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [200416 15:04]:
> Hi Tony,
> it looks as if something with this patch is broken on GTA04. For v5.6 and v5.7-rc1.
> 
> HDQ battery access times out after ca. 15 seconds and I get temperature of -273.1°C...
> 
> Reverting this patch and everything is ok again.

Hmm OK interesting.

> What is "ti,mode" about? Do we have that (indirectly) in gta04.dtsi?
> Or does this patch need some CONFIGs we do not happen to have?

Sounds like you have things working though so there should be no
need for having ti,mode = "1w" in the dts.

> > 	pm_runtime_enable(&pdev->dev);
> > +	pm_runtime_use_autosuspend(&pdev->dev);
> > +	pm_runtime_set_autosuspend_delay(&pdev->dev, 300);

Care to check if changing pm_runtime_set_autosuspend_delay value
to -1 in probe makes the issue go away? Or change it manually
to -1 via sysfs.

If that helps, likely we have a missing pm_runtime_get_sync()
somewhere in the driver.

Regards,

Tony
