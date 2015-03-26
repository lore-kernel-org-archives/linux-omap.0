From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND PATCH 2/2] bus: ocp2scp: SYNC2 value should be changed
 to 0x6
Date: Thu, 26 Mar 2015 10:50:35 -0700
Message-ID: <20150326175035.GC10805@atomide.com>
References: <1426591491-3685-1-git-send-email-kishon@ti.com>
 <1426591491-3685-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:40074 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbbCZRyz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Mar 2015 13:54:55 -0400
Content-Disposition: inline
In-Reply-To: <1426591491-3685-2-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, nsekhar@ti.com, nm@ti.com, praneeth@ti.com, Arnd Bergmann <arnd@arndb.de>

* Kishon Vijay Abraham I <kishon@ti.com> [150317 04:25]:
> As per the TRMs of AM572x, OMAP4430, OMAP4460, OMAP543x, the value of
> SYNC2 must be set to 0x6 in order to ensure correct operation.
> 
> So modified the SYNC2 value of OCP2SCP TIMING register to 0x6 in all the
> platforms that use OCP2SCP driver except AM437x. Also introduced a new
> compatible property since we don't want to modify the OCP2SCP TIMING
> register for AM437x.

OK thanks I'll apply both into omap-for-v4.1/fixes-not-urgent as
it seems we've gotten away with it for quite a few years now, and
I don't see any specific description of what these fix.

If that's not the case, please let me know.

Regards,

Tony
