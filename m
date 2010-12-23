From: Felipe Balbi <balbi@ti.com>
Subject: [GIT PULL] OMAP USB Changes for Merge Window
Date: Thu, 23 Dec 2010 10:47:34 +0200
Message-ID: <20101223084734.GA3149@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:56707 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752245Ab0LWIrj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 03:47:39 -0500
Received: by ewy27 with SMTP id 27so4112371ewy.0
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 00:47:37 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi Tony,

please queue the following two patches for Merge Window.

The following changes since commit b79540fcbbcf9b379c9197f63c5a883bbe3adfd4:

    Linux-omap rebuilt: Merged branches from Paul and Kevin and mux changes (2010-12-22 19:13:33 -0800)

are available in the git repository at:

    git://gitorious.org/usb/usb.git for-tony

Felipe Balbi (1):
        arm: omap: tusb6010: add name for MUSB IRQ

Srinath (1):
        arm: omap: craneboard: Add USB EHCI support

   arch/arm/mach-omap2/board-am3517crane.c |   48 +++++++++++++++++++++++++++++++
   arch/arm/mach-omap2/usb-tusb6010.c      |    1 +
   2 files changed, 49 insertions(+), 0 deletions(-)

-- 
balbi
