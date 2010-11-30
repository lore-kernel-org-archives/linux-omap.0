From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/4] arm: omap4: usb: add platform init code for EHCI
Date: Tue, 30 Nov 2010 13:40:45 -0800
Message-ID: <20101130214045.GA17222@atomide.com>
References: <1291051572-24084-1-git-send-email-gadiyar@ti.com>
 <1291051572-24084-3-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:39589 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab0K3Vkv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Nov 2010 16:40:51 -0500
Content-Disposition: inline
In-Reply-To: <1291051572-24084-3-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Greg KH <gregkh@suse.de>

* Anand Gadiyar <gadiyar@ti.com> [101129 09:16]:
> - Add platform init code for EHCI on OMAP4
> - Add pad configuration for PHY and TLL modes
> 
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>

Looks OK to me. You might want to check if all these signals
are unique though and do not have alternate paths.

Acked-by: Tony Lindgren <tony@atomide.com>
