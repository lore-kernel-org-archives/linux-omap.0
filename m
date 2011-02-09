From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v6 0/6] OMAP: McSPI: Hwmod adaptation + runtime
 conversion
Date: Wed, 9 Feb 2011 11:21:41 -0800
Message-ID: <20110209192141.GB20795@atomide.com>
References: <1296649335-31756-1-git-send-email-govindraj.raja@ti.com>
 <878vxvl9i6.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14261 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab1BITWJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 14:22:09 -0500
Content-Disposition: inline
In-Reply-To: <878vxvl9i6.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Charulatha V <charu@ti.com>

* Kevin Hilman <khilman@ti.com> [110204 14:27]:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
> 
> > Changes invloves:
> > ----------------
> > 1) Addition of hwmod data for omap2/3/4.
> > 2) McSPI driver hwmod adaptation with cleanup of base address
> >    macros and using omap-device API's.
> > 3) Runtime Conversion of McSPI driver.
> >
> > Changes from v5:
> > ---------------
> > Rebased on top of 2.6.38-rc3 as per Kevin's comments.
> > http://www.spinics.net/lists/arm-kernel/msg112112.html
> 
> Thanks.
> 
> Reviewed-by: Kevin Hilman <khilman@ti.com>

Thanks everybody, will queue.

Tony
