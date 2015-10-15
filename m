From: Lokesh Vutla <a0131933@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix oops with LPAE and more than 2GB of
 memory
Date: Thu, 15 Oct 2015 13:25:56 +0530
Message-ID: <561F5C0C.6080106@ti.com>
References: <1444778000-22537-1-git-send-email-tony@atomide.com>
 <561DD014.10403@ti.com> <20151014160245.GA10113@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151014160245.GA10113@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>, Enric Balletbo Serra <eballetbo@gmail.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Grazvydas Ignotas <notasas@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Javier Martinez Canillas <javier@dowhile0.org>, linux-omap@vger.kernel.org, Robert Nelson <robertcnelson@gmail.com>, Marek Belisko <marek@goldelico.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Wednesday 14 October 2015 09:32 PM, Tony Lindgren wrote:
> * Lokesh Vutla <a0131933@ti.com> [151013 20:53]:
>> Hi Tony,
>>
>> On Wednesday 14 October 2015 04:43 AM, Tony Lindgren wrote:
>>> On boards with more than 2GB of RAM booting goes wrong with things not working
>>> and we're getting lots of l3 warnings:
>>>
>>> WARNING: CPU: 0 PID: 1 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x260/0x384()
>>> 44000000.ocp:L3 Custom Error: MASTER MMC6 TARGET DMM1 (Idle): Data Access in User mode during Functional access
>>> ...
>>> [<c044e158>] (scsi_add_host_with_dma) from [<c04705c8>] (ata_scsi_add_hosts+0x5c/0x18c)
>>> [<c04705c8>] (ata_scsi_add_hosts) from [<c046b13c>] (ata_host_register+0x150/0x2cc)
>>> [<c046b13c>] (ata_host_register) from [<c046b38c>] (ata_host_activate+0xd4/0x124)
>>> [<c046b38c>] (ata_host_activate) from [<c047f42c>] (ahci_host_activate+0x5c/0x194)
>>> [<c047f42c>] (ahci_host_activate) from [<c0480854>] (ahci_platform_init_host+0x1f0/0x3f0)
>>> [<c0480854>] (ahci_platform_init_host) from [<c047c9dc>] (ahci_probe+0x70/0x98)
>>> [<c047c9dc>] (ahci_probe) from [<c04220cc>] (platform_drv_probe+0x54/0xb4)
>>>
>>> Let's fix the issue by enabling ZONE_DMA for LPAE.
>>
>> May I know on which platform you have reproduced this?
> 
> This is on the 4GB version of isee igepv5 GEP0050-RB10
> 
> https://isee.biz/products/igep-processor-boards/igepv5-omap5432
> 
>> Just wondering what other changes you made for booting a OMAP5+ based
>> board with more than 2GB.
> 
> Just the minimal dts changes I posted yesterday to use shared dtsi file
> for omap5-uevm variants. Then boot with something like this in the kernel
> cmdline:
> 
> mem=2032M@0x80000000 mem=2048M@0x300000000
Is it the upper 2GB memory starts from 0x3_0000_0000? Looking at the
Table 4-4. "AXI Access memory map" in TRM, it tells it starts from
0x2_0000_0000.(or am I missing something?)

Any chance you tried doing memtest for all this memory?

IIUC, It is not allowed to use the mix of L3 address mapping and MA
physical address mapping. TRM specifies that
"It is expected that the OS uses either the lower 2-GiB space and the
lower aliased address of emif(a) and (b), or the continuous 8-GiB space
and the upper aliasing of the emif(a) and (b) for all EMIF accesses."

I tried a similar 4GB setup and observed few stuff:
- Need to have ARM_PV_FIXUP enabled something similar that is done in
Keystone inorder to shift to higher address space.[1] [2]
- All the peripherals other than MPU, can access only 2GB. So we need to
restrict the DMA and need an addresses translation. Along with this
patch [3] [4] are needed.

[1]
https://git.ti.com/~lokesh/ti-linux-kernel/lokesh-ti-linux-kernel/commit/be7d2d7e18f473e6078cd7c0b25ec3c58f40736b
[2]
https://git.ti.com/~lokesh/ti-linux-kernel/lokesh-ti-linux-kernel/commit/dd0a564ee565405bec5e9f58f0c97fb6714110ac
[3]
https://git.ti.com/~lokesh/ti-linux-kernel/lokesh-ti-linux-kernel/commit/985ed401e04926cb88b23646271dc96900abc50d
[4]
https://git.ti.com/~lokesh/ti-linux-kernel/lokesh-ti-linux-kernel/commit/c1f7568c4cc6f3146b7137783bd403967aabd0d8

Please correct me if I am wrong.

Thanks and regards,
Lokesh
