From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP4: PRM: Correct reset source map
Date: Mon, 17 Dec 2012 20:52:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1212172050290.29833@utopia.booyaka.com>
References: <1355776640-369-1-git-send-email-ivan.khoronzhuk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39401 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432Ab2LQUwH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Dec 2012 15:52:07 -0500
In-Reply-To: <1355776640-369-1-git-send-email-ivan.khoronzhuk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>

Hi

On Mon, 17 Dec 2012, Ivan Khoronzhuk wrote:

> In the map for reset sources register we use defines intended for
> using with PRM_RSTCTRL register. So fix it.

your changes look good, but they are missing Signed-off-by: lines.  Could 
you please either resend with those, or confirm that you intended to add 
them?  You may wish to read Documentation/SubmittingPatches, particularly 
item 12.


- Paul
