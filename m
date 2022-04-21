Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CB8C433EF
	for <linux-omap@archiver.kernel.org>; Thu, 21 Apr 2022 11:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388737AbiDULLw (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 21 Apr 2022 07:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388757AbiDULLr (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 21 Apr 2022 07:11:47 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7D832D1FC;
        Thu, 21 Apr 2022 04:08:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B247D8106;
        Thu, 21 Apr 2022 11:06:05 +0000 (UTC)
Date:   Thu, 21 Apr 2022 14:08:55 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Gireesh.Hiremath@in.bosch.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, robh+dt@kernel.org,
        bcousson@baylibre.com, sjoerd.simons@collabora.co.uk,
        VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
Subject: Re: [PATCH 00/15] am335x, guardian: update board specific dts changes
Message-ID: <YmE7R3eVO6070X5H@atomide.com>
References: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325100613.1494-1-Gireesh.Hiremath@in.bosch.com>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

* Gireesh.Hiremath@in.bosch.com <Gireesh.Hiremath@in.bosch.com> [220325 12:04]:
> From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> 
> update guardian device tree

Thanks applying into omap-for-v5.19/dt.

Few ideas for future though.

Not sure how you handle the nand partition table changes.. Seems the partition
values in the devicetree should not change in general.

The node names in devicetree should not use "_" but "-" instead. And the node
names should be general like you mostly already have. Anyways, we have a lot
of these especially for pinctrl, but we may want to clean them up eventually.
Just FYI.

Regards,

Tony
