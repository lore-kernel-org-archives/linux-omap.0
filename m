Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61ECC4320A
	for <linux-omap@archiver.kernel.org>; Thu, 12 Aug 2021 07:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADDA360EB2
	for <linux-omap@archiver.kernel.org>; Thu, 12 Aug 2021 07:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhHLHES (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 12 Aug 2021 03:04:18 -0400
Received: from muru.com ([72.249.23.125]:42468 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhHLHES (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Thu, 12 Aug 2021 03:04:18 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id A10D380EE;
        Thu, 12 Aug 2021 07:04:12 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>
Subject: [GIT PULL 2/3] Drop pm_runtime_irq_safe() for smartreflex for v5.15
Date:   Thu, 12 Aug 2021 10:03:43 +0300
Message-Id: <pull-1628751694-126144@atomide.com-2>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <pull-1628751694-126144@atomide.com>
References: <pull-1628751694-126144@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit fdc07ca0724dd8ad00c22909a1464dc73ed6783e:

  Merge branch 'omap-for-v5.14/ti-sysc' into omap-for-v5.15/ti-sysc (2021-07-27 12:02:24 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.15/sr-signed

for you to fetch changes up to 74953a9136cfd650dd994daded520528f737b7b3:

  soc: ti: Remove pm_runtime_irq_safe() usage for smartreflex (2021-08-06 09:53:59 +0300)

----------------------------------------------------------------
Drop pm_runtime_irq_safe() usage for smartreflex for v5.15

We now have cleard pm_runtime_irq_safe() usage for all TI SoCs
in Linux next except for smartreflex and 8250_omap. This change
removes pm_runtime_irq_safe() usage for smartreflex, the
8250_omap depends on pending serial layer PM changes.

----------------------------------------------------------------
Tony Lindgren (1):
      soc: ti: Remove pm_runtime_irq_safe() usage for smartreflex

 drivers/bus/ti-sysc.c             |  6 ++---
 drivers/soc/ti/smartreflex.c      | 52 +++++++++++++++++----------------------
 include/linux/power/smartreflex.h |  2 ++
 3 files changed, 26 insertions(+), 34 deletions(-)
