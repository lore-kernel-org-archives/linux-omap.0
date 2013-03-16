From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 47/50] staging: omap-thermal: switch mutex to spinlock
 inside omap-bandgap
Date: Sat, 16 Mar 2013 17:22:16 +0300
Message-ID: <20130316142216.GR9138@mwanda>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
 <1363352438-15935-48-git-send-email-eduardo.valentin@ti.com>
 <20130316085902.GP9138@mwanda>
 <5144687A.7030007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:42471 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755689Ab3CPOW0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Mar 2013 10:22:26 -0400
Content-Disposition: inline
In-Reply-To: <5144687A.7030007@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Sat, Mar 16, 2013 at 08:41:30AM -0400, Eduardo Valentin wrote:
> On 16-03-2013 04:59, Dan Carpenter wrote:
> >On Fri, Mar 15, 2013 at 09:00:35AM -0400, Eduardo Valentin wrote:
> >>@@ -502,9 +504,9 @@ int _omap_bandgap_write_threshold(struct omap_bandgap *bg_ptr, int id, int val,
> >>  	if (ret < 0)
> >>  		goto exit;
> >>
> >>-	mutex_lock(&bg_ptr->bg_mutex);
> >>+	spin_lock(&bg_ptr->lock);
> >
> >These need to disable interrupts because we take the spin lock in
> >the IRQ handler.
> 
> This IRQ gets masked at the IRQ controller level when served
> (ONE_SHOT). Not sure if your comment is applicable in this case..

Yes.  It still applies.  We need to disable IRQs from the current
CPU while we are holding a spin_lock which they will need.

regards,
dan carpenter

