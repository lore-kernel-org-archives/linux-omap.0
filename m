Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E477CC64E7C
	for <linux-omap@archiver.kernel.org>; Fri, 27 Nov 2020 07:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A362222A
	for <linux-omap@archiver.kernel.org>; Fri, 27 Nov 2020 07:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392738AbgK0Hib (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 27 Nov 2020 02:38:31 -0500
Received: from muru.com ([72.249.23.125]:49422 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387909AbgK0Hib (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 27 Nov 2020 02:38:31 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id B0AA580FB;
        Fri, 27 Nov 2020 07:38:37 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>
Subject: [GIT PULL 3/3] Defconfig changes for omaps for v5.11 merge window
Date:   Fri, 27 Nov 2020 09:38:21 +0200
Message-Id: <pull-1606462656-588116@atomide.com-3>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <pull-1606462656-588116@atomide.com>
References: <pull-1606462656-588116@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.11/defconfig-signed

for you to fetch changes up to eaf7697b6febe2b086503f525f070d8e3ca1ea0f:

  ARM: omap2plus_defconfig: Enable TI eQEP counter driver (2020-11-24 11:04:12 +0200)

----------------------------------------------------------------
Defconfig changes for omaps for v5.11 merge window

- Enable thermal support for omap3 now that the driver changes have
  been merged

- Enable magnetometer and accelerometer support as loadable modules
  for Motorola mapphone devices

- Enable eQEP counter for beaglebone blue as loadable modules

----------------------------------------------------------------
Adam Ford (1):
      ARM: omap2plus_defconfig: Enable OMAP3_THERMAL

Carl Philipp Klemm (1):
      ARM: omap2plus_defconfig: add CONFIG_AK8975=m and CONFIG_KXCJK1013=m

David Lechner (1):
      ARM: omap2plus_defconfig: Enable TI eQEP counter driver

 arch/arm/configs/omap2plus_defconfig | 5 +++++
 1 file changed, 5 insertions(+)
