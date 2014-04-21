From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 03/10] usb: phy: mv-u3d: switch over to writel/readl
Date: Mon, 21 Apr 2014 12:04:44 -0700
Message-ID: <20140421190444.GF14470@kroah.com>
References: <1398095812-14222-1-git-send-email-balbi@ti.com>
 <1398095812-14222-4-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37574 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753325AbaDUTNF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Apr 2014 15:13:05 -0400
Content-Disposition: inline
In-Reply-To: <1398095812-14222-4-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, leigh@solinno.co.uk, Tony Lindgren <tony@atomide.com>

On Mon, Apr 21, 2014 at 10:56:45AM -0500, Felipe Balbi wrote:
> by removing the _relaxed suffix, we can build
> this driver in other architectures.

Odd, why was the _relaxed variants used here at all?  Someone trying to
optimize something ahead of time?

greg k-h
