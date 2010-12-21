From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 0/2] omap: rx51: Fix broken fb on RX51/N900
Date: Tue, 21 Dec 2010 19:25:33 +0200
Message-ID: <1292952335-21314-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:51969 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab0LURZ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 12:25:57 -0500
Received: by bwz16 with SMTP id 16so4816310bwz.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Dec 2010 09:25:56 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Hi

Commit 60d24ee "Added video data to support tvout on rx51" broke the
framebuffer on N900. Here are two patches where 1st one does a little cleanup
to be sync with the 2nd fixing the issue. I've tested that both tvout and lcd
are working.

-- 
Jarkko
