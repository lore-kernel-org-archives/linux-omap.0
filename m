From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [patch-v2.6.39 6/7] OMAP4430: hwmod data: Adding USBOTG
Date: Fri, 18 Feb 2011 16:55:09 +0100
Message-ID: <4D5E965D.7040500@ti.com>
References: <20110217162000.GP20795@atomide.com> <20110217162209.GA13425@legolas.emea.dhcp.ti.com> <20110217165953.GR20795@atomide.com> <4D5D5770.9020501@ti.com> <20110217171747.GC14574@legolas.emea.dhcp.ti.com> <4D5D59E5.6020307@ti.com> <20110217173711.GF14574@legolas.emea.dhcp.ti.com> <4D5D5F13.2010602@ti.com> <20110217181849.GV20795@atomide.com> <4D5E7DFF.7020609@ti.com> <20110218154135.GF11151@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57674 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab1BRPzS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 10:55:18 -0500
In-Reply-To: <20110218154135.GF11151@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

Hi Felipe,

On 2/18/2011 4:41 PM, Balbi, Felipe wrote:
> Hi all,
> 
> On Fri, Feb 18, 2011 at 03:11:11PM +0100, Cousson, Benoit wrote:
>> On 2/17/2011 7:18 PM, Tony Lindgren wrote:
>>> * Cousson, Benoit<b-cousson@ti.com>   [110217 09:45]:
>>>>
>>>> Done, boot tested, and that does remove the warning about the
>>>> missing opt clock you had with the previous data.
>>>>
>>>> git://gitorious.org/omap-pm/linux.git for_2.6.39/omap4_hwmod_data
>>>>
>>>> Just let me know if it does break anything else.
>>>
>>> Pulled into omap-for-linus. Also now merged are the devel-hwspinlock
>>> and devel-mcspi branches.
>>
>> McSPI OMAP4 hwmod data are missing a couple of flags that break the boot for the moment.
>>
>> Govindraj should rebase on the omap4_hwmod_data branch and add the missing rev and dev_attr for the McSPI.
>>
>> Unfortunately, even with that patch omap-for-linus boot hangs after the following trace:
>>
>> [    0.875091] omap_device: omap2_mcspi.1: new worst case activate latency 0: 30517
>> [    0.886657] usbcore: registered new interface driver usbfs
>> [    0.892822] usbcore: registered new interface driver hub
>> [    0.898681] usbcore: registered new device driver usb
>> [    0.904815] omap_i2c omap_i2c.1: bus 1 rev4.0 at 400 kHz
> 
> I tested your branch merged with mine and it was working fine. What else
> is on omap-for-linus ? There are only 28 patches on that branch, a
> bisect would be quick ?

This is what I observed too. There are some early stuff in it + some TI816X... I do not know what is going wrong. 
Please note that there are a little bit more (47) stuff added but they are below the -rc5 tag... The bisect will be longer :-)

 + [HEAD^2] OMAP: runtime: McSPI driver runtime conversion
 + [HEAD^2^] OMAP: devices: Modify McSPI device to adapt to hwmod framework
 + [HEAD^2~2] OMAP3: hwmod data: Add McSPI
 + [HEAD^2~3] OMAP2430: hwmod data: Add McSPI
 + [HEAD^2~4] OMAP2420: hwmod data: Add McSPI
 + [HEAD^] omap: add hwspinlock device
 + [HEAD~2] drivers: hwspinlock: add OMAP implementation
 + [HEAD~3] drivers: hwspinlock: add framework
 + [HEAD~4^2] OMAP4: hwmod data: Add USBOTG
 + [HEAD~4^2^] OMAP4: hwmod data: Add AESS, McPDM, bandgap, counter_32k, MMC, KBD, ISS & IPU
 + [HEAD~4^2~2] OMAP4: hwmod data: Add McBSP
 + [HEAD~4^2~3] OMAP4: hwmod data: Add DMIC
 + [HEAD~4^2~4] OMAP4: hwmod data: Add mailbox
 + [HEAD~4^2~5] OMAP4: hwmod data: Add DSS, DISPC, DSI1&2, RFBI, HDMI and VENC
 + [HEAD~4^2~6] OMAP4: hwmod data: Add timer
 + [HEAD~4^2~7] OMAP4: hwmod data: Add McSPI
 + [HEAD~4^2~8] OMAP4: hwmod data: Add hwspinlock
 + [HEAD~5^3] TI816X: Update to use init_early
 + [HEAD~5^3^] TI816X: Add low level debug support
 + [HEAD~5^3~2] TI816X: Create board support and enable build for TI816X EVM
 + [HEAD~5^3~3] TI816X: Update common OMAP machine specific sources
 + [HEAD~5^3~4] TI816X: Update common omap platform files
 + [HEAD~5^3~5] omap: hwmod: Populate _mpu_rt_va later on in omap_hwmod_late_init
 + [HEAD~5^3~6] omap2+: Fix omap_serial_early_init to work with init_early hook
 + [HEAD~5^3~7] omap2+: Make omap_hwmod_late_init into core_initcall
 + [HEAD~5^3~8] ARM: OMAP2: use early init hook
 + [HEAD~5^2] omap: McBSP: Remove unused audio macros in mcbsp.h
 + [HEAD~5^2^] wip: fix section mismatches in omap1_defconfig
 + [HEAD~5^2~2] ARM: omap: move omap_board_config_kernel to .init.data
 + [HEAD~5^2~3] ARM: omap: move omap_get_config et al. to .init.text
 + [HEAD~5^2~4] ARM: omap1/nokia770: mark some functions __init
 + [HEAD~5^2~5] arm: mach-omap1: board-voiceblue: add missing include
 + [HEAD~5^2~6] ARM: OMAP: Allow platforms to hook reset cleanly
 + [HEAD~5^2~7] arm: mach-omap1: board-h3: make nand_platdata static
 + [HEAD~5^2~8] arm: mach-omap1: board-htcherald: make htcpld_chips and htcpld_pfdata static
 + [HEAD~5^2~9] arm: mach-omap1: board-innovator: make innovator_mmc_init() static
 + [HEAD~5^2~10] arm: mach-omap1: board-h2: make h2_nand_platdata static
 + [HEAD~5^2~11] arm: plat-omap: dma: make omap_dma_in_1510_mode() static
 + [HEAD~5^2~12] arm: omap2: irq: fix compile warning:
 + [HEAD~5^2~13] arm: omap1: fix a bunch of section mismatches
 + [HEAD~5^2~14] arm: omap1: fix compile warnings
 + [HEAD~5^2~15] arm: omap1: fix compile warning
 + [HEAD~5^2~16] arm: omap: i2c: fix compile warning
 + [HEAD~5^2~17] omap: Start using CONFIG_SOC_OMAP
++ [85e2efb] Linux 2.6.38-rc5


Regards,
Benoit
