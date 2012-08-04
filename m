From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] printk: add option to print cpu id
Date: Sat, 4 Aug 2012 07:16:08 +0200
Message-ID: <20120804051608.GB6728@liondog.tnic>
References: <1343985378-22330-1-git-send-email-vikram.pandita@ti.com>
 <D958900912E20642BCBC71664EFECE3E6DDCAC49AB@BGMAIL02.nvidia.com>
 <D958900912E20642BCBC71664EFECE3E6DDCAC49AE@BGMAIL02.nvidia.com>
 <CAFm5wm2Z+FyVqG5oMWiEmZ8Je88hJ-cyDXmJw0wp4mqA-X9eYg@mail.gmail.com>
 <CAPXgP13UBwQLs+m_aSk3Ljbktz8WrL+ZO_Tfhrt_+tRBCARyQQ@mail.gmail.com>
 <CAFm5wm0nf47bcTu7iiXA3geR_5dDTF1tnf81Lz7JzbWkKdhUtA@mail.gmail.com>
 <CAPXgP11A=QfOt4SL2GvhsepP8JiDFfdaAhi6-AhW++-AvOz+aw@mail.gmail.com>
 <20120803104212.GA6936@x1.osrc.amd.com>
 <CAFm5wm0rsvuBafMH+9PpKwfaBimbRrVzxYV0nD_pg1yisAYwxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFm5wm0rsvuBafMH+9PpKwfaBimbRrVzxYV0nD_pg1yisAYwxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: Kay Sievers <kay@vrfy.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Venu Byravarasu <vbyravarasu@nvidia.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Vimarsh Zutshi <vimarsh.zutshi@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 03, 2012 at 09:46:15AM -0700, Pandita, Vikram wrote:
> I mostly work with ARM Soc - specifically on OMAP. SMP multi core
> systems in ARM-v7 world started to show up only few years back -
> unlike x86 world.

This is exactly the thing: other SMP vendors have made it so far without
emitting which core is doing what in dmesg.

> ARM systems are a bit unique when it comes to security( read trust
> zone ), and handling of FIQ's. Most of the ARM cortex-A series SoC's
> out there have some kind of affinity to CPU0 being the master. One use
> case has been, it has helped to know with this printk logging, if such
> constraints are honored.
>
> Sometimes, tracking of some lockup cases between cpu's because of bad
> code has also been helpful with this logging support. For now i will
> post v3 of the patch and add arm-list and linux-omap list, and there
> might be users there can benefit.

Right, so if arm people need this thing, why not make it arm-only? I
still fail to see the need for this (... at all, actually).

Thanks.

-- 
Regards/Gruss,
    Boris.
