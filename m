Return-Path: <SRS0=KqvK=AN=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52781C433DF
	for <linux-omap@archiver.kernel.org>; Thu,  2 Jul 2020 16:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D18820720
	for <linux-omap@archiver.kernel.org>; Thu,  2 Jul 2020 16:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGBQkF (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:40:05 -0400
Received: from muru.com ([72.249.23.125]:60422 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGBQkF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 2 Jul 2020 12:40:05 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4BC318062;
        Thu,  2 Jul 2020 16:40:58 +0000 (UTC)
Date:   Thu, 2 Jul 2020 09:40:02 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Oskar Enoksson <enok@lysator.liu.se>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-omap@vger.kernel.org
Subject: Re: WL1271 on CM-T3730
Message-ID: <20200702164002.GM37466@atomide.com>
References: <807d19b0-842f-87b9-c9ba-dcbfd4e7b108@lysator.liu.se>
 <AD238A83-22FC-458D-9180-F715AD6A5237@goldelico.com>
 <d32e2c17-849a-4aa8-7f84-a84d9699789a@lysator.liu.se>
 <5166bacd-428d-168c-edf4-a322274deac6@lysator.liu.se>
 <20200622152825.GK37466@atomide.com>
 <c9c7fdbb-3f2b-ecf3-342a-179a9980beaf@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c7fdbb-3f2b-ecf3-342a-179a9980beaf@lysator.liu.se>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Oskar Enoksson <enok@lysator.liu.se> [200701 06:08]:
> Thanks for the hints. I did some experiments with increasing the
> startup-delay-us of wl12xx_vmmc2 but couldn't notice any effect.

Hmm OK.

Care to try setting the wlcore interrupt in the dts to
IRQ_TYPE_LEVEL_HIGH and see if that helps?

Also please check the interrupt line related pinctrl pull
settings, if there's an external pull resistor the internal
pull should be disabled for the interrupt line.

> I also tried other changes in the device tree, kernel command line arguments
> and kernel configuration, but I can't see any pattern in the result.
> Whatever I try the initialization very often still fails with errors as
> before. Occasionally I even get crashes such as:
> 
> > [    7.188934] mmc1: tried to HW reset card, got error -110
> > sysctl: cannot stat /proc/sys/net/ipv4/tcp_syncookies: No such file or directory
> > [    7.410125] ------------[ cut here ]------------
> > [    7.414825] WARNING: CPU: 0 PID: 10 at drivers/net/wireless/ti/wlcore/sdio.c:131 wl12xx_sdio_raw_write+0xa3/0x104 [wlcore_sdio]

Hmm maybe give a try for the wlcore ELP wakeup patches I just posted as:

PATCHv2 0/4] Improvments for wlcore irq and resume for v5.9

To me it seems that I'm not seeing any more wlcore firmware reboots
that I was occasionally seeing earlier. Not sure about that though,
I guess we have to wait and see.

Regards,

Tony
