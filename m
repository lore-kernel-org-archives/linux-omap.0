Return-Path: <SRS0=ohbF=4Q=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45862C3F2CD
	for <linux-omap@archiver.kernel.org>; Fri, 28 Feb 2020 17:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E72246A0
	for <linux-omap@archiver.kernel.org>; Fri, 28 Feb 2020 17:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgB1RM2 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:12:28 -0500
Received: from muru.com ([72.249.23.125]:58202 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgB1RM2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
        Fri, 28 Feb 2020 12:12:28 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 6FDF0806C;
        Fri, 28 Feb 2020 17:13:12 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>, ruleh <ruleh@gmx.de>
Subject: [PATCHv2 0/3] Lost key-up interrupt handling for omap4-keypad
Date:   Fri, 28 Feb 2020 09:12:20 -0800
Message-Id: <20200228171223.11444-1-tony@atomide.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi all,

This series updates omap4-keypad to configure the interrupt level and
disables unused long interrupts. And then it implements the missing parts
for the lost key-up interrupt quirk as described in the silicon errata pdf.

I can still reproduce one issue where a fast shift-shift-j can produce an
upper case J instead of j for example. This seems unrelated to the controller
idling with state issue probably, maybe it's some debouncing related issue.
So far playing with the debouncing configuration has not helped with this
issue though. Anyways, please test if you're seeing stuck keys on droid4.

Regards,

Tony


Tony Lindgren (3):
  Input: omap4-keypad - configure interrupt as level
  Input: omap4-keypad - disable unused long interrupts
  Input: omap4-keypad - check state again for lost key-up interrupts

 drivers/input/keyboard/omap4-keypad.c | 64 ++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 10 deletions(-)

-- 
2.25.1
