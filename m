From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/12] Drop omap3 board files and make mach-omap2 boot
 in DT only mode
Date: Tue, 26 Nov 2013 08:25:03 -0800
Message-ID: <20131126162502.GD26766@atomide.com>
References: <1385424867-27243-1-git-send-email-tony@atomide.com>
 <52949790.1010900@epfl.ch>
 <20131126142530.GA32406@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26809 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756983Ab3KZQZL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 11:25:11 -0500
Content-Disposition: inline
In-Reply-To: <20131126142530.GA32406@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Sebastian Reichel <sre@debian.org> [131126 06:26]:
> Hi,
> 
> On Tue, Nov 26, 2013 at 01:44:00PM +0100, Florian Vaussard wrote:
> > IMHO one remaining issue is the missing binding for the camera interface
> > (ISP). I saw recently an RFC from Sebastian Reichel to add the necessary
> > binding [1], but this work will probably take some time. So probably a
> > quirk is necessary here to bring up this IP.
> 
> My DT patches for omap3-isp won't be ready for 3.14.

No problem, we can init omap3-isp with auxdata from pdata-quirks.c
meanwhile.

Regards,

Tony
