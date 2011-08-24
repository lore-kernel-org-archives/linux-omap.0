From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC/PATCH v2 00/13] dt: omap: dt binding with omap_device and
	support for i2c1
Date: Wed, 24 Aug 2011 11:41:01 +0200
Message-ID: <4E54C72D.1050308@ti.com>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com>
	<20110823154119.GE32698@manju-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110823154119.GE32698@manju-desktop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Menon, Nishanth" <nm@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Manju

On 8/23/2011 5:41 PM, G, Manjunath Kondaiah wrote:
> On Tue, Aug 23, 2011 at 10:03:28AM +0500, G, Manjunath Kondaiah wrote:
>>
>> Patch series reworked from:
>> http://permalink.gmane.org/gmane.linux.ports.arm.omap/61674
>> Also added support for i2c1 controller on omap4 based panda
>> board.
>>
>> Baseline:
>> =========
>> git://git.secretlab.ca/git/linux-2.6.git
>> Branch: devicetree/test
>> The above branch is rebased with v3.1-rc2 mainline.
>> +
>> pdev decoupling patches from kevin hilman
>> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg53534.html
>>
>> The patch series is also available at:
>> https://gitorious.org/devicetree/dt_omap/commits/devicetree/dt_rfcv2
>>
>> Testing:
>> ========
>> Build : dt and not dt build for omap2plus_defconfig
>> Boot: OMAP3530 Beagle Board and OMAP4430 Panda board
> 
> Correction: This series will support only i2c1 controller and it will not
> handle i2c1 child devices such as twlxxxx pmic. Due to which, twl read/write's
> might fail during boot.

You mean will fail :-) At least on OMAP4.

[    2.680480] [<c025d438>] (twl_i2c_read+0x34/0x128) from [<c0024368>] (twl6030_uv_to_vsel+0x28/0x84)
[    2.690032] [<c0024368>] (twl6030_uv_to_vsel+0x28/0x84) from [<c0028274>] (_pre_volt_scale+0xac/0x174)
[    2.699829] [<c0028274>] (_pre_volt_scale+0xac/0x174) from [<c0028354>] (vp_forceupdate_scale_voltage+0x18/0x2b0)
[    2.710601] [<c0028354>] (vp_forceupdate_scale_voltage+0x18/0x2b0) from [<c00280a0>] (omap_voltage_scale_vdd+0x54/0x64)
[    2.721954] [<c00280a0>] (omap_voltage_scale_vdd+0x54/0x64) from [<c056ac94>] (omap2_set_init_voltage+0xf0/0x130)
[    2.732757] [<c056ac94>] (omap2_set_init_voltage+0xf0/0x130) from [<c056ad34>] (omap2_common_pm_late_init+0x60/0xb0)
[    2.743835] [<c056ad34>] (omap2_common_pm_late_init+0x60/0xb0) from [<c0008900>] (do_one_initcall+0x94/0x168)
[    2.754272] [<c0008900>] (do_one_initcall+0x94/0x168) from [<c0562828>] (kernel_init+0x80/0x12c)
[    2.763549] [<c0562828>] (kernel_init+0x80/0x12c) from [<c001338c>] (kernel_thread_exit+0x0/0x8)
[    2.772796] Code: 8a000008 e59f70ec e1a09080 e59731ac (e7d32080)

That being said, it looks like the voltage layer should be a little bit more robust and should check the i2c status before using it blindly.

Adding Kevin, Paul and Nishanth in Cc since the voltage layer is currently being cleaned.

> I am facing issues in getting platform_data in i2c child device probe function.
> The issue is reported to grant in patch 08/13 of this series.
> 
> -M
> 
>>
>> Limitation:
>> ===========
>> The current implementation of omap-device build through
>> device tree supports only single instance of hwmod and
>> multiple instances are not supported.
>>
>> G, Manjunath Kondaiah (13):
>>    OMAP: omap_device: Add device tree node pointer
>>    dt: Add pd_size to AUXDATA structure
>>    dt: omap3: add soc file for handling i2c controllers
>>    dt: omap3: beagle board: set clock freq for i2c devices
>>    dt: omap3: add generic board file for dt support
>>    dt: omap3: add omap-device compatible property
>>    dt: omap: create platform bus for omap devices
>>    dt: omap: i2c: add dt support for i2c1 controller
>>    dt: omap4: add soc file for handling i2c controllers
>>    dt: omap4: panda board: set clock freq for i2c devices
>>    dt: omap4: add generic board file for dt support
>>    dt: omap4: enable dt support for i2c1 controller
>>    dt: omap: i2c: dt usage model documentation

Because of the broken i2c support, you should probably re-organize your series to provide at least the basic DT support for people who want to start hacking DT. The i2c support for both OMAP3 & 4 should be added at the very last time with a big disclaimer.
Ideally, you should maybe fix it first:-)

Regards,
Benoit 
