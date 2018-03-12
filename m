From: Suman Anna <s-anna@ti.com>
Subject: Re: Nokia N900: refcount_t underflow, use after free
Date: Mon, 12 Mar 2018 11:10:58 -0500
Message-ID: <5aa1e2de-96d1-0e88-01ca-49df9ae25457@ti.com>
References: <20180308143053.GA17267@amd> <20180308165903.GM5799@atomide.com>
 <57c9f17b-fc9d-8506-4b5d-70ac216c9248@ti.com> <20180308185046.GA22796@amd>
 <1dfc05fe-1612-f5a5-b5f1-9038b3cecfe5@arm.com>
 <1643b74a-62ba-bea6-71c2-a2dd02430463@ti.com> <20180309221834.GA15476@amd>
 <c8ee5692-bf71-a9d7-8607-50adc9f0e9f1@ti.com> <20180310112634.GA31614@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180310112634.GA31614@amd>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ivo.g.dimitrov.75@gmail.com, aaro.koskinen@iki.fi, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, martijn@brixit.nl, =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>, abcloriens@gmail.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, clayton@craftyguy.net, linux-omap@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On 03/10/2018 05:26 AM, Pavel Machek wrote:
> Hi!
> 
>>>>> Well, there certainly seems to be an obvious bug wherein
>>>>> isp_detach_iommu() just releases the mapping directly without calling
>>>>> arm_iommu_detach_device() to balance the equivalent attach. That can't
>>>>> be helping.
>>>>
>>>> Indeed, I have been able to reproduce the same warning using a
>>>> standalone test module, and the missing arm_iommu_detach_device() is
>>>> causing the warning after probe (during failure path) or during
>>>> remove.
>>>
>>> Ok do you have an idea how to fix the isp error paths? Untested patch
>>> would be fine... But it seems that you know what needs to be fixed and
>>> I don't.
>>>
>>
>> OK, see if the following fixes the issue for you, only build tested.
> 
> Word-wrapped, so I applied by hand. And yes, the oops at boot is
> gone. Thanks!

Sorry about that, have to check my mail settings. Anyway will post the
patch again, glad that it fixed your issue.

regards
Suman

> 
> (Camera still does not work in -next... kills system. Oh well. Lets
> debug that some other day.)
> 
>> 8< ---------------------
>> >From bac9a48fb646dc51f2030d676a0dbe3298c3b134 Mon Sep 17 00:00:00 2001
>> From: Suman Anna <s-anna@ti.com>
>> Date: Fri, 9 Mar 2018 16:39:59 -0600
>> Subject: [PATCH] media: omap3isp: fix unbalanced dma_iommu_mapping
>>
>> The OMAP3 ISP driver manages its MMU mappings through the IOMMU-aware
>> ARM DMA backend. The current code creates a dma_iommu_mapping and
>> attaches this to the ISP device, but never detaches the mapping in
>> either the probe failure paths or the driver remove path resulting
>> in an unbalanced mapping refcount and a memory leak. Fix this properly.
>>
>> Reported-by: Pavel Machek <pavel@ucw.cz>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
> 
> Tested-by: Pavel Machek <pavel@ucw.cz>
> 									Pavel
> 
