Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD16C366064;
	Fri, 27 Mar 2026 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630770; cv=pass; b=B8uIGfJsOVFCSAdM3KR+cXMziv5RlrO9+jZYcuJnMKsEvFOiT+/cxGZuME/I+7qCqyjR5kmnlqRInHCc+WjH0yc/0IW0v7iLZXJ94R/55spqiWapb/NucQausnVA3LAY4EbGU8b0tPnChJPeO8c+mhPR+MKmuD2XssRsXD2LSzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630770; c=relaxed/simple;
	bh=Qe5RML/Hqmj2rDYVLmC0B25W2qCLAy/nBL61HBdxPJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePirw5EmN2VUcWzLcGftu+5DTJ0stjVLT7xYv+9lHuEF9AMuspoO1xrRUYnCSpPsEC2dOVmG2biAM8KKfRfzg4vIcqsLq18Bum2JeE/l9Nl6It+kQcYQ2VDaHVgbzH3/PK4dFOujINFewSK/XXsUNien6Qlc6MGm3DfoxkZ6kcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=agH7xrQd; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="agH7xrQd"
Received: from darkstar.musicnaut.iki.fi (85-76-0-165-nat.elisa-mobile.fi [85.76.0.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fj6Lg4nJhz49PtJ;
	Fri, 27 Mar 2026 18:59:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1774630764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8FwbOduKqHuTZuobgPYbtvYtPofEn/om2TCDAMSCsyo=;
	b=agH7xrQdlCax6sFTlqJxqISTgvoi1K6Wdq9u+k5LgYLNGxrWfi6/ggnsirW47EQjXDqKNf
	+O7ldzX7s5TX4WdZeE1F4+/fWuL3YkE1ZGgFIWRkkVFP7cJji732fjKc/pKi3qsnQK88PI
	3EhpFUbVg7pYG2IZm8jQWcPDK4Bwoh89BHddbHfh5HalPyDZDkasqABSG1LaSI7qJsbnjP
	dJDhBLL4/dJog1pdL6AzfUSUidoZmi15mzNhfXHXAIrxNjPv3FEnSJSTywQV1G/osYspMj
	RkrWLMTVZauNma1Vo3wc6ue0EKRFiRp/QtSYuRl/tIhe4Pv8qedNkkZz7hDrww==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1774630764;
	b=kW9rGO0o0yWaJqq1ssGWh2sM2mmA/vU/Rcq06XQl0R01NcRJyK51qR5oQnUqs7vNIIhEY6
	wdLCRBK71fnBgH8SOU7NuN3YToFaASobaT6cqfXQdzwAPzvit9FooqLm0AILHxyT6+gjGt
	XDftEEmjBQ/L4vPJEZDofXmlcL8wlf9A49rausGYbn6Jwm4mFe+R2Mnxs313NLs1G2hTGD
	EwiIXeNN2NBsEU2dK9oPIAK+ujlC5X2rUgmVcgGEjOm8CGgqS5aiv/KUIGRnf14z01ke4t
	QhcJ+P/xldhHX0UdFAYUnfJmkA3uipfundpvAdtwVqy9tD/KTLRH48l188NjWQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1774630764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8FwbOduKqHuTZuobgPYbtvYtPofEn/om2TCDAMSCsyo=;
	b=RqfONC0YZ+xYff7yxUh8uvLSsfxLwXwEBr+d44+8rjgKYgnaggz5KCKYzHpwA4L4cZUs3S
	wv4iK2GMStXGRvM1+5Wz1cj1maAgfRuHc+TYv1DVM8Tcdhf0D9XJ31N2CqYF7qM7gmuezr
	mKfvOnxdNwlrepQq95lSUHXwgumZFUzndIu5kHgJmLb1xnXuJkFXvVL/3s6Wyg1tiXcqkG
	qlm8g3IlkrdOofpcg2etQ4BqdokQ0Nnz7+QOFlqpGmFGtDj5gvn7FQ93FKISR3f75/f8VJ
	41fJLOcLFd7toT1gSSiAjPf1w82x7zlD1GBeID8JYnS0jg1QXPXc1WLFQXoTaw==
Date: Fri, 27 Mar 2026 18:59:22 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Linux-OMAP <linux-omap@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFT PATCH v3] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
Message-ID: <aca3ajb_G3gD24S7@darkstar.musicnaut.iki.fi>
References: <20260212112508.73500-1-bartosz.golaszewski@oss.qualcomm.com>
 <2fb42d16-887a-4564-8e50-c9d6db564c4e@app.fastmail.com>
 <CAMRc=McYj-D8XL_wnmTEucMrwCy1-xr7h0XYrL68soMVHL1SRA@mail.gmail.com>
 <7h1phxpzml.fsf@baylibre.com>
 <CAMRc=McosSU39SERKtjmhJdTv2cPi44PG=bYqAcfQLDX4QB0Tg@mail.gmail.com>
 <CAMRc=MeYMe1gXjiYuQJpNWchp+V1uLkuRuyO3ohQjfAcg9q3MQ@mail.gmail.com>
 <acaOlGcGQEZHQ_mJ@darkstar.musicnaut.iki.fi>
 <CAMRc=McDdK8Y7wtG8WObjD6WF-2ftKBDwKbvj=xL-NMfeV=bPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=McDdK8Y7wtG8WObjD6WF-2ftKBDwKbvj=xL-NMfeV=bPQ@mail.gmail.com>

Hi,

On Fri, Mar 27, 2026 at 03:22:12PM +0100, Bartosz Golaszewski wrote:
> Hmm, I'm wondering if there's a race with consumers already requesting
> the GPIOs after the controller device is registered but before the
> software node is added. I'll send a version with software nodes being
> registered first, then passes as firmware nodes to the platform device
> API before the device is registered.

It crashes early, I was able to get an UART log from OSK (another
16xx board):

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 7.0.0-rc5-osk-00010-g9a0a87d27dc0 (aakoskin@lonestar) (arm-linux-gnueabi-gcc (GCC) 13.4.0, GNU ld (GNU Binutils) 2.45) #1 2026-03-26
[    0.000000] CPU: ARM926EJ-S [41069263] revision 3 (ARMv5TEJ), cr=0005317f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: TI-OSK
[    0.000000] Ignoring tag cmdline (using the default kernel command line)
[    0.000000] printk: legacy bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] OMAP1611b revision 2 handled as 16xx id: 8d058f7948920905
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000010000000-0x0000000011ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000010000000-0x0000000011ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000010000000-0x0000000011ffffff]
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Kernel command line: mem=32M console=ttyS0,115200 earlyprintk initcall_debug loglevel=9
[    0.000000] printk: log buffer data + meta data: 131072 + 409600 = 540672 bytes
[    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
[    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 8192
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] Total of 128 interrupts in 4 interrupt banks
[    0.000000] Clocks: ARM_SYSST: 0x1000 DPLL_CTL: 0x2833 ARM_CKCTL: 0x2000
[    0.000000] Clocking rate (xtal/DPLL1/MPU): 12.0/96.0/96.0 MHz
[    0.000000] clocksource: 32k_counter: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 58327039986419 ns
[    0.000030] sched_clock: 32 bits at 33kHz, resolution 30517ns, wraps every 65535999984741ns
[    0.008880] OMAP clocksource: 32k_counter at 32768 Hz
[    0.015106] Calibrating delay loop... 47.51 BogoMIPS (lpj=237568)
[    0.130798] CPU: Testing write buffer coherency: ok
[    0.137451] pid_max: default: 32768 minimum: 301
[    0.144683] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.152648] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.166381] VFS: Finished mounting rootfs on nullfs
[    0.197753] entering initcall level: early
[    0.202270] calling  allocate_overflow_stacks+0x0/0x50 @ 1
[    0.209045] initcall allocate_overflow_stacks+0x0/0x50 returned 0 after 0 usecs
[    0.217315] calling  init_static_idmap+0x0/0x118 @ 1
[    0.223144] Setting up static identity map for 0x10008400 - 0x1000843c
[    0.230438] initcall init_static_idmap+0x0/0x118 returned 0 after 10000 usecs
[    0.238555] calling  spawn_ksoftirqd+0x0/0x70 @ 1
[    0.246643] initcall spawn_ksoftirqd+0x0/0x70 returned 0 after 10000 usecs
[    0.254516] calling  init_signal_sysctls+0x0/0x4c @ 1
[    0.260589] initcall init_signal_sysctls+0x0/0x4c returned 0 after 0 usecs
[    0.268432] calling  init_umh_sysctls+0x0/0x2c @ 1
[    0.274139] initcall init_umh_sysctls+0x0/0x2c returned 0 after 10000 usecs
[    0.281799] calling  kthreads_init+0x0/0x34 @ 1
[    0.287139] initcall kthreads_init+0x0/0x34 returned 0 after 0 usecs
[    0.294372] calling  migration_init+0x0/0x2c @ 1
[    0.299560] initcall migration_init+0x0/0x2c returned 0 after 0 usecs
[    0.306823] calling  printk_set_kthreads_ready+0x0/0x34 @ 1
[    0.312957] initcall printk_set_kthreads_ready+0x0/0x34 returned 0 after 0 usecs
[    0.321105] calling  irq_work_init_threads+0x0/0x8 @ 1
[    0.326995] initcall irq_work_init_threads+0x0/0x8 returned 0 after 0 usecs
[    0.334777] calling  init_zero_pfn+0x0/0x2c @ 1
[    0.339813] initcall init_zero_pfn+0x0/0x2c returned 0 after 0 usecs
[    0.346954] calling  init_fs_inode_sysctls+0x0/0x2c @ 1
[    0.352874] initcall init_fs_inode_sysctls+0x0/0x2c returned 0 after 0 usecs
[    0.360809] calling  init_fs_locks_sysctls+0x0/0x2c @ 1
[    0.366943] initcall init_fs_locks_sysctls+0x0/0x2c returned 0 after 0 usecs
[    0.374938] calling  init_fs_sysctls+0x0/0x2c @ 1
[    0.380310] initcall init_fs_sysctls+0x0/0x2c returned 0 after 0 usecs
[    0.389282] Memory: 24296K/32768K available (4054K kernel code, 525K rwdata, 888K rodata, 1688K init, 197K bss, 7868K reserved, 0K cma-reserved)
[    0.408447] devtmpfs: initialized
[    0.428741] entering initcall level: pure
[    0.433135] calling  ipc_ns_init+0x0/0x40 @ 1
[    0.438537] initcall ipc_ns_init+0x0/0x40 returned 0 after 0 usecs
[    0.445617] calling  mmap_min_addr_init+0x0/0x44 @ 1
[    0.451202] initcall mmap_min_addr_init+0x0/0x44 returned 0 after 0 usecs
[    0.458801] calling  pci_realloc_setup_params+0x0/0x48 @ 1
[    0.465057] initcall pci_realloc_setup_params+0x0/0x48 returned 0 after 0 usecs
[    0.472991] calling  inet_frag_wq_init+0x0/0x4c @ 1
[    0.480957] initcall inet_frag_wq_init+0x0/0x4c returned 0 after 0 usecs
[    0.489318] entering initcall level: core
[    0.493927] calling  ptrace_break_init+0x0/0x2c @ 1
[    0.499328] initcall ptrace_break_init+0x0/0x2c returned 0 after 0 usecs
[    0.506805] calling  omap1_pm_runtime_init+0x0/0x20 @ 1
[    0.513122] initcall omap1_pm_runtime_init+0x0/0x20 returned 0 after 0 usecs
[    0.521118] calling  wq_sysfs_init+0x0/0x14 @ 1
[    0.527404] initcall wq_sysfs_init+0x0/0x14 returned 0 after 0 usecs
[    0.534698] calling  ksysfs_init+0x0/0x9c @ 1
[    0.540008] initcall ksysfs_init+0x0/0x9c returned 0 after 0 usecs
[    0.547088] calling  init_jiffies_clocksource+0x0/0x14 @ 1
[    0.553131] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.564086] initcall init_jiffies_clocksource+0x0/0x14 returned 0 after 20000 usecs
[    0.572387] calling  posixtimer_init+0x0/0xd4 @ 1
[    0.578155] posixtimers hash table entries: 512 (order: 0, 2048 bytes, linear)
[    0.586212] initcall posixtimer_init+0x0/0xd4 returned 0 after 10000 usecs
[    0.593994] calling  futex_init+0x0/0xa0 @ 1
[    0.598876] futex hash table entries: 256 (4096 bytes on 1 NUMA nodes, total 4 KiB, linear).
[    0.608123] initcall futex_init+0x0/0xa0 returned 0 after 10000 usecs
[    0.615386] calling  cgroup_wq_init+0x0/0x78 @ 1
[    0.620819] initcall cgroup_wq_init+0x0/0x78 returned 0 after 0 usecs
[    0.628112] calling  cgroup1_wq_init+0x0/0x38 @ 1
[    0.633758] initcall cgroup1_wq_init+0x0/0x38 returned 0 after 0 usecs
[    0.640899] calling  fsnotify_init+0x0/0x30 @ 1
[    0.646606] initcall fsnotify_init+0x0/0x30 returned 0 after 0 usecs
[    0.653961] calling  filelock_init+0x0/0xf8 @ 1
[    0.659484] initcall filelock_init+0x0/0xf8 returned 0 after 0 usecs
[    0.666839] calling  init_script_binfmt+0x0/0x1c @ 1
[    0.672393] initcall init_script_binfmt+0x0/0x1c returned 0 after 0 usecs
[    0.680114] calling  init_elf_binfmt+0x0/0x1c @ 1
[    0.685699] initcall init_elf_binfmt+0x0/0x1c returned 0 after 0 usecs
[    0.692901] calling  gpiolib_dev_init+0x0/0x110 @ 1
[    0.699584] initcall gpiolib_dev_init+0x0/0x110 returned 0 after 0 usecs
[    0.707244] calling  sock_init+0x0/0x108 @ 1
[    0.714630] initcall sock_init+0x0/0x108 returned 0 after 10000 usecs
[    0.721862] calling  sock_struct_check+0x0/0x8 @ 1
[    0.727539] initcall sock_struct_check+0x0/0x8 returned 0 after 0 usecs
[    0.735107] calling  net_inuse_init+0x0/0x24 @ 1
[    0.740417] initcall net_inuse_init+0x0/0x24 returned 0 after 0 usecs
[    0.747802] calling  init_default_flow_dissectors+0x0/0x4c @ 1
[    0.754577] initcall init_default_flow_dissectors+0x0/0x4c returned 0 after 0 usecs
[    0.763244] calling  netlink_proto_init+0x0/0xf8 @ 1
[    0.774932] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.781799] initcall netlink_proto_init+0x0/0xf8 returned 0 after 10000 usecs
[    0.789947] calling  genl_init+0x0/0x38 @ 1
[    0.795166] initcall genl_init+0x0/0x38 returned 0 after 0 usecs
[    0.802490] entering initcall level: postcore
[    0.807495] calling  atomic_pool_init+0x0/0x134 @ 1
[    0.816711] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.824401] initcall atomic_pool_init+0x0/0x134 returned 0 after 10000 usecs
[    0.832092] calling  omap16xx_gpio_init+0x0/0xe4 @ 1
[    0.838867] 8<--- cut here ---
[    0.842224] Unable to handle kernel NULL pointer dereference at virtual address 00000000 when read
[    0.851989] [00000000] *pgd=00000000
[    0.856262] Internal error: Oops: 5 [#1] ARM
[    0.860931] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.0.0-rc5-osk-00010-g9a0a87d27dc0 #1 VOLUNTARY 
[    0.871368] Hardware name: TI-OSK
[    0.874938] PC is at software_node_to_swnode+0x10/0x48
[    0.880554] LR is at device_add_software_node+0x20/0x80
[    0.886230] pc : [<c0273f10>]    lr : [<c0274f20>]    psr: a0000053
[    0.892883] sp : c2809ed0  ip : c2809d94  fp : c052e6ec
[    0.898437] r10: 00000000  r9 : 00000014  r8 : c052bae8
[    0.903991] r7 : 00000005  r6 : c03fe9d4  r5 : c06b3ab0  r4 : c072d000
[    0.910919] r3 : c0759b10  r2 : 00000000  r1 : c03fe9d4  r0 : c03fe9d4
[    0.917846] Flags: NzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
[    0.925506] Control: 0005317f  Table: 10004000  DAC: 00000053
[    0.931579] Register r0 information: non-slab/vmalloc memory
[    0.937713] Register r1 information: non-slab/vmalloc memory
[    0.943786] Register r2 information: NULL pointer
[    0.948883] Register r3 information: non-slab/vmalloc memory
[    0.954956] Register r4 information: non-slab/vmalloc memory
[    0.961029] Register r5 information: non-slab/vmalloc memory
[    0.967132] Register r6 information: non-slab/vmalloc memory
[    0.973205] Register r7 information: non-paged memory
[    0.978637] Register r8 information: non-slab/vmalloc memory
[    0.984710] Register r9 information: non-paged memory
[    0.990173] Register r10 information: NULL pointer
[    0.995330] Register r11 information: non-slab/vmalloc memory
[    1.001525] Register r12 information: 2-page vmalloc region starting at 0xc2808000 allocated at kernel_clone+0xa4/0x20c
[    1.013092] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
[    1.019500] Stack: (0xc2809ed0 to 0xc280a000)
[    1.024230] 9ec0:                                     c072d000 c0529474 c06b3aa0 c050a3cc
[    1.032958] 9ee0: c072d000 c085c000 00000002 c052582c c050a324 c072d000 00000000 c0503160
[    1.041687] 9f00: 00002710 00000000 c04da8f8 c0060900 c2809f64 ffffffff 00010000 946f70b5
[    1.050384] 9f20: 00000062 c0816120 00000002 c052582c c0525848 c072d000 c04da8f8 c0060a18
[    1.059112] 9f40: c2809f64 c2809f64 00000000 946f70b5 00000062 c0816120 00000002 c052582c
[    1.067810] 9f60: c052584c c072d000 c04da8f8 c050352c 00000002 00000002 00000000 c0502400
[    1.076507] 9f80: c2809f7c 00000000 c03f86f4 00000000 00000000 00000000 00000000 00000000
[    1.085205] 9fa0: 00000000 c03f8704 00000000 c000850c 00000000 00000000 00000000 00000000
[    1.093902] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.102600] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    1.111206] Call trace: 
[    1.111328]  software_node_to_swnode from device_add_software_node+0x20/0x80
[    1.121704]  device_add_software_node from omap16xx_gpio_init+0xa8/0xe4
[    1.128997]  omap16xx_gpio_init from do_one_initcall+0x68/0x1f4
[    1.135620]  do_one_initcall from kernel_init_freeable+0x1ec/0x240
[    1.142517]  kernel_init_freeable from kernel_init+0x10/0x108
[    1.148864]  kernel_init from ret_from_fork+0x14/0x28
[    1.154357] Exception stack(0xc2809fb0 to 0xc2809ff8)
[    1.159820] 9fa0:                                     00000000 00000000 00000000 00000000
[    1.168518] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.177185] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    1.184295] Code: e3500000 012fff1e e59f3034 e5932000 (e5923000) 
[    1.191040] ---[ end trace 0000000000000000 ]---
[    1.196350] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    1.204559] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

A.
