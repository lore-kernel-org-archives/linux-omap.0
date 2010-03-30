From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 7/9] OMAP: Devkit8000: Fix wrong usb port on Devkit8000
Date: Tue, 30 Mar 2010 11:08:10 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032231D1BE@dbde02.ent.ti.com>
References: <1269435138-27192-1-git-send-email-weber@corscience.de>
 <1269435138-27192-8-git-send-email-weber@corscience.de>
 <20100324130001.GK29419@nokia.com> <20100329203432.GB31402@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59701 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242Ab0C3FiW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Mar 2010 01:38:22 -0400
In-Reply-To: <20100329203432.GB31402@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: ext Thomas Weber <weber@corscience.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Felipe Balbi wrote:
> On Wed, Mar 24, 2010 at 02:00:01PM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
> >On Wed, Mar 24, 2010 at 01:52:16PM +0100, ext Thomas Weber wrote:
> >>Disable the nonexistent ehci port on Devkit8000.
> >>
> >>Signed-off-by: Thomas Weber <weber@corscience.de>
> >
> >can anyone with this board available (other than Thomas of course)
> >please ack or nak the patch ?
> >
> >I don't have this board available.
> 
> nobody ??
> 

Why don't we just trust Thomas? After all, he added the
support for the board in the first place. ;)

The patch looks trivially obvious. If there's no USBHOST port2
in use on the board, there's certainly no problem disabling it.
With that assumption, this code is okay

If you really need an ack, feel free to add my:

Acked-by: Anand Gadiyar <gadiyar@ti.com>
