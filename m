From: Mikko Rapeli <ext-mikko.rapeli@Nokia.com>
Subject: Re: [PATCH] twl4030 reboot workaround
Date: Thu, 29 Jul 2010 09:16:08 +0300
Message-ID: <20100729061608.GG12063@edollo>
References: <1265226207-22971-3-git-send-email-mturquette@ti.com> <1280310092-27260-1-git-send-email-ext-mikko.rapeli@nokia.com> <4C505118.40807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37366 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab0G2GRT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jul 2010 02:17:19 -0400
Content-Disposition: inline
In-Reply-To: <4C505118.40807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mike Turquette <mturquette@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>

On Wed, Jul 28, 2010 at 05:47:36PM +0200, ext Mike Turquette wrote:
> This method is much better than the method I proposed before.  Taking 
> into account the comments from others, ACK.

Thanks, I'll send an updated version with that one new line. Do you have
an idea how the watchdog reset case should be handled? Can the boot loader do
something about this or must the script removal be done before reboot?

-Mikko
