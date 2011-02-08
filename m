From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/3] OMAP4 static dependency support
Date: Tue, 8 Feb 2011 16:49:49 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102081644200.21991@utopia.booyaka.com>
References: <1297084631-27474-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45682 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924Ab1BHXtu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 18:49:50 -0500
In-Reply-To: <1297084631-27474-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

On Mon, 7 Feb 2011, Rajendra Nayak wrote:

> OMAP4 supports 2 type of domain dependency between clock
> domains. 

Thanks, queued for 2.6.39 in the 'clkdm_statdep_omap4_2.6.39' branch of 
git://git.pwsan.com/linux-2.6

I made a few minor changes to patch 3/3, will post those in reply to that 
patch.  

These patches are also added as part of the current integration branch 
'integration-2.6.39' of git://git.pwsan.com/linux-integration - a stable 
tag with these changes is tag 'integration-2.6.39-20110208-007'.


- Paul
