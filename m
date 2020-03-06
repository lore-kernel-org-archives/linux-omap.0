Return-Path: <SRS0=FBvQ=4X=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C12C3F2D6
	for <linux-omap@archiver.kernel.org>; Fri,  6 Mar 2020 16:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0CF21741
	for <linux-omap@archiver.kernel.org>; Fri,  6 Mar 2020 16:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCFQT7 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:19:59 -0500
Received: from muru.com ([72.249.23.125]:59078 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCFQT7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 6 Mar 2020 11:19:59 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 122998192;
        Fri,  6 Mar 2020 16:20:44 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>
Subject: [GIT PULL 4/4] dts changes for omaps for v5.7
Date:   Fri,  6 Mar 2020 08:19:50 -0800
Message-Id: <pull-1583511417-919838@atomide.com-4>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <pull-1583511417-919838@atomide.com>
References: <pull-1583511417-919838@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.7/dt-signed

for you to fetch changes up to 89a7b191fcd17e3f1dba963eb2cba8262b45a4d2:

  ARM: dts: am4372: Add idle_states for cpuidle (2020-02-27 09:33:33 -0800)

----------------------------------------------------------------
Devicetree changes for omaps for v5.7 merge window

Few device tree changes for omaps for v5.7 to configure omap5
AESS module and to add idle_states for am335x and am437x cpuidle.

----------------------------------------------------------------
Dave Gerlach (2):
      ARM: dts: am33xx: Add idle_states for cpuidle
      ARM: dts: am4372: Add idle_states for cpuidle

Tony Lindgren (1):
      ARM: dts: Configure omap5 AESS

 arch/arm/boot/dts/am33xx.dtsi       | 12 ++++++++++++
 arch/arm/boot/dts/am4372.dtsi       | 12 ++++++++++++
 arch/arm/boot/dts/omap5-l4-abe.dtsi | 16 ++++++++++++++--
 3 files changed, 38 insertions(+), 2 deletions(-)
