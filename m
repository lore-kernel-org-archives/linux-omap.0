From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: omap2plus_defconfig: Enable OHCI & EHCI HCD
 support
Date: Tue, 20 Jan 2015 09:51:18 -0800
Message-ID: <20150120175117.GI7718@atomide.com>
References: <1421702916-19018-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <20150119214148.GV20386@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30323 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbbATRyu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2015 12:54:50 -0500
Content-Disposition: inline
In-Reply-To: <20150119214148.GV20386@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [150119 13:45]:
> On Mon, Jan 19, 2015 at 10:28:36PM +0100, Sjoerd Simons wrote:
> > Enable CONFIG_USB_EHCI_HCD and CONFIG_USB_OHCI_HCD to get USB supports
> > with omap2plus_defconfig.
> > 
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>

Applying into omap-for-v3.20/defconfig thanks.

Tony
