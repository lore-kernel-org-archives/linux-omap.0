From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC/PATCH 1/3] i2c: Add SCCB support
Date: Tue, 17 Jul 2012 14:08:27 +0200
Message-ID: <20120717140827.0b06d427@endymion.delvare>
References: <1340720229-30356-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<1340720229-30356-2-git-send-email-laurent.pinchart@ideasonboard.com>
	<20120717135307.6745729f@endymion.delvare>
	<3429100.CjPKYaDDfQ@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:26221 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab2GQMIf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Jul 2012 08:08:35 -0400
In-Reply-To: <3429100.CjPKYaDDfQ@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org

On Tue, 17 Jul 2012 13:57:25 +0200, Laurent Pinchart wrote:
> On Tuesday 17 July 2012 13:53:07 Jean Delvare wrote:
> > On Tue, 26 Jun 2012 16:17:07 +0200, Laurent Pinchart wrote:
> > > +	if (unlikely(flags & I2C_CLIENT_SCCB) && size != I2C_SMBUS_BYTE_DATA) {
> > > +		dev_err(&adapter->dev,
> > > +			"SCCB devices only support I2C_SMBUS_BYTE_DATA\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > 
> > I'm not sure if we really want this. If the SCCB protocol evolves,
> > we'll have to loosen the check. If a devices follows SCCB for byte data
> > transactions and I2C/SMBus for others, it won't work. Plus it slows
> > down the function a bit, to catch a developer error which would not
> > result in anything catastrophic anyway.
> > 
> > I propose that we either drop the check completely (my preference) or
> > make it depend on DEBUG.
> 
> I'm OK with dropping the check. Should I resubmit the patch or can you modify 
> it when applying ?

I'll do it myself, no problem.

Thanks,
-- 
Jean Delvare
