From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap4: panda: remove usb_nop_xceiv_register(v1)
Date: Wed, 2 Feb 2011 13:57:49 +0200
Message-ID: <20110202115749.GD5370@legolas.emea.dhcp.ti.com>
References: <1294236201-4114-1-git-send-email-tom.leiming@gmail.com>
 <20110202113717.GC5370@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:36570 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752993Ab1BBL5z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 06:57:55 -0500
Received: by mail-gw0-f50.google.com with SMTP id a20so3453694gwa.37
        for <linux-omap@vger.kernel.org>; Wed, 02 Feb 2011 03:57:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110202113717.GC5370@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: tom.leiming@gmail.com, tony@atomide.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, arm-kernel@lists.infradead.org

On Wed, Feb 02, 2011 at 01:37:17PM +0200, Felipe Balbi wrote:
> Tony,
> 
> On Wed, Jan 05, 2011 at 10:03:21PM +0800, tom.leiming@gmail.com wrote:
> > From: Ming Lei <tom.leiming@gmail.com>
> > 
> > Panda uses both twl6030 otg phy(vbus, id) and internal
> > phy(data lines, DP/DM), so removes usb_nop_xceiv_register to make
> > twl6030 otg driver working since current otg code only supports
> > one global transceiver. Otherwise, musb doesn't work without
> > the remove.
> > 
> > Reviewd-by: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> 
> Care to queue this together with your fixes

Without this patch, MUSB doesn't work on pandaboard.

if you want in a pull request form, here it is:

The following changes since commit ebf53826e105f488f4f628703a108e98940d1dc5:

  Linux 2.6.38-rc3 (2011-02-01 13:05:49 +1000)

are available in the git repository at:
  git://gitorious.org/usb/usb.git for-tony

Ming Lei (1):
      arm: omap4: panda: remove usb_nop_xceiv_register(v1)

 arch/arm/mach-omap2/board-omap4panda.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)


-- 
balbi
