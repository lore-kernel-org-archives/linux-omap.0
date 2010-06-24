From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 7/8] musb: Kill board specific pinmux from driver file
Date: Thu, 24 Jun 2010 11:46:28 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032366AE3D@dbde02.ent.ti.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-5-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-6-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-7-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-8-git-send-email-ajay.gupta@ti.com>
 <20100624061146.GJ8078@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34743 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273Ab0FXGQn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 02:16:43 -0400
In-Reply-To: <20100624061146.GJ8078@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "gregkh@suse.de" <gregkh@suse.de>

Felipe Balbi wrote:
> On Thu, Jun 17, 2010 at 12:40:40PM +0200, ext Ajay Kumar Gupta wrote:
> >From: Anand Gadiyar <gadiyar@ti.com>
> >
> >This pin-muxing is best done in the board files. The driver should
> >not do this explicitly.
> >
> >Also, this code causes a warning to be thrown when OMAP2430 and OMAP3/4
> >support are enabled in the same kernel.
> >
> >Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> >Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> 
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> 
> Note this is not a bugfix, so should wait until next merge window.
> 

It's a bug-fix to the extent that it caused a WARN() to be triggered
at bootup. But it's not serious and can wait.

- Anand