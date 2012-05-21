From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 14/19] ARM: OMAP4: wakeupgen: enable clocks for
 save_secure_all
Date: Mon, 21 May 2012 12:35:06 +0300
Message-ID: <1337592906.28274.16.camel@sokoban>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	 <1336990730-26892-15-git-send-email-t-kristo@ti.com>
	 <alpine.DEB.2.00.1205161809230.2921@utopia.booyaka.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45635 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932386Ab2EUJfP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:35:15 -0400
In-Reply-To: <alpine.DEB.2.00.1205161809230.2921@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Wed, 2012-05-16 at 18:17 -0600, Paul Walmsley wrote:
> Hi Tero
> 
> On Mon, 14 May 2012, Tero Kristo wrote:
> 
> > save_secure_all needs l3_main_3_ick and l4_secure_clkdm enabled,
> > otherwise the secure ROM code will crash.
> 
> Do we know why the l3_main_3 interconnect has to be enabled?  Is this 
> needed to access some L3 or instrumentation registers?

Not sure, ROM code is doing something here which requires it, and the
ROM code definitely crashes without this. Your guess sounds plausible.

-Tero


