From: Suman Anna <s-anna@ti.com>
Subject: Re: Nokia N900: refcount_t underflow, use after free
Date: Fri, 9 Mar 2018 17:06:49 -0600
Message-ID: <c8ee5692-bf71-a9d7-8607-50adc9f0e9f1@ti.com>
References: <20180308143053.GA17267@amd> <20180308165903.GM5799@atomide.com>
 <57c9f17b-fc9d-8506-4b5d-70ac216c9248@ti.com> <20180308185046.GA22796@amd>
 <1dfc05fe-1612-f5a5-b5f1-9038b3cecfe5@arm.com>
 <1643b74a-62ba-bea6-71c2-a2dd02430463@ti.com> <20180309221834.GA15476@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180309221834.GA15476@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Robin Murphy <robin.murphy@arm.com>, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, martijn@brixit.nl, =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>, abcloriens@gmail.com, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, clayton@craftyguy.net, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-omap@vger.kernel.org

On 03/09/2018 04:18 PM, Pavel Machek wrote:
> On Fri 2018-03-09 16:13:36, Suman Anna wrote:
>> On 03/09/2018 06:08 AM, Robin Murphy wrote:
>>> On 08/03/18 18:50, Pavel Machek wrote:
>>>> Hi!
>>>>
>>>>>> * Pavel Machek <pavel@ucw.cz> [180308 14:31]:
>>>>>>> Hi!
>>>>>>>
>>>>>>> I'm getting this warning... Has anyone seen/debugged that before?
>>>>>>> Unfortunately the backtrace does not seem to be too useful :-(.
>>>>>>
>>>>>> Adding Suman to Cc, as it points to arm_iommu_release_mapping().
>>>>>
>>>>> Hmm, we need to find out if the failure paths in isp_probe() are
>>>>> mismatched, or if this is coming from some mismatch between the OMAP
>>>>> IOMMU driver and the DMA plumbing. AFAIK, the cleanup paths in this
>>>>
>>>> Well, camera only started to work on N900 pretty recently. Let me add
>>>> some debug printks...
>>>>
>>>> Camera does not work in 4.16.0-rc4-next-20180308-dirty.
>>>>
>>>> I see this. It looks like problem in isp error paths, indeed:
>>>
>>> Well, there certainly seems to be an obvious bug wherein
>>> isp_detach_iommu() just releases the mapping directly without calling
>>> arm_iommu_detach_device() to balance the equivalent attach. That can't
>>> be helping.
>>
>> Indeed, I have been able to reproduce the same warning using a
>> standalone test module, and the missing arm_iommu_detach_device() is
>> causing the warning after probe (during failure path) or during
>> remove.
> 
> Ok do you have an idea how to fix the isp error paths? Untested patch
> would be fine... But it seems that you know what needs to be fixed and
> I don't.
> 

OK, see if the following fixes the issue for you, only build tested.

8< ---------------------
>From bac9a48fb646dc51f2030d676a0dbe3298c3b134 Mon Sep 17 00:00:00 2001
From: Suman Anna <s-anna@ti.com>
Date: Fri, 9 Mar 2018 16:39:59 -0600
Subject: [PATCH] media: omap3isp: fix unbalanced dma_iommu_mapping

The OMAP3 ISP driver manages its MMU mappings through the IOMMU-aware
ARM DMA backend. The current code creates a dma_iommu_mapping and
attaches this to the ISP device, but never detaches the mapping in
either the probe failure paths or the driver remove path resulting
in an unbalanced mapping refcount and a memory leak. Fix this properly.

Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/media/platform/omap3isp/isp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/omap3isp/isp.c
b/drivers/media/platform/omap3isp/isp.c
index 8eb000e3d8fd..c7d667bfc2af 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -1945,6 +1945,7 @@ static int isp_initialize_modules(struct
isp_device *isp)

 static void isp_detach_iommu(struct isp_device *isp)
 {
+       arm_iommu_detach_device(isp->dev);
        arm_iommu_release_mapping(isp->mapping);
        isp->mapping = NULL;
 }
@@ -1971,13 +1972,15 @@ static int isp_attach_iommu(struct isp_device *isp)
        ret = arm_iommu_attach_device(isp->dev, mapping);
        if (ret < 0) {
                dev_err(isp->dev, "failed to attach device to VA
mapping\n");
-               goto error;
+               goto error_attach;
        }

        return 0;

+error_attach:
+       arm_iommu_release_mapping(isp->mapping);
+       isp->mapping = NULL;
 error:
-       isp_detach_iommu(isp);
        return ret;
 }

-- 
2.16.2
