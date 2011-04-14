From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] Fixed gpio polarity of gpio USB-phy reset.
Date: Thu, 14 Apr 2011 13:32:55 +0300
Message-ID: <20110414103254.GC14319@legolas.emea.dhcp.ti.com>
References: <1302766303-1157-1-git-send-email-J.Kilb@phytec.de>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1302766303-1157-1-git-send-email-J.Kilb@phytec.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Kilb <J.Kilb@phytec.de>
Cc: linux-arm-kernel@lists.infradead.org, dbrownell@users.sourceforge.net, balbi@ti.com, gregkh@suse.de, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 14, 2011 at 09:31:43AM +0200, Juergen Kilb wrote:
> With commit 19403165 a main part of ehci-omap.c moved to
> drivers/mfd/omap-usb-host.c created by commit 17cdd29d.
> Due to this reorganisation the polarity used to reset the
> external USB phy changed and USB host doesn't recognize
> any devices.
> 
> Signed-off-by: Juergen Kilb <J.Kilb@phytec.de>

Judging by how ehci-omap.c was before moving the code:

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
