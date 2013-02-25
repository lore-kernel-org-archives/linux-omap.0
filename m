From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 8/8] ARM: dts: OMAP5: Add ocp address space for all hwmods
Date: Mon, 25 Feb 2013 16:46:08 +0530
Message-ID: <512B47F8.10507@ti.com>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com> <1361374735-22018-9-git-send-email-santosh.shilimkar@ti.com> <512B435C.20803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51138 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375Ab3BYLOp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Feb 2013 06:14:45 -0500
In-Reply-To: <512B435C.20803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Monday 25 February 2013 04:26 PM, Benoit Cousson wrote:
> Hi Santosh,
>
>
> On 02/20/2013 04:38 PM, Santosh Shilimkar wrote:
>> Patch adds the OCP address space for all missing hwmod from existing
>> DT file. Note that the compatible isn't added by purpose to ensure that for
>> these hwmod, devices are not getting created.
>
> Mmm, that will make the DTS a little bit weird and non-standard.
> You'd better use the status=disabled flag for that.
>
IIRC, we thought about it and then decided against it. I expect that
when a real device support get added the drivers will add compatible
information and also update the node with rest of the data.

>> Cc: Benoit Cousson <b-cousson@ti.com>
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>   arch/arm/boot/dts/omap5.dtsi |  238 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 238 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
>> index 269a328..915fd11 100644
>> --- a/arch/arm/boot/dts/omap5.dtsi
>> +++ b/arch/arm/boot/dts/omap5.dtsi
>> @@ -500,5 +500,243 @@
>>   			hw-caps-ll-interface;
>>   			hw-caps-temp-alert;
>>   		};
>> +
>> +		l4_emif_ocp_fw: l4_emif_ocp_fw@4a20c000 {
>> +			reg = <0x4a20c000 0x100>;
>> +			ti,hwmods = "emif_ocp_fw";
>> +		};
>
> Are we doing anything useful with this entry, and potentially all the
> other non-regular entries like that.
>
Mostly not. Some of the entries did gave me trouble for the boot and
hence I retained as it is in hwmod. I will make another pass to see
if we can remove them.

>> +
>> +		mpu_l3_main_1: mpu_l3_main_1@44000000 {
>> +			reg = <0x44000000 0x2000>;
>> +			ti,hwmods = "l3_main_1";
>> +		};
>> +
>> +		mpu_l3_main_2: mpu_l3_main_2@44800000 {
>> +			reg = <0x44800000 0x3000>;
>> +			ti,hwmods = "l3_main_2";
>> +		};
>> +
>> +		mpu_l3_main_3: mpu_l3_main_3@45000000 {
>> +			reg = <0x44800000 0x4000>;
>> +			ti,hwmods = "l3_main_3";
>> +		};
>
> The slit is due to PM partitioning, but that should be represented as an
> unique device.
>
Can be done

>> +
>> +		l4_ocp_wp_noc: l4_ocp_wp_noc@4a102000 {
>> +			reg = <0x44800000 0x80>;
>> +			ti,hwmods = "ocp_wp_noc";
>> +		};
>> +
>> +		abe_aess: abe_aess@401f1000 {
>> +			reg = <0x44800000 0x400>;
>> +			ti,hwmods = "aess";
>> +		};
>> +
>> +		c2c: c2c@5c000000 {
>> +			reg = <0x5c000000 0x100>;
>> +			ti,hwmods = "c2c";
>> +		};
>> +
>> +		ctrl_module_core: ctrl_module_core@4a002000 {
>> +			reg = <0x4a002000 0x800>,
>> +			      <0x4a002800 0x1000>;
>> +			ti,hwmods = "ctrl_module_core";
>> +		};
>> +
>> +		ctrl_module_wkup: ctrl_module_wkup@4a002000 {
>> +			reg = <0x4ae0c000 0x800>,
>> +			      <0x4ae0c800 0x800>;
>> +			ti,hwmods = "ctrl_module_wkup";
>> +		};
>
> Should probably be one device as well.
>
ok

>> +
>> +		dss: dss@58000000 {
>> +			reg = <0x58000000 0x80>;
>> +			ti,hwmods = "dss_core";
>> +		};
>> +
>> +		dss_dispc: dss_dispc@58001000 {
>> +			reg = <0x58001000 0x1000>;
>> +			ti,hwmods = "dss_dispc";
>> +		};
>> +
>> +		dss_dsi1_a: dss_dsi1_a@58004000 {
>> +			reg = <0x58004000 0x200>;
>> +			ti,hwmods = "dss_dsi1_a";
>> +		};
>> +
>> +		dss_dsi1_b: dss_dsi1_b@58005000 {
>> +			reg = <0x58005000 0x200>;
>> +			ti,hwmods = "dss_dsi1_b";
>> +		};
>> +
>> +		dss_dsi1_c: dss_dsi1_c@58009000 {
>> +			reg = <0x58009000 0x200>;
>> +			ti,hwmods = "dss_dsi1_c";
>> +		};
>> +
>> +		dss_hdmi: dss_hdmi@58060000 {
>> +			reg = <0x58060000 0x19000>;
>> +			ti,hwmods = "dss_hdmi";
>> +		};
>> +
>> +		dss_rfbi: dss_rfbi@580020000 {
>> +			reg = <0x58002000 0x100>;
>> +			ti,hwmods = "dss_rfbi";
>> +		};
>
> For the DSS, you do have to respect the HW hierarchy. hwmod was flat,
> and it was the source of a lot of PM dependency issue.
>
I can update this but as I said, it is best to be left fro driver
owners since they know the IP and hierarchy best.


>> +
>> +		elm: elm@48078000 {
>> +			reg = <0x48078000 0x1000>;
>> +			ti,hwmods = "elm";
>> +		};
>> +
>> +		fdif: elm@4a10a000 {
>> +			reg = <0x4a10a000 0x200>;
>> +			ti,hwmods = "fdif";
>> +		};
>
> Same issue than DSS. FDIF, ISS are somehow related.
>
>> +
>> +		gpmc: gpmc@50000000 {
>> +			reg = <0x50000000 0x400>;
>> +			ti,hwmods = "gpmc";
>> +		};
>> +
>> +		gpu: gpu@5600fe00 {
>> +			reg = <0x5600fe00 0x2000>;
>> +			ti,hwmods = "gpu";
>> +		};
>> +
>> +
>> +		hdq1w: hdq1w@480b2000 {
>> +			reg = <0x480b2000 0x20>;
>> +			ti,hwmods = "hdq1w";
>> +		};
>> +
>> +		hsi: hsi@4a05a000 {
>> +			reg = <0x4a05a000 0x2000>;
>> +			ti,hwmods = "hsi";
>> +		};
>> +
>> +		ipu: ipu@55082000 {
>> +			reg = <0x55082000 0x100>;
>> +			ti,hwmods = "ipu";
>> +		};
>> +
>> +		intc_ipu_c0: intc_ipu_c0@48211000 {
>> +			reg = <0x48211000 0x2000>;
>> +			ti,hwmods = "intc_ipu_c0";
>> +		};
>> +
>> +		intc_ipu_c1: intc_ipu_c1@48211000 {
>> +			reg = <0x48211000 0x2000>;
>> +			ti,hwmods = "intc_ipu_c1";
>> +		};
>
> Do we need such entries?
>
The point is if we remove it from here, we need to
remove associated hwmod entries as well o.w boot
will fail. Anyway, as mentioned I can do another
pass to see if I can remove some more.

For now what you see is what is in hwmod data file.

[..]

>> +		wd_timer2: wd_timer2@4ae14000 {
>> +			reg = <0x4ae14000 0x80>;
>> +			ti,hwmods = "wd_timer2";
>> +		};
>> +
>> +		wd_timer3: wd_timer3@40130000 {
>> +			reg = <0x40130000 0x80>;
>> +			ti,hwmods = "wd_timer3";
>> +		};
>
> In case of real device and existing binding, you must populate every
> entries (IRQ, DMA...).
>
I agree for the drivers which are already DT adapted. I
shall update those ones.

Thanks for review Benoit. I will update the patch based
on comments.

Regards,
Santosh


