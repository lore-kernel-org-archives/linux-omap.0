From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Latest OMAP4 build errors
Date: Tue, 28 Feb 2012 10:01:22 +0000
Message-ID: <201202281001.23011.arnd@arndb.de>
References: <20120228090209.GC18045@n2100.arm.linux.org.uk> <CAK=WgbZeeLxewPhxVpcAsNNeKYuzLojDZUm_=GmUgSh8kwvWUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55641 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932119Ab2B1KB1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 05:01:27 -0500
In-Reply-To: <CAK=WgbZeeLxewPhxVpcAsNNeKYuzLojDZUm_=GmUgSh8kwvWUQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

On Tuesday 28 February 2012, Ohad Ben-Cohen wrote:
> On Tue, Feb 28, 2012 at 11:02 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > 1. It selects OMAP_IOMMU which may not have its dependencies satisfied.
> 
> I'll select IOMMU_SUPPORT too (I prefer selecting here rather than
> depending, because users may have hard time realizing they need to
> enable omap's iommu first in order for omap's remoteproc option to
> show up).

I think 'depends' would be better here, because selecting IOMMU_SUPPORT
has other side-effects that a user might not want. It's just as likely
that someone wants to disable IOMMU_SUPPORT and needs to find OMAP_REMOTEPROC
as wanting to enable OMAP_REMOTEPROC and having to find IOMMU_SUPPORT.

In most cases, the defconfig should just set both.

> > 2. It's a new feature.  It is experimental.  It should not default to 'm'
> 
> I'll set it to 'n' (by removing that line altogether).

ok.

	Arnd
