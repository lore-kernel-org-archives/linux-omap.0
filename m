From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [ANNOUNCE] PM branch updated to v2.6.32-rc8
Date: Wed, 25 Nov 2009 15:04:19 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402543D7FBE@dbde02.ent.ti.com>
References: <87638zvj24.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42217 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758348AbZKYJeT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 04:34:19 -0500
In-Reply-To: <87638zvj24.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,
I see multiple commits for some of the patches with 2.6.32-rc8 latest code.
Ex:
#>gl | grep -i "Introduce zoom3 board support"
5f35fbe  omap3: zoom: Introduce zoom3 board support (3 days ago)
163cde1  omap3: zoom: Introduce zoom3 board support (7 days ago)
084bb37  omap: zoom3: introduce zoom3 board support (11 days ago)
3af1083  omap: zoom3: introduce zoom3 board support (11 days ago)
13ac7e7  omap: zoom3: introduce zoom3 board support (12 days ago)
9de2968  omap: zoom3: introduce zoom3 board support (13 days ago)
#>

There are some more patches like above.

Is there any specific reason for having multiple commits?

-Manjunath 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Wednesday, November 25, 2009 12:37 AM
> To: linux-omap@vger.kernel.org
> Subject: [ANNOUNCE] PM branch updated to v2.6.32-rc8
> 
> FYI...
> 
> PM branch was rebased to today's linux-omap master branch (currently
> v2.6.32-rc8)
> 
> As usual, the PM wiki[1] has all the details on using the PM 
> branch as well
> as some known issues.
> 
> Also note that starting with the official v2.6.32 release, I 
> will be moving
> from a continual rebase model to a "re-branch & rebuild" model similar
> to how Tony is now managing l-o master.
> 
> Kevin
> 
> [1] http://elinux.org/OMAP_Power_Management
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 