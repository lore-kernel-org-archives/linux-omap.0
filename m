From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [Query][omap iommu] Consulting iommu if a physical region is
 "mappable" before actually mapping it
Date: Tue, 04 May 2010 08:58:33 +0300 (EEST)
Message-ID: <20100504.085833.15255924.Hiroshi.DOYU@nokia.com>
References: <A24693684029E5489D1D202277BE8944550BB017@dlee02.ent.ti.com>
	<8F7AF80515AF0D4D93307E594F3CB40E4B791E48@dlee03.ent.ti.com>
	<A24693684029E5489D1D202277BE8944551B92F7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:31185 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab0EDF6n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 01:58:43 -0400
In-Reply-To: <A24693684029E5489D1D202277BE8944551B92F7@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: saaguirre@ti.com
Cc: h-kanigeri2@ti.com, linux-omap@vger.kernel.org

From: "ext Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [Query][omap iommu] Consulting iommu if a physical region is "mappable" before actually mapping it
Date: Mon, 3 May 2010 21:23:46 +0200

> 
> 
>> -----Original Message-----
>> From: Kanigeri, Hari
>> Sent: Monday, May 03, 2010 2:09 PM
>> To: Aguirre, Sergio; Hiroshi DOYU
>> Cc: linux-omap@vger.kernel.org
>> Subject: RE: [Query][omap iommu] Consulting iommu if a physical region is
>> "mappable" before actually mapping it
>> 
>> Sergio,
>> 
>> >
>> > Can the iommu driver be "consulted" if a certain area (contiguous or
>> not)
>> > can be mapped or not, before even trying to do it?
>> >
>> 
>> -- As long as there are physical pages backing the area it should be
>> mappable right ?
> 
> Ok, well.. maybe my question was more about that, if the ISP MMU has
> some kind of limited translation table size, in which it has a
> limited of pages to map to device addresses that the ISP can use.
> 
> The need for this is that, in camera, there's a Video4Linux2 IOCTL
> to know if a certain amount of buffers can be handled (and that
> includes if they could be mapped or not), even before actually doing
> the whole allocation/mapping.
> 
> If there's no limitation in the translation table size, then I guess
> the only concern is to ensure we have enough free RAM to use. (Which
> I'll like to think that an userspace resource manager will be able
> to figure out for the camera application, which is the one
> allocating the buffers.)

Right, currently a whole 4GB address space is available, so virtually
no limitation for the translation table size.


