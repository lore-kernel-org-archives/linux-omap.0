From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: Re: SRF Fixes
Date: Wed, 29 Oct 2008 16:20:15 +0200
Message-ID: <1225290015.4470.226.camel@kj-ubuntu>
References: <>
	 <1225269015-19064-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
	 <1225278619.4470.195.camel@kj-ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60614 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbYJ2OTL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 10:19:11 -0400
In-Reply-To: <1225278619.4470.195.camel@kj-ubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rnayak@ti.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

On ke, 2008-10-29 at 13:10 +0200, Kalle Jokiniemi wrote:
> On ke, 2008-10-29 at 10:30 +0200, ext Kalle Jokiniemi wrote:
> > Hi,
> > 
> > We have been testing the SRF patches (sent by Rajendra on 16th-Oct) now,
> > and some issues were found. The following patch corrects some of them,
> > these issues remain:

Couple of new issues were found and corrected. A updated fixes patch
coming in soon. If any new problems are found, I'll post a new version
again.

regards,
Kalle

>       
> > 
> > 1. Handling enable_off_mode sysfs switches is not supported in this patch.
> > I'm planning to add a new interface into the generic shared resource fw 
> > to enable refreshing power domain states, when such changes take place.
> 
> OK, I have an implementation for supporting the enable_off_mode
> swithcing. I'll send a updated patch soon.
> 
> regards,
> Kalle
> 
> > 
> > 2. Non platform devices won't be able to add power domain wake-up latency 
> > requirements. The srf interface has a device pointer parameter, which the
> > following patch uses to get platform_device pointer. This pdev is required
> > by the omapdev interface for finding the respective power domain. The 
> > aquisition of platform_device pointer is done via container_of macro, which
> > may cause crashes if the device pointer does not have a platform device
> > container.
> > 
> > Any comments on how to make this better are welcome. I think that if   
> > the SRF interface would accept a platform_device pointer instead of
> > device pointer the problem would solve. I have a check in my patch that 
> > checks for NULL pointer in pdev->name, but this won't work always. 
> > 
> > 3. Seems that device hangs if MPU, NEON and CORE power domains hit OFF
> > mode, while other power domains are in retention. We suspect PER in 
> > retention + CORE in OFF would be the most likely cause of trouble,
> > this is being looked into.
> > 
> > regards,
> > Kalle Jokiniemi
> > 
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
