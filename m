From: Olof Johansson <olof@lixom.net>
Subject: Re: [RFC/PATCH 1/2] usb_otg: compile fix
Date: Thu, 7 Jan 2010 22:15:29 -0600
Message-ID: <20100108041529.GA28076@lixom.net>
References: <1262912592-7817-1-git-send-email-alecrim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:58927 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082Ab0AHEI2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 23:08:28 -0500
Content-Disposition: inline
In-Reply-To: <1262912592-7817-1-git-send-email-alecrim@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Francisco Alecrim <alecrim@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Francisco Alecrim <francisco.alecrim@openbossa.org>

On Thu, Jan 07, 2010 at 09:03:11PM -0400, Francisco Alecrim wrote:
> From: Francisco Alecrim <francisco.alecrim@openbossa.org>
> 
> include/linux/usb.h: In function 'usb_mark_last_busy':
> include/linux/usb.h:561: error: 'struct usb_device' has no member named
> 'last_busy'
> 
> Option USB_OTG selects USB_SUSPEND but doesn't select PM(required by
> USB_SUSPEND) causing this compile error. Putting USB_SUSPEND as
> USB_OTG depend ensure that PM is selected.

For me it seems sufficient to just remove the select of USB_SUSPEND.
USB_OTG compiles fine without it.

Seems harsh to require someone to enable CONFIG_PM and USB_SUSPEND just
to compile OTG drivers.


-Olof

