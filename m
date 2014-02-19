From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/1] ARM: OMAP5: Fix reboot handling
Date: Wed, 19 Feb 2014 17:39:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1402191738320.8777@utopia.booyaka.com>
References: <1392592544-7884-1-git-send-email-vaibhav.bedia@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41738 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688AbaBSRjP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Feb 2014 12:39:15 -0500
In-Reply-To: <1392592544-7884-1-git-send-email-vaibhav.bedia@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Bedia <vaibhav.bedia@gmail.com>
Cc: tony@atomide.com, rnayak@ti.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, 16 Feb 2014, Vaibhav Bedia wrote:

> Use the correct register offset for issuing the
> reset command in OMAP5. Since dev_inst is set dynamically
> OMAP4 should not be affected by this change.
> 
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@gmail.com>

Thanks, queued for v3.14-rc with Lokesh's Tested-by:.


- Paul
