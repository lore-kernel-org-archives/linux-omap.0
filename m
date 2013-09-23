From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 4/5] dma: cppi41: only allocate descriptor memory
 once
Date: Mon, 23 Sep 2013 09:47:54 +0530
Message-ID: <20130923041754.GZ17188@intel.com>
References: <1379861404-8250-1-git-send-email-zonque@gmail.com>
 <1379861404-8250-5-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:18382 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642Ab3IWFIQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Sep 2013 01:08:16 -0400
Content-Disposition: inline
In-Reply-To: <1379861404-8250-5-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, neumann@teufel.de, bigeasy@linutronix.de, sergei.shtylyov@cogentembedded.com, dan.j.williams@intel.com, balbi@ti.com, gregkh@linuxfoundation.org

On Sun, Sep 22, 2013 at 04:50:03PM +0200, Daniel Mack wrote:
> cdd->cd and cdd->descs_phys are allocated DESCS_AREAS times from
> init_descs() and freed as often from purge_descs(). This leads to both
> memory leaks and double-frees.
> 
> Fix this by pulling the calls to dma_{alloc,free}_coherent() out of the
> loops.
> 
> While at it, remove the intermediate variable mem_decs (I guess it was
> only there to make the code comply to the 80-chars CodingSytle rule).
>
Looks fine, Sebastian cna you test it pls

~Vinod
