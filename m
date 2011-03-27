From: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Subject: Re: [PATCH 0/4] iommu: Prevent oops in iommu_get() and while arch_iommu
 is in use
Date: Sun, 27 Mar 2011 20:27:41 +0300
Message-ID: <4D8F738D.3090100@maxwell.research.nokia.com>
References: <4D8CB106.7030608@maxwell.research.nokia.com> <AANLkTikxd4kRu1+XskohhQzpqHaZTvK+afbgE-qRSOqN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:27488 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753481Ab1C0RZh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 27 Mar 2011 13:25:37 -0400
In-Reply-To: <AANLkTikxd4kRu1+XskohhQzpqHaZTvK+afbgE-qRSOqN@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Cohen David Abraham <david.cohen@nokia.com>

Ramirez Luna, Omar wrote:
> On Fri, Mar 25, 2011 at 10:13 AM, Sakari Ailus
> <sakari.ailus@maxwell.research.nokia.com> wrote:
>> Hi,
>>
>> This patchset is aimed to fix a problem in arch_iommu implementation
>> references. When an actual arch_iommu implementation is not loaded while
>> iommu_get() is being called results to a kernel oops, as well as
>> removing an arch_iommu implementation which is in use.
> 
> How about fixing the dependency instead? Right now iommu2 depends on
> iommu because of the calls to
> install_iommu_arch/uninstall_iommu_arch... we should change that
> dependency to iommu depend on iommu2. Something like iommu (plat)
> querying iommu2 (mach) for devices to install.

There is no direct dependency from a driver using the generic API to a
particular implementation of the iommu. This comes from the design of
the iommu framework. The generic layer shouldn't depend on particular
implementation(s).

What comes to the patch, it works as long as there's only one iommu
implementation loaded / compiled to the kernel. I wonder if this kind of
limitation can be accepted.

Regards,

-- 
Sakari Ailus
sakari.ailus@maxwell.research.nokia.com
