From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: board-ldp: add regulator info to get the microSD slot working again
Date: Mon, 30 Mar 2009 14:58:26 -0700
Message-ID: <200903301458.27104.david-b@pacbell.net>
References: <1238419507-14812-1-git-send-email-koen@beagleboard.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:39911 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753578AbZC3V6a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Mar 2009 17:58:30 -0400
In-Reply-To: <1238419507-14812-1-git-send-email-koen@beagleboard.org>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@beagleboard.org>
Cc: linux-omap@vger.kernel.org

Don't set up VSIM to power DAT4..DAT7 on boards,
like LDP, which only use DAT0..DAT3.

(That is, if this patch were correct, then it's
a bug that mmc[0].wires == 4 instead of 8...)

- Dave
