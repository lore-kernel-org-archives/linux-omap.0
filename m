From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 0/3] omap: n8x0: Audio update to N810
Date: Mon,  9 Aug 2010 10:58:57 +0300
Message-ID: <1281340740-10823-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54985 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab0HIH5s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 03:57:48 -0400
Received: by ewy23 with SMTP id 23so3345279ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 09 Aug 2010 00:57:47 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Hi

With this set and a fix [1] it is possible to get ALSA SoC on N810 working.

This set is generated against mainline commit e320cea but applies also to
linux-omap (board-n8x0.c has cbus patches in linux-omap).

-- 
Jarkko
1. http://marc.info/?l=linux-omap&m=128109830113485&w=2
