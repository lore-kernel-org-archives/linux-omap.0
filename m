Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62BDC7EE2F
	for <linux-omap@archiver.kernel.org>; Fri,  2 Jun 2023 10:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbjFBKNT (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbjFBKNN (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jun 2023 06:13:13 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6BEFE7
        for <linux-omap@vger.kernel.org>; Fri,  2 Jun 2023 03:13:12 -0700 (PDT)
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id A3D318111;
        Fri,  2 Jun 2023 10:13:11 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     soc@kernel.org
Cc:     arm@kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Tony Lindgren" <tony@atomide.com>
Subject: [GIT PULL 1/3] Non-urgent driver fix for ti-sysc for v6.5
Date:   Fri,  2 Jun 2023 13:13:05 +0300
Message-ID: <pull-1685700720-242492@atomide.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

From: "Tony Lindgren" <tony@atomide.com>

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v6.5/ti-sysc-signed

for you to fetch changes up to f620596fa347170852da499e778a5736d79a4b79:

  bus: ti-sysc: Fix dispc quirk masking bool variables (2023-05-17 10:17:01 +0300)

----------------------------------------------------------------
Non-urgent ti-sysc driver fix for v6.5 merge window

A fix for masking bool variables that can wait for the merge window
no problem.

----------------------------------------------------------------
Tony Lindgren (1):
      bus: ti-sysc: Fix dispc quirk masking bool variables

 drivers/bus/ti-sysc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
