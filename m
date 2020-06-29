Return-Path: <SRS0=sQ2K=AK=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A57C433E0
	for <linux-omap@archiver.kernel.org>; Mon, 29 Jun 2020 20:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F70F2065D
	for <linux-omap@archiver.kernel.org>; Mon, 29 Jun 2020 20:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgF2URH (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:17:07 -0400
Received: from muru.com ([72.249.23.125]:59968 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729266AbgF2TaK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:10 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 710FC81A7;
        Mon, 29 Jun 2020 17:04:53 +0000 (UTC)
Date:   Mon, 29 Jun 2020 10:03:58 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Rob Herring <robh+dt@kernel.org>, bcousson@baylibre.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] ARM: dts: am335x-pocketbeagle: set default mux for
 gpio pins
Message-ID: <20200629170358.GT37466@atomide.com>
References: <20200628152442.322593-1-drew@beagleboard.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628152442.322593-1-drew@beagleboard.org>
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

* Drew Fustini <drew@beagleboard.org> [200628 08:26]:
> v2 changes:
> - change default mux from output to input.  Input is safer as it does
>   not drive the line.  If the user wants output, they will need to edit
>   this device tree.

So can you please clarify this a bit, are you saying that gpio output can't
be done via userspace?

Needing to change the dts does not sound good to me.. But maybe you mean
this is needed until the gpio-omap and pinctrl-single patches are merged?

Regards,

Tony
