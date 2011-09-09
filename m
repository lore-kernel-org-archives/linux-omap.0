From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [RFC PATCH v2 5/6] TI81XX: Add minimal hwmod data
Date: Fri, 9 Sep 2011 08:12:13 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03B4AABE49@dbde02.ent.ti.com>
References: <1314119627-23088-1-git-send-email-hemantp@ti.com>
	<87ty8zoi15.fsf@ti.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B03B4AAB78D@dbde02.ent.ti.com>
	<87ehzrj60m.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87ehzrj60m.fsf@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hilman, Kevin wrote on Thursday, September 08, 2011 11:01 PM:

> "Pedanekar, Hemant" <hemantp@ti.com> writes:
> 
>> Hilman, Kevin wrote on Tuesday, August 30, 2011 6:03 AM:
>> 
>>> Hemant Pedanekar <hemantp@ti.com> writes:
>>> 
>>>> This patch adds minimum required hwmod data (e.g., UARTs) for bootup of
>>>> TI81XX devices (currently common data for TI816X and TI814X is added).
>>>> 
>>>> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
>>> 
>>> I haven't looked at the details yet, but just tried to boot this using
>>> current mainline and it fails.
>>> 
>>> My first guess is that it appears to be related to a missing clkdm for
>>> the MPU hwmod. 
>>> 
>>> Kevin
>> 
>> Thanks for the feedback.
>> 
>> I think that the issue is bacause clk_get() on fck_source is failing
>> as TI816X clock data had different clock source names compared to
>> OMAP3 (e.g., osc_sys_ck instead of sys_ck). I will update this in next
>> version.
> 
> Actually, I realized also that ti816x doesn't boot on current
> l-o master
> branch, even without this series.
> 
>> Even after this, the kernel would get stuck at "Calibrating delay loop..."
>> because a few timer register offsets on TI81XX are different than
>> OMAP3.
> 
> At least with my tests, it's getting past that and failing here:
> 
> [...]
> [    0.000000] NR_IRQS:410
> 
> [    0.000000] IRQ: Found an INTC at 0xfa200000 (revision
> 5.0) with 128 interrup
> ts
> 
> [    0.000000] Total of 128 interrupts on 1 active controller
> 
> [    0.000000] omap_hwmod: timer1: cannot setup_one: MPU
> initiator hwmod mpu not
>  yet registered
>
> 
> The reason seems to be that no hwmods are getting registered at all.

Kevin,
By any chance, is patch 6 of this series is not applied in your case?

With all patches in this series applied, I get to following:

[    0.000000] Total of 128 interrupts on 1 active controller
[    0.000000] omap_hwmod: mpu: no clkdm_name
[    0.000000] omap_hwmod: mpu: cannot _init_clocks
[    0.000000] ------------[ cut here ]------------
[    0.000000] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:2031 omap_hwmod_setup_one+0x100/0x14c()
[...]
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000000

The above crash can be fixed by fixing the correct timer clock source
(match name with OMAP3 OSC source):

diff --git a/arch/arm/mach-omap2/clock816x_data.c b/arch/arm/mach-omap2/clock816x_data.c
index 496c205..434837f 100644
--- a/arch/arm/mach-omap2/clock816x_data.c
+++ b/arch/arm/mach-omap2/clock816x_data.c
@@ -40,7 +40,7 @@ static struct clk tclkin_ck = {
 };

 static struct clk osc_sys_ck = {
-       .name           = "osc_sys_ck",
+       .name           = "sys_ck",
        .ops            = &clkops_null,
        .rate           = 27000000,
 };
@@ -994,7 +994,7 @@ static struct clk mcasp2_fck = {
 static struct omap_clk ti816x_clks[] = {
        CLK(NULL,               "sys_32k_ck",           &sys_32k_ck,            CK_TI816X),
        CLK(NULL,               "tclkin_ck",            &tclkin_ck,             CK_TI816X),
-       CLK(NULL,               "osc_sys_ck",           &osc_sys_ck,            CK_TI816X),
+       CLK(NULL,               "sys_ck",               &osc_sys_ck,            CK_TI816X),
        CLK(NULL,               "main_pll_clk1_ck",     &main_pll_clk1_ck,      CK_TI816X),
        CLK(NULL,               "sysclk1_ck",           &sysclk1_ck,            CK_TI816X),
        CLK(NULL,               "dsp_ick",              &dsp_ick,               CK_TI816X),

Now, the boot should reach till "Calibrating delay loop". There will still
be WARNING messages due to absence of MPU clkdm as you mentioned (will fix
in next version), the the hang would be because timer offsets being
different.

(Please note that CONFIG_OMAP_32K_TIMER needs to be disabled)
> 
>> I see there are some patches floating on ML which add reg_map array
>> (similar to i2c driver) but seems they have not (yet) been
>> accepted. Any chance that this will get added to kernel?
> 
> I'm not sure.  Which series are you referring to?
>
I was referring to following:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35182.html

E.g., on TI81XX, counter register is @0x3c instead of 0x28 offset.
 
> Kevin


Thanks.

   Hemant
