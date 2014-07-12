From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv2 01/10] ARM: dts: OMAP2+: Add mailbox fifo and user
 information
Date: Sun, 13 Jul 2014 00:13:57 +0200
Message-ID: <20140712221357.GA17930@amd.pavel.ucw.cz>
References: <1405115083-52977-1-git-send-email-s-anna@ti.com>
 <1405115083-52977-2-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37343 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbaGLWN7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Jul 2014 18:13:59 -0400
Content-Disposition: inline
In-Reply-To: <1405115083-52977-2-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Fri 2014-07-11 16:44:34, Suman Anna wrote:
> The number of mailbox fifos and users (IP interrupts) are added
> to the Mailbox DT nodes on OMAP2420, OMAP2430, OMAP3, and OMAP5
> family of SoCs through the DT properties "ti,mbox-num-fifos" and
> "ti,mbox-num-users" properties. This data represents the same data
> that used to be represented in hwmod attribute data through the
> .num_fifos and .num_users fields previously.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>

Acked-by: Pavel Machek <pavel@ucw.cz>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
