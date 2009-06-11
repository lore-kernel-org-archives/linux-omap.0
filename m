From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Patch: Init/shutdown correctness fixes for drivers/cbus/tahvo*
Date: Thu, 11 Jun 2009 23:36:57 +0300
Message-ID: <20090611203657.GB31172@nokia.com>
References: <20090526002046.52484z9m6ufsxjb4@lidskialf.net> <20090611093725.GB15374@nokia.com> <20090611182646.68427jqmiduhec8w@lidskialf.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36257 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbZFKUkG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Jun 2009 16:40:06 -0400
Content-Disposition: inline
In-Reply-To: <20090611182646.68427jqmiduhec8w@lidskialf.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, Jun 11, 2009 at 07:26:46PM +0200, ext Andrew de Quincey wrote:
> Hi - the current phase I'm in of this development is to simply get the  
> thing working reliably again; that includes cleanup etc as appropriate.
> 
> Once that is complete, i want to go back and refactor all the drivers  
> s that they do exactly what you suggest above, as well as using the  
> latest kernel APIs, modularisation where appropriate etc, with a view  
> to being suitable for mainline (even if they are not actually  
> submitted to mainline).
> 
> I don't want to do both at once because I feel that is too big a step  
> for this older slightly unmaintained code. Is it acceptable to you to  
> commit this patch in the interim?

That's fine then, but at least fix this line:

+	struct tahvo_usb *tu = (struct tahvo_usb*) pdev->dev.driver_data;

then you have my ack

-- 
balbi
