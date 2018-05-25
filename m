From: Suman Anna <s-anna@ti.com>
Subject: Re: Nokia N900: refcount_t underflow, use after free
Date: Thu, 24 May 2018 21:37:41 -0500
Message-ID: <09e30e44-4904-3bb3-c977-19ccd8d76a08@ti.com>
References: <20180308143053.GA17267@amd> <20180308165903.GM5799@atomide.com>
 <57c9f17b-fc9d-8506-4b5d-70ac216c9248@ti.com> <20180308185046.GA22796@amd>
 <1dfc05fe-1612-f5a5-b5f1-9038b3cecfe5@arm.com>
 <1643b74a-62ba-bea6-71c2-a2dd02430463@ti.com> <20180309221834.GA15476@amd>
 <c8ee5692-bf71-a9d7-8607-50adc9f0e9f1@ti.com> <20180310112634.GA31614@amd>
 <5aa1e2de-96d1-0e88-01ca-49df9ae25457@ti.com> <20180524110533.GA20599@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180524110533.GA20599@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Robin Murphy <robin.murphy@arm.com>, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, martijn@brixit.nl, =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>, abcloriens@gmail.com, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, clayton@craftyguy.net, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-omap@vger.kernel.org

On 05/24/2018 06:05 AM, Pavel Machek wrote:
> Hi!
> 
>>>>
>>>> OK, see if the following fixes the issue for you, only build tested.
>>>
>>> Word-wrapped, so I applied by hand. And yes, the oops at boot is
>>> gone. Thanks!
>>
>> Sorry about that, have to check my mail settings. Anyway will post the
>> patch again, glad that it fixed your issue.
> 
> Any news here? AFAICT the bug creeped into v4.17-rcX in the
> meantime...
>

The patch has been on linux-next for sometime now.

regards
Suman

> 								Pavel
> 
>> regards
>> Suman
>>
>>>
>>> (Camera still does not work in -next... kills system. Oh well. Lets
>>> debug that some other day.)
>>>
>>>> 8< ---------------------
>>>> >From bac9a48fb646dc51f2030d676a0dbe3298c3b134 Mon Sep 17 00:00:00 2001
>>>> From: Suman Anna <s-anna@ti.com>
>>>> Date: Fri, 9 Mar 2018 16:39:59 -0600
>>>> Subject: [PATCH] media: omap3isp: fix unbalanced dma_iommu_mapping
>>>>
>>>> The OMAP3 ISP driver manages its MMU mappings through the IOMMU-aware
>>>> ARM DMA backend. The current code creates a dma_iommu_mapping and
>>>> attaches this to the ISP device, but never detaches the mapping in
>>>> either the probe failure paths or the driver remove path resulting
>>>> in an unbalanced mapping refcount and a memory leak. Fix this properly.
>>>>
>>>> Reported-by: Pavel Machek <pavel@ucw.cz>
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>
>>> Tested-by: Pavel Machek <pavel@ucw.cz>
>>> 									Pavel
>>>
> 
