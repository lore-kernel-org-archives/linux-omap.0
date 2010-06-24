From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 5/8] usb: musb: fix Blackfin ulpi stubs
Date: Thu, 24 Jun 2010 09:10:04 +0300
Message-ID: <20100624061004.GH8078@nokia.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-2-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-3-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-4-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-5-git-send-email-ajay.gupta@ti.com>
 <1276771242-5201-6-git-send-email-ajay.gupta@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29175 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab0FXGMb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 02:12:31 -0400
Content-Disposition: inline
In-Reply-To: <1276771242-5201-6-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Ajay Kumar Gupta <ajay.gupta@ti.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "gregkh@suse.de" <gregkh@suse.de>, Mike Frysinger <vapier@gentoo.org>

On Thu, Jun 17, 2010 at 12:40:38PM +0200, ext Ajay Kumar Gupta wrote:
>From: Mike Frysinger <vapier@gentoo.org>
>
>The new ulpi code defines fallback stubs for the Blackfin arch, but does
>so incorrectly leading to a build failure:
>drivers/usb/musb/musb_core.c:227: error: 'musb_ulpi_read' undeclared here (not in a function)
>drivers/usb/musb/musb_core.c:228: error: 'musb_ulpi_write' undeclared here (not in a function)
>
>Tweak the fallback stubs so that they do work as intended.
>
>Signed-off-by: Mike Frysinger <vapier@gentoo.org>
>Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

-- 
balbi

DefectiveByDesign.org
