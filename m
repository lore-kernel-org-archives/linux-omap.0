From: "Lesly Arackal Manuel" <leslyam@ti.com>
Subject: RE: [PATCH v4 0/5] omap3: pm: Update TRITON power scripts and making it generic
Date: Thu, 8 Apr 2010 11:55:02 +0530
Message-ID: <005f01cad6e4$392f5010$518918ac@apr.dhcp.ti.com>
References: <1270030752-1900-1-git-send-email-leslyam@ti.com> <877hoknumc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38978 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758020Ab0DHGZI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 02:25:08 -0400
In-Reply-To: <877hoknumc.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Kevin Hilman' <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Wednesday, April 07, 2010 2:53 AM
> To: Lesly A M
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v4 0/5] omap3: pm: Update TRITON power scripts and
> making it generic
> 
> Lesly A M <leslyam@ti.com> writes:
> 
> > This series of patch implements a updated TRITON power scripts.
> > Also moving the sleep, wakeup & warm_reset sequence to a generic script
> file,
> > which can be used by different OMAP3 board with the power companion chip
> TWL4030.
> >
> > This patch series is based off Kevin's tree origin/pm branch.
> 
> Hmm, I don't think so.  It appears to be based off of Thara's SR
> series.
> 
> Kevin

Sorry..
Forgot to mention the dependency with Thara's SmartReflex patch series. 
(created on top of voltage.c changes taken from the SR pacth series)

Lesly

