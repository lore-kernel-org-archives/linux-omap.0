From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH] [FIX] dmaengine: virt-dma: Free descriptor after callback
Date: Fri, 18 Apr 2014 11:34:50 -0500
Message-ID: <5351542A.5080307@ti.com>
References: <1397782610-7370-1-git-send-email-joelf@ti.com> <20140418085019.GN27282@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41888 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754398AbaDRQe6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Apr 2014 12:34:58 -0400
In-Reply-To: <20140418085019.GN27282@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>

On 04/18/2014 03:50 AM, Russell King - ARM Linux wrote:
> On Thu, Apr 17, 2014 at 07:56:50PM -0500, Joel Fernandes wrote:
>> Free the vd (virt descriptor) after the callback is called.  In EDMA driver
>> atleast which uses virt-dma, we make use of the desc during the callback and if
>> its dangerously freed before the callback is called. I also noticed this in
>> omap-dma dmaengine driver.
> 
> You've missed the vital bit of information: why do you make use of the
> descriptor afterwards?  You shouldn't.  omap-dma doesn't either.
> 
> Once clients submit their request to DMA engine, they must not hold any
> kind of reference to the descriptor other than the cookie.
> 

Sorry, I confused edma/omap-dma callbacks for virt dma callbacks.

Anyway, I think there is still a chance in edma that we refer to the
echan->edesc pointer later on after virt-dma calls the free (in
edma_execute), so I'll just NULL that out to be safe and submit a patch.
Thanks.

regards,
  -Joel
