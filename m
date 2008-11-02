From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] serial: Flush posted write on 34xx to make 8250 work (Re:
Date: Sun,  2 Nov 2008 23:52:21 +0200
Message-ID: <1225662741-7175-1-git-send-email-notasas@gmail.com>
References: <20081102205019.GJ28924@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:8234 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086AbYKBVwi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Nov 2008 16:52:38 -0500
Received: by ey-out-2122.google.com with SMTP id 6so745794eyi.37
        for <linux-omap@vger.kernel.org>; Sun, 02 Nov 2008 13:52:34 -0800 (PST)
In-Reply-To: <20081102205019.GJ28924@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>

> does this work for you?
Works on Pandora, which had garbled text instead of no output at all.
