From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 00/14] ARM: OMAP: DMTIMER fixes
Date: Wed, 7 Nov 2012 13:52:04 -0800
Message-ID: <20121107215204.GN6801@atomide.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
 <20121107212254.GK6801@atomide.com>
 <509AD621.7060402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:61126 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751149Ab2KGVwI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 16:52:08 -0500
Content-Disposition: inline
In-Reply-To: <509AD621.7060402@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [121107 13:45]:
> 
> On 11/07/2012 03:22 PM, Tony Lindgren wrote:
> > * Jon Hunter <jon-hunter@ti.com> [121107 11:03]:
> >> This series includes several fixes for the OMAP DMTIMER driver. This is
> >> based upon 3.7-rc4 with the two series adding device-tree support for
> >> DMTIMERs [1] and the 32kHz Counter [2]
> > 
> > These look OK to me, I'm assuming you'll do a pull request eventually
> > for these. Might be worth checking if these merge fine also on
> > omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3, rename detection
> > might be able to deal with that for the header.
> 
> Yes I was going to wait a few days for people to review before sending a
> pull request. I will make sure it merges on your master. Is Monday too
> late for v3.8?

Probably not for this series as it fixes some issues, but in general
we should have most of the patches queued by -rc4 time.

Regards,

Tony
 
> >> [1] http://marc.info/?l=linux-omap&m=135065875808614&w=2
> >> [2] http://marc.info/?l=linux-omap&m=135119308123513&w=2
