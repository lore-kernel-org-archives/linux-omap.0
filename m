Return-Path: <SRS0=kjZO=AD=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F92C433DF
	for <linux-omap@archiver.kernel.org>; Mon, 22 Jun 2020 15:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA932071A
	for <linux-omap@archiver.kernel.org>; Mon, 22 Jun 2020 15:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgFVP22 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:28:28 -0400
Received: from muru.com ([72.249.23.125]:58578 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbgFVP22 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 22 Jun 2020 11:28:28 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 40EDC8140;
        Mon, 22 Jun 2020 15:29:20 +0000 (UTC)
Date:   Mon, 22 Jun 2020 08:28:25 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Oskar Enoksson <enok@lysator.liu.se>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-omap@vger.kernel.org
Subject: Re: WL1271 on CM-T3730
Message-ID: <20200622152825.GK37466@atomide.com>
References: <807d19b0-842f-87b9-c9ba-dcbfd4e7b108@lysator.liu.se>
 <AD238A83-22FC-458D-9180-F715AD6A5237@goldelico.com>
 <d32e2c17-849a-4aa8-7f84-a84d9699789a@lysator.liu.se>
 <5166bacd-428d-168c-edf4-a322274deac6@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5166bacd-428d-168c-edf4-a322274deac6@lysator.liu.se>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Oskar Enoksson <enok@lysator.liu.se> [200621 22:01]:
> Correction: occasionally wl1271_sdio initialization still fails with error
> messages such as
> 
> [   46.961364] wl1271_sdio: probe of mmc1:0001:1 failed with error -16
> [   46.967834] wl1271_sdio: probe of mmc1:0001:2 failed with error -16
> 
> other times
> 
> [   27.302215][  T903] wl1271_sdio mmc1:0001:2: wl12xx_sdio_power_on: failed
> to get_sync(-22)
> 
> or
> root@pte2000:~# ifup wlan0
> [   53.799468][ T2420] wl1271_sdio mmc1:0001:2: wl12xx_sdio_power_on: failed
> to get_sync(-110)
> [   53.840118][ T2420] wl1271_sdio mmc1:0001:2: wl12xx_sdio_power_on: failed
> to get_sync(-22)
> [   53.879882][ T2420] wl1271_sdio mmc1:0001:2: wl12xx_sdio_power_on: failed
> to get_sync(-22)
> [   53.888610][ T2420] wlcore: ERROR firmware boot failed despite 3 retries
> RTNETLINK answers: Invalid argument
> ifup: failed to bring up wlan0

Maybe try changing the wl12xx_vmmc2 startup-delay-us to something
higher like 70000 we usually have?

Regards,

Tony
