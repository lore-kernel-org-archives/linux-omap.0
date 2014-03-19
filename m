From: Tony Lindgren <tony@atomide.com>
Subject: Re: DSS DT changes
Date: Wed, 19 Mar 2014 08:30:47 -0700
Message-ID: <20140319153046.GA12934@atomide.com>
References: <53297EC4.30304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19958 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965001AbaCSPax (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2014 11:30:53 -0400
Content-Disposition: inline
In-Reply-To: <53297EC4.30304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140319 04:29]:
> Hi Tony,
> 
> Is it too late to get the DSS dts changes via arm tree?

Yes too late..
 
> I now got everything working fine so that the dts changes and the
> omapdss driver changes can be merged independently. It would be cleaner
> if dts changes can go through the proper channel.
> 
> If you can still take them, I've attached the patches, based on your
> omap-for-v3.15/dt branch.
> 
> I also attached the bindings docs. Those I can take via my tree, but I'm
> not sure if they are supposed to go with the dts changes or with the
> driver changes, so I have them here also.
> 
> And I've pushed the changes to my tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git
> 
> The branches are:
> 
> 3.15/dss-dt-dts - contains the .dts changes
> 3.15/dss-dt - contains the driver changes + binding docs

These look OK to me and would be good to get in so we can move
on with dropping more legacy platform data.

As you have my acks there, so please feel free to send
your 3.15/dss-dt-dts along with the DSS patches after the
arm-soc branches have been merged.

Regards,

Tony
