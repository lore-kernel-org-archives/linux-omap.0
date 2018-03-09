From: Suman Anna <s-anna@ti.com>
Subject: Re: Nokia N900: refcount_t underflow, use after free
Date: Fri, 9 Mar 2018 16:13:36 -0600
Message-ID: <1643b74a-62ba-bea6-71c2-a2dd02430463@ti.com>
References: <20180308143053.GA17267@amd> <20180308165903.GM5799@atomide.com>
 <57c9f17b-fc9d-8506-4b5d-70ac216c9248@ti.com> <20180308185046.GA22796@amd>
 <1dfc05fe-1612-f5a5-b5f1-9038b3cecfe5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1dfc05fe-1612-f5a5-b5f1-9038b3cecfe5@arm.com>
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
To: Robin Murphy <robin.murphy@arm.com>, Pavel Machek <pavel@ucw.cz>
Cc: ivo.g.dimitrov.75@gmail.com, aaro.koskinen@iki.fi, Tony Lindgren <tony@atomide.com>, khilman@kernel.org, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, martijn@brixit.nl, =?UTF-8?Q?Filip_Matijevi=c4=87?= <filip.matijevic.pz@gmail.com>, abcloriens@gmail.com, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, clayton@craftyguy.net, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On 03/09/2018 06:08 AM, Robin Murphy wrote:
> On 08/03/18 18:50, Pavel Machek wrote:
>> Hi!
>>
>>>> * Pavel Machek <pavel@ucw.cz> [180308 14:31]:
>>>>> Hi!
>>>>>
>>>>> I'm getting this warning... Has anyone seen/debugged that before?
>>>>> Unfortunately the backtrace does not seem to be too useful :-(.
>>>>
>>>> Adding Suman to Cc, as it points to arm_iommu_release_mapping().
>>>
>>> Hmm, we need to find out if the failure paths in isp_probe() are
>>> mismatched, or if this is coming from some mismatch between the OMAP
>>> IOMMU driver and the DMA plumbing. AFAIK, the cleanup paths in this
>>
>> Well, camera only started to work on N900 pretty recently. Let me add
>> some debug printks...
>>
>> Camera does not work in 4.16.0-rc4-next-20180308-dirty.
>>
>> I see this. It looks like problem in isp error paths, indeed:
> =

> Well, there certainly seems to be an obvious bug wherein
> isp_detach_iommu() just releases the mapping directly without calling
> arm_iommu_detach_device() to balance the equivalent attach. That can't
> be helping.

Indeed, I have been able to reproduce the same warning using a
standalone test module, and the missing arm_iommu_detach_device() is
causing the warning after probe (during failure path) or during remove.

regards
Suman

> =

> Robin.
> =

>>
>> [=A0=A0=A0 1.672210] bus: 'platform': driver_probe_device: matched device
>> 480bc000.isp with dr
>> iver omap3isp
>> [=A0=A0=A0 1.681976] isp_probe: 1
>> [=A0=A0=A0 1.684906] isp_probe: 2
>> [=A0=A0=A0 1.687591] isp_probe: 3
>> [=A0=A0=A0 1.690338] isp_probe: 4
>> [=A0=A0=A0 1.693054] omap3isp 480bc000.isp: 480bc000.isp supply vdd-csip=
hy1
>> not found, using d
>> ummy regulator
>> [=A0=A0=A0 1.702728] omap3isp 480bc000.isp: 480bc000.isp supply vdd-csip=
hy2
>> not found, using d
>> ummy regulator
>> [=A0=A0=A0 1.712402] isp_probe: 5
>> [=A0=A0=A0 1.715393] omap3isp 480bc000.isp: Revision 2.0 found
>> [=A0=A0=A0 1.720794] isp_probe: 6
>> [=A0=A0=A0 1.723815] isp_probe: 7
>> [=A0=A0=A0 1.726715] omap-iommu 480bd400.mmu: 480bd400.mmu: version 1.1
>> [=A0=A0=A0 1.732849] isp_probe: 8
>> [=A0=A0=A0 1.735656] isp_probe: 9
>> [=A0=A0=A0 1.738403] isp_probe: 10
>> [=A0=A0=A0 1.741241] isp_probe: f3
>> [=A0=A0=A0 1.744018] iommu_release_mapping... ce4d9500 ce4d949c
>> [=A0=A0=A0 1.749450] iommu_release_mapping... ok
>> [=A0=A0=A0 1.753479] isp_probe: f4
>> [=A0=A0=A0 1.756286] clk_unregister: unregistering prepared clock: cam_x=
clka
>> [=A0=A0=A0 1.762878] clk_unregister: unregistering prepared clock: cam_x=
clkb
>> [=A0=A0=A0 1.769500] isp_probe: f5
>> [=A0=A0=A0 1.772430] iommu_release_mapping... ce4d9500 ce4d949c
>> [=A0=A0=A0 1.777862] ------------[ cut here ]------------
>> [=A0=A0=A0 1.782745] WARNING: CPU: 0 PID: 1 at lib/refcount.c:187
>> refcount_sub_and_test+0x94/0
>> xa8
>> [=A0=A0=A0 1.791290] refcount_t: underflow; use-after-free.
>> [=A0=A0=A0 1.796356] Modules linked in:
>> [=A0=A0=A0 1.799591] CPU: 0 PID: 1 Comm: swapper Not tainted
>> 4.16.0-rc4-next-20180308-dirty #7
>> 3
>> [=A0=A0=A0 1.807922] Hardware name: Nokia RX-51 board
>> [=A0=A0=A0 1.812469] [<c010d6cc>] (unwind_backtrace) from [<c010b568>]
>> (show_stack+0x10/0x14)
>> [=A0=A0=A0 1.820648] [<c010b568>] (show_stack) from [<c0127df4>]
>> (__warn+0xe8/0x110)
>> ...
>> [=A0=A0=A0 1.968688] iommu_release_mapping... ok
>> [=A0=A0=A0 1.973754] bus: 'platform': driver_probe_device: matched device
>> n900-battery with driver rx51-battery
>> [=A0=A0=A0 1.984436] bus: 'platform': driver_probe_device: matched device
>> 48002524.bandgap with driver ti-soc-thermal
>>
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index 8c398fe..16f4c69 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -2251,8 +2251,11 @@ static int extend_iommu_mapping(struct
>> dma_iommu_mapping *mapping)
>> =A0 =A0 void arm_iommu_release_mapping(struct dma_iommu_mapping *mapping)
>> =A0 {
>> +=A0=A0=A0 printk("iommu_release_mapping... %lx %lx\n", mapping,
>> mapping->domain);
>> =A0=A0=A0=A0=A0 if (mapping)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 kref_put(&mapping->kref, release_iommu_mappi=
ng);
>> +=A0=A0=A0 printk("iommu_release_mapping... ok\n");
>> +=A0=A0=A0
>> =A0 }
>> =A0 EXPORT_SYMBOL_GPL(arm_iommu_release_mapping);
>> =A0 diff --git a/drivers/media/platform/omap3isp/isp.c
>> b/drivers/media/platform/omap3isp/isp.c
>> index 8eb000e..4d58683 100644
>> --- a/drivers/media/platform/omap3isp/isp.c
>> +++ b/drivers/media/platform/omap3isp/isp.c
>> @@ -2193,12 +2193,14 @@ static int isp_probe(struct platform_device
>> *pdev)
>> =A0=A0=A0=A0=A0 int ret;
>> =A0=A0=A0=A0=A0 int i, m;
>> =A0 +=A0=A0=A0 printk("isp_probe: 1\n");
>> =A0=A0=A0=A0=A0 isp =3D devm_kzalloc(&pdev->dev, sizeof(*isp), GFP_KERNE=
L);
>> =A0=A0=A0=A0=A0 if (!isp) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(&pdev->dev, "could not allocate memo=
ry\n");
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;
>> =A0=A0=A0=A0=A0 }
>> =A0 +=A0=A0=A0=A0=A0=A0=A0 printk("isp_probe: 2\n");
>> =A0=A0=A0=A0=A0 ret =3D fwnode_property_read_u32(of_fwnode_handle(pdev->=
dev.of_node),
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 "ti,phy-type", &isp->phy_type);
>> =A0=A0=A0=A0=A0 if (ret)
>> @@ -2219,6 +2221,8 @@ static int isp_probe(struct platform_device *pdev)
>> =A0=A0=A0=A0=A0 mutex_init(&isp->isp_mutex);
>> =A0=A0=A0=A0=A0 spin_lock_init(&isp->stat_lock);
>> =A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk("isp_probe: 3\n");
>> +
>> =A0=A0=A0=A0=A0 ret =3D v4l2_async_notifier_parse_fwnode_endpoints(
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 &pdev->dev, &isp->notifier, sizeof(struct is=
p_async_subdev),
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 isp_fwnode_parse);
>> @@ -2232,6 +2236,7 @@ static int isp_probe(struct platform_device *pdev)
>> =A0=A0=A0=A0=A0 if (ret)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error;
>> =A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk("isp_probe: 4\=
n");
>> =A0=A0=A0=A0=A0 platform_set_drvdata(pdev, isp);
>> =A0 =A0=A0=A0=A0=A0 /* Regulators */
>> @@ -2258,6 +2263,7 @@ static int isp_probe(struct platform_device *pdev)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(isp->mmio_base[ma=
p_idx]);
>> =A0=A0=A0=A0=A0 }
>> =A0 +=A0=A0=A0 printk("isp_probe: 5\n");
>> =A0=A0=A0=A0=A0 ret =3D isp_get_clocks(isp);
>> =A0=A0=A0=A0=A0 if (ret < 0)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error;
>> @@ -2277,6 +2283,7 @@ static int isp_probe(struct platform_device *pdev)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error;
>> =A0=A0=A0=A0=A0 }
>> =A0 +=A0=A0=A0=A0=A0=A0=A0 printk("isp_probe: 6\n");
>> =A0=A0=A0=A0=A0 ret =3D isp_reset(isp);
>> =A0=A0=A0=A0=A0 if (ret < 0)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_isp;
>> @@ -2306,6 +2313,7 @@ static int isp_probe(struct platform_device *pdev)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 isp->mmio_base[OMAP3_ISP_IOMEM_C=
SI2A_REGS1]
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 + isp_res_maps[m].offset[i];
>> =A0 +=A0=A0=A0=A0=A0=A0=A0 printk("isp_probe: 7\n");
>> =A0=A0=A0=A0=A0 isp->mmio_hist_base_phys =3D
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 mem->start + isp_res_maps[m].offset[OMAP3_IS=
P_IOMEM_HIST];
>> =A0 @@ -2316,6 +2324,8 @@ static int isp_probe(struct platform_device
>> *pdev)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_isp;
>> =A0=A0=A0=A0=A0 }
>> =A0 +=A0=A0=A0=A0=A0=A0=A0 printk("isp_probe: 8\n");
>> +
>> =A0=A0=A0=A0=A0 /* Interrupt */
>> =A0=A0=A0=A0=A0 ret =3D platform_get_irq(pdev, 0);
>> =A0=A0=A0=A0=A0 if (ret <=3D 0) {
>> @@ -2325,6 +2335,7 @@ static int isp_probe(struct platform_device *pdev)
>> =A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0 isp->irq_num =3D ret;
>> =A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk("isp_probe: 9\n");
>> =A0=A0=A0=A0=A0 if (devm_request_irq(isp->dev, isp->irq_num, isp_isr, IR=
QF_SHARED,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "OMAP3 ISP", isp)=
) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(isp->dev, "Unable to request IRQ\n");
>> @@ -2332,6 +2343,7 @@ static int isp_probe(struct platform_device *pdev)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_iommu;
>> =A0=A0=A0=A0=A0 }
>> =A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk("isp_probe: 10=
\n");
>> =A0=A0=A0=A0=A0 /* Entities */
>> =A0=A0=A0=A0=A0 ret =3D isp_initialize_modules(isp);
>> =A0=A0=A0=A0=A0 if (ret < 0)
>> @@ -2345,27 +2357,35 @@ static int isp_probe(struct platform_device
>> *pdev)
>> =A0=A0=A0=A0=A0 if (ret < 0)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_register_entities;
>> =A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk("i=
sp_probe: 11\n");
>> =A0=A0=A0=A0=A0 isp->notifier.ops =3D &isp_subdev_notifier_ops;
>> =A0 =A0=A0=A0=A0=A0 ret =3D v4l2_async_notifier_register(&isp->v4l2_dev,
>> &isp->notifier);
>> =A0=A0=A0=A0=A0 if (ret)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_register_entities;
>> =A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk("i=
sp_probe: 12\n");=A0=A0=A0
>> =A0=A0=A0=A0=A0 isp_core_init(isp, 1);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk("isp_p=
robe: 13\n");=A0=A0=A0=A0=A0=A0=A0
>> =A0=A0=A0=A0=A0 omap3isp_put(isp);
>> =A0 =A0=A0=A0=A0=A0 return 0;
>> =A0 =A0 error_register_entities:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk("isp_p=
robe: f1\n");=A0=A0=A0=A0=A0=A0=A0
>> =A0=A0=A0=A0=A0 isp_unregister_entities(isp);
>> =A0 error_modules:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p=
rintk("isp_probe: f2\n");=A0=A0=A0=A0=A0=A0=A0
>> =A0=A0=A0=A0=A0 isp_cleanup_modules(isp);
>> =A0 error_iommu:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 printk("isp_probe: f3\n");=A0=A0=A0=A0=A0=A0=A0
>> =A0=A0=A0=A0=A0 isp_detach_iommu(isp);
>> =A0 error_isp:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 printk("isp_probe: f4\n");=A0=A0=A0=A0=A0=A0=A0
>> =A0=A0=A0=A0=A0 isp_xclk_cleanup(isp);
>> =A0=A0=A0=A0=A0 __omap3isp_put(isp, false);
>> =A0 error:
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 p=
rintk("isp_probe: f5\n");=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
>> =A0=A0=A0=A0=A0 v4l2_async_notifier_cleanup(&isp->notifier);
>> =A0=A0=A0=A0=A0 mutex_destroy(&isp->isp_mutex);
>> =A0
>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
