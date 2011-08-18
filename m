From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
Date: Thu, 18 Aug 2011 15:35:42 +0200
Message-ID: <201108181535.42339.arnd@arndb.de>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com> <1313622608-30397-2-git-send-email-ohad@wizery.com> <201108181101.57882.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:56165 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081Ab1HRNfw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Aug 2011 09:35:52 -0400
In-Reply-To: <201108181101.57882.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org

On Thursday 18 August 2011, Laurent Pinchart wrote:
> > +static int omap_iommu_domain_init(struct iommu_domain *domain)
> > +{
> > +     struct omap_iommu_domain *omap_domain;
> > +
> > +     omap_domain = kzalloc(sizeof(*omap_domain), GFP_KERNEL);
> > +     if (!omap_domain) {
> > +             pr_err("kzalloc failed\n");
> > +             goto out;
> 
> You can directly return -ENOMEM here, and remove the "out:" label.

Risking to get into bike-shedding here, I would comment that the current
code is actually better. I would not mix the two methods of error handling
in one function. If you use goto labels, better use them consistenly and
have only one 'return' statement.

	Arnd
