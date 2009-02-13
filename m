From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RESEND] lp5521 patches
Date: Fri, 13 Feb 2009 14:43:46 +0200
Message-ID: <1234529032-25354-1-git-send-email-felipe.balbi@nokia.com>
References: <bdea5f5962eebe1bd420f184ebc7b32c@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19160 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbZBMM6q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2009 07:58:46 -0500
In-Reply-To: <bdea5f5962eebe1bd420f184ebc7b32c@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>

Hi Dave, all

could you look at the updated lp5521 patches ?

Basically patches from 1 to 3 are the same.
Patch 4 has the fix you asked me to implement, getting
a label from pdata (then I also moved mode and the presence
of each individual led to pdata as well), patch 5 only moves
the file to drivers/leds and patch 6 is a new patch adding
pdata to board-n800.c

After these, lp5521 should be ok for going upstream.

Thanks for your time ;-)

