From: Nishanth Menon <nm@ti.com>
Subject: Re: Runtime warning due to commit 'ARM: OMAP: Catch callers of
 revision information prior to it being populated' in -next
Date: Tue, 19 Apr 2016 09:21:25 -0500
Message-ID: <57163EE5.9090405@ti.com>
References: <5715B5EC.2040000@roeck-us.net> <57162261.4070409@ti.com>
 <20160419141320.GB5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160419141320.GB5995@atomide.com>
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
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-omap@vger.kernel.org

On 04/19/2016 09:13 AM, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [160419 05:21]:
>> On 04/18/2016 11:37 PM, Guenter Roeck wrote:
>>
>> + linux-omap, linux-arm
>>
>>> commit 'ARM: OMAP: Catch callers of revision information prior to it
>>> being populated' results in a runtime warning on various non-OMAP
>>> architectures. I have seen it with the following qemu tests.
>>>
>>> arm:vexpress-a9:multi_v7_defconfig:vexpress-v2p-ca9
>>> arm:vexpress-a15:multi_v7_defconfig:vexpress-v2p-ca15-tc1
>>> arm:xilinx-zynq-a9:multi_v7_defconfig:zynq-zc702
>>> arm:xilinx-zynq-a9:multi_v7_defconfig:zynq-zc706
>>> arm:xilinx-zynq-a9:multi_v7_defconfig:zynq-zed
>>> arm:midway:multi_v7_defconfig:ecx-2000
>>> arm:smdkc210:multi_v7_defconfig:exynos4210-smdkv310
>>>
>>> It is also reported by kernelci.org in at least one boot test for imx6q-cm-fx6.
>>
>> Thanks for the report... :(
> 
> Oh crap, sorry about that. I'll revert that commit immediately.
> 


Thanks. Sorry about the same as well..

>>> The warning is as follows.
>>>
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/id.c:49 omap_rev+0x3c/0x50
>>> Modules linked in:
>>> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.6.0-rc2-next-20160411 #1
>>> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
>>> [<c030f970>] (unwind_backtrace) from [<c030b094>] (show_stack+0x10/0x14)
>>> [<c030b094>] (show_stack) from [<c0585424>] (dump_stack+0x84/0xa4)
>>> [<c0585424>] (dump_stack) from [<c0341774>] (__warn+0xd4/0x100)
>>> [<c0341774>] (__warn) from [<c03417c0>] (warn_slowpath_null+0x20/0x28)
>>> [<c03417c0>] (warn_slowpath_null) from [<c0324024>] (omap_rev+0x3c/0x50)
>>> [<c0324024>] (omap_rev) from [<c1114a18>] (__omap4_sar_ram_init+0x8/0x88)
>>> [<c1114a18>] (__omap4_sar_ram_init) from [<c0301e5c>] (do_one_initcall+0x3c/0x16c)
>>> [<c0301e5c>] (do_one_initcall) from [<c1100ccc>] (kernel_init_freeable+0x70/0x1ec)
>>> [<c1100ccc>] (kernel_init_freeable) from [<c0b495e4>] (kernel_init+0x8/0x110)
>>> [<c0b495e4>] (kernel_init) from [<c0307f78>] (ret_from_fork+0x14/0x3c)
>>> ---[ end trace cb88537fdc8fa200 ]---
>>>
>>> Please have a look.
>>
>> Tony,
>> Should we get rid of omap_initcall callers(move them into
>> board-generic call path or lower the check not to include default of 0?
> 
> Most of those will disappear when we drop the legacy booting support
> for omap3. I would not touch those before then to avoid churn with
> the legacy code.

Sounds good to me.

-- 
Regards,
Nishanth Menon
