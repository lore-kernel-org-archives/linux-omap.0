From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] USB ehci-omap: Remove second kfree() call on the same
 object
Date: Fri, 5 Nov 2010 14:24:52 +0200
Message-ID: <20101105122452.GZ1952@legolas.emea.dhcp.ti.com>
References: <20101025205654.GN18700@darwin>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35834 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab0KEMYg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 08:24:36 -0400
Content-Disposition: inline
In-Reply-To: <20101025205654.GN18700@darwin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matthias Kaehlcke <matthias@kaehlcke.net>
Cc: "Balbi, Felipe" <balbi@ti.com>, David Brownell <dbrownell@users.sourceforge.net>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Oct 25, 2010 at 03:56:54PM -0500, Matthias Kaehlcke wrote:
>Remove second kfree() call on the same object in the error path of
>ehci_hcd_omap_probe()
>
>Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>

applied, thanks

-- 
balbi
