From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] ARM: omap2plus_defconfig: Fix selected panels after
 generic panel changes
Date: Sat, 5 Oct 2019 12:50:37 +0200
Message-ID: <39E48EC6-65FE-419B-BBE8-E72CB44B517D@goldelico.com>
References: <20191003165539.50318-1-tony@atomide.com>
 <03ca02c1-2816-17cd-03fd-5b72e5d0ec96@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <03ca02c1-2816-17cd-03fd-5b72e5d0ec96@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Jyri Sarha <jsarha@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

> Am 04.10.2019 um 10:41 schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:
> 
> On 03/10/2019 19:55, Tony Lindgren wrote:
>> The old omapdrm panels got removed for v5.4 in favor of generic panels,
>> and the Kconfig options changed. Let's update omap2plus_defconfig
>> accordingly so the same panels are still enabled.
>> Cc: Jyri Sarha <jsarha@ti.com>
>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>>  arch/arm/configs/omap2plus_defconfig | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
>> --- a/arch/arm/configs/omap2plus_defconfig
>> +++ b/arch/arm/configs/omap2plus_defconfig
>> @@ -356,14 +356,14 @@ CONFIG_DRM_OMAP_CONNECTOR_HDMI=m
>>  CONFIG_DRM_OMAP_CONNECTOR_ANALOG_TV=m
>>  CONFIG_DRM_OMAP_PANEL_DPI=m
>>  CONFIG_DRM_OMAP_PANEL_DSI_CM=m
>> -CONFIG_DRM_OMAP_PANEL_SONY_ACX565AKM=m
>> -CONFIG_DRM_OMAP_PANEL_LGPHILIPS_LB035Q02=m
>> -CONFIG_DRM_OMAP_PANEL_SHARP_LS037V7DW01=m
>> -CONFIG_DRM_OMAP_PANEL_TPO_TD028TTEC1=m
>> -CONFIG_DRM_OMAP_PANEL_TPO_TD043MTEA1=m
>> -CONFIG_DRM_OMAP_PANEL_NEC_NL8048HL11=m
>>  CONFIG_DRM_TILCDC=m
>>  CONFIG_DRM_PANEL_SIMPLE=m
>> +CONFIG_DRM_PANEL_LG_LB035Q02=m
>> +CONFIG_DRM_PANEL_NEC_NL8048HL11=m
>> +CONFIG_DRM_PANEL_SHARP_LS037V7DW01=m
>> +CONFIG_DRM_PANEL_SONY_ACX565AKM=m
>> +CONFIG_DRM_PANEL_TPO_TD028TTEC1=m
>> +CONFIG_DRM_PANEL_TPO_TD043MTEA1=m
>>  CONFIG_FB=y
>>  CONFIG_FIRMWARE_EDID=y
>>  CONFIG_FB_MODE_HELPERS=y
> 
> Sorry, I didn't remember to update these. Some additions:
> 
> These can be dropped, they no longer exist:
> 
> CONFIG_DRM_OMAP_ENCODER_TFP410=m
> CONFIG_DRM_OMAP_CONNECTOR_DVI=m
> CONFIG_DRM_OMAP_PANEL_DPI=m

After being hit by the __always_inline issue [1] I am now
back with being able to test v5.4-rc1.

Now this patch fixes the build problem, but we still have
one: panel drivers are no longer automatically loaded at
boot. We now need to manually modprobe them.

This has been observed with GTA04 (TD028TTEC1) and OpenPandora
(TD043MTEA1). So moving the drivers seems to have changed/broken
something with DT based driver matching.

BR and thanks,
Nikolaus


[1]: https://lkml.org/lkml/2019/10/2/201
