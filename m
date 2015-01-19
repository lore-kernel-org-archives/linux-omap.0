From: Tyler Baker <tyler.baker@linaro.org>
Subject: Re: [next-20150119]regression (mm)?
Date: Mon, 19 Jan 2015 09:19:57 -0800
Message-ID: <CANMBJr5KdJ41LxaB6d7Hzibu9gjp1HqDx9Fzhe-7Cxk10u3KuA@mail.gmail.com>
References: <54BD33DC.40200@ti.com>
	<CANMBJr6DudDBSs+rM-e2QnC5ztxAYLuSvZ0khvx7OZdQpcu_3A@mail.gmail.com>
	<54BD3930.7010105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <54BD3930.7010105@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-next <linux-next@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

On 19 January 2015 at 09:04, Nishanth Menon <nm@ti.com> wrote:
>
> On 01/19/2015 10:59 AM, Tyler Baker wrote:
>> I can confirm, I am observing the same issue in my lab. 15 platforms
>> failed to boot on next-20150119.
>>
>> http://kernelci.org/boot/?next-20150119&fail
>
> http://kernelci.org/boot/all/job/next/kernel/next-20150119/
> I see many platforms succeed in lab-khilman, but fails in your farm as
> well :(
>
> For example:
> http://storage.kernelci.org/next/next-20150119/arm-imx_v6_v7_defconfig/lab-khilman/boot-imx6q-wandboard.txt
> has the same errors, but marked success.
> http://storage.kernelci.org/next/next-20150119/arm-imx_v6_v7_defconfig/lab-tbaker/boot-imx6q-wandboard.txt
> is marked fail.
>
> I suppose this is much worse than the "pass" status indicates.

I agree. I believe this boots were marked as 'passed' because the
platforms eventually reached userspace despite the kernel spewing
errors. I've re-run a few of my boots, and sometimes the platform
reaches userspace, other times it hangs.

>>
>>
>> On Monday, 19 January 2015, Nishanth Menon <nm@ti.com
>> <mailto:nm@ti.com>> wrote:
>>
>>     Hi,
>>
>>     Most platforms seem broken intoday's next tag.
>>
>>     https://github.com/nmenon/kernel-test-logs/tree/next-20150119
>>     (defconfig: omap2plus_defconfig)
>>
>>     > [    7.166600] ------------[ cut here ]------------
>>     > [    7.171676] WARNING: CPU: 0 PID: 54 at mm/mmap.c:2859
>>     exit_mmap+0x1a8/0x21c()
>>     > [    7.179194] Modules linked in:
>>     > [    7.182479] CPU: 0 PID: 54 Comm: init Not tainted
>>     3.19.0-rc5-next-20150119-00002-gfdefcded1272 #1
>>     > [    7.191863] Hardware name: Generic AM33XX (Flattened Device Tree)
>>     > [    7.198318] [<c00153f0>] (unwind_backtrace) from [<c0011a74>]
>>     (show_stack+0x10/0x14)
>>     > [    7.206528] [<c0011a74>] (show_stack) from [<c0580150>]
>>     (dump_stack+0x78/0x94)
>>     > [    7.214191] [<c0580150>] (dump_stack) from [<c003d4d0>]
>>     (warn_slowpath_common+0x7c/0xb4)
>>     > [    7.222751] [<c003d4d0>] (warn_slowpath_common) from
>>     [<c003d524>] (warn_slowpath_null+0x1c/0x24)
>>     > [    7.232038] [<c003d524>] (warn_slowpath_null) from
>>     [<c012de64>] (exit_mmap+0x1a8/0x21c)
>>     > [    7.240536] [<c012de64>] (exit_mmap) from [<c003abb8>]
>>     (mmput+0x44/0xec)
>>     > [    7.247612] [<c003abb8>] (mmput) from [<c0151368>]
>>     (flush_old_exec+0x300/0x5a4)
>>     > [    7.255357] [<c0151368>] (flush_old_exec) from [<c0195c10>]
>>     (load_elf_binary+0x2ec/0x1144)
>>     > [    7.264111] [<c0195c10>] (load_elf_binary) from [<c0150ea0>]
>>     (search_binary_handler+0x88/0x1ac)
>>     > [    7.273311] [<c0150ea0>] (search_binary_handler) from
>>     [<c019554c>] (load_script+0x260/0x280)
>>     > [    7.282232] [<c019554c>] (load_script) from [<c0150ea0>]
>>     (search_binary_handler+0x88/0x1ac)
>>     > [    7.291066] [<c0150ea0>] (search_binary_handler) from
>>     [<c0151f0c>] (do_execveat_common+0x538/0x6c4)
>>     > [    7.300628] [<c0151f0c>] (do_execveat_common) from
>>     [<c01520c4>] (do_execve+0x2c/0x34)
>>     > [    7.308881] [<c01520c4>] (do_execve) from [<c000e5e0>]
>>     (ret_fast_syscall+0x0/0x4c)
>>     > [    7.316881] ---[ end trace 3b8a46b1b280f423 ]---
>>
>>
>>     --
>>     Regards,
>>     Nishanth Menon
>>
>>     _______________________________________________
>>     linux-arm-kernel mailing list
>>     linux-arm-kernel@lists.infradead.org <javascript:;>
>>     http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>>
>>
>> --
>> Tyler Baker
>> Tech Lead, LAVA
>> Linaro.org | Open source software for ARM SoCs
>> Follow Linaro: http://www.facebook.com/pages/Linaro
>> http://twitter.com/#!/linaroorg - http://www.linaro.org/linaro-blog
>
>
> --
> Regards,
> Nishanth Menon



-- 
Tyler Baker
Tech Lead, LAVA
Linaro.org | Open source software for ARM SoCs
Follow Linaro: http://www.facebook.com/pages/Linaro
http://twitter.com/#!/linaroorg - http://www.linaro.org/linaro-blog
