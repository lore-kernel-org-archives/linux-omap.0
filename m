From: "Matwey V. Kornilov" <matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org>
Subject: Re: [OOPS] cppi41_dma_channel_program: Unable to handle kernel NULL
 pointer dereference
Date: Fri, 20 May 2016 16:32:06 +0300
Message-ID: <CAJs94EZjWi0KGn_siyXNGvjO2DTh2aXtYqKzy7Km7mA_bYTeKg@mail.gmail.com>
References: <1463750386-6259-1-git-send-email-matwey@sai.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463750386-6259-1-git-send-email-matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

2016-05-20 16:19 GMT+03:00  <matwey-TTlVxmypnbovJsYlp49lxw@public.gmane.org>:
> Hello,
>
> I am running 4.6-rc3 on BealgeBone Black and when I try to interract with pwc webcam attached to usb port the following kernel panic happening.

Please note, that the same is happening with 4.6.0 release.

>
> Please also find used kernel config here:
> http://kernel.opensuse.org/cgit/kernel-source/plain/config/armv7hl/default?id=43f1ed415e2227af11856fc120821c791d51494d
>
> [ 4587.746169] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [ 4587.754333] pgd = c0204000
> [ 4587.757055] [00000000] *pgd=00000000
> [ 4587.760667] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
> [ 4587.766095] Modules linked in: af_packet bridge stp llc nls_iso8859_1 nls_cp437 vfat fat snd_usb_audio snd_usbmidi_lib snd_hwdep snd_rawmidi snd_seq_device snd_pcm snd_timer snd soundcore pwc videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_core videodev media smsc musb_dsps musb_hdrc udc_core davinci_mdio phy_am335x usbcore phy_am335x_control phy_generic cppi41 usb_common wkup_m3_rproc remoteproc virtio_ring virtio pps_gpio ti_cpsw pps_core cpsw_ale cpsw_common omap_aes davinci_cpdma omap_sham crypto_engine omap_rng omap_mailbox musb_am335x omap_wdt at24 nvmem_core leds_gpio cpufreq_dt mmc_block tps65217_regulator omap_hsmmc omap_dma mmc_core tps65217 sg
> [ 4587.825879] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc3-2.gcfd5095-default #1
> [ 4587.833745] Hardware name: Generic AM33XX (Flattened Device Tree)
> [ 4587.839867] task: c15081c0 ti: c1500000 task.ti: c1500000
> [ 4587.845453] PC is at cppi41_dma_channel_program+0x20/0x2f0 [musb_hdrc]
> [ 4587.852063] LR is at musb_host_rx+0xc54/0xdd4 [musb_hdrc]
> [ 4587.857490] pc : [<bf29f210>]    lr : [<bf297570>]    psr: 000e0193
> [ 4587.857490] sp : c1501c48  ip : c1501cb8  fp : c1501cb4
> [ 4587.869021] r10: 9b8443c0  r9 : d92baf48  r8 : e0c72c10
> [ 4587.874270] r7 : 00000000  r6 : 000003c0  r5 : d9c8e900  r4 : d92ba010
> [ 4587.880827] r3 : 9b8443c0  r2 : 00000000  r1 : 000003c0  r0 : 00000000
> [ 4587.887385] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> [ 4587.894815] Control: 10c5387d  Table: 9b4fc019  DAC: 00000055
> [ 4587.900587] Process swapper/0 (pid: 0, stack limit = 0xc1500220)
> [ 4587.906621] Stack: (0xc1501c48 to 0xc1502000)
> [ 4587.911002] 1c40:                   00000001 00000000 c1501ca4 c1501c60 df926740 c1501c68
> [ 4587.919221] 1c60: c03efed0 c0344ec8 8065dcc6 00000000 c153c490 df926740 df926740 20000193
> [ 4587.927440] 1c80: 00000000 df926740 c1504920 d92ba010 d9c8e900 000003c0 00000000 e0c72c10
> [ 4587.935659] 1ca0: d92baf48 bf2a55cc c1501d2c c1501cb8 bf297570 bf29f1fc 000003c0 df926740
> [ 4587.943877] 1cc0: c1501cf4 c1501cd0 c038ffac c038fef0 00000000 9b8443c0 00000c40 d92ba308
> [ 4587.952096] 1ce0: d9dcc000 bf2a55c4 db50f800 0000000e 00000000 bf2a4838 e0c72c10 db50f814
> [ 4587.960315] 1d00: c1501d44 d9dcc3bc d92baf48 d92baf48 d92ba010 d92ba010 e0c72c10 00000000
> [ 4587.968533] 1d20: c1501d3c c1501d30 bf28ffb4 bf296928 c1501d94 c1501d40 bf29eb10 bf28ff28
> [ 4587.976751] 1d40: c0392284 c0391db8 c1501d8c c1501d58 c03abc14 c0392274 c03e77e8 00000000
> [ 4587.984970] 1d60: c03c73f0 db4f9bf0 db4f9bec d9dcc3bc 00000000 d92baf48 bf2a5348 d92ba010
> [ 4587.993188] 1d80: 200e0193 00000000 c1501de4 c1501d98 bf29ec1c bf29e990 c1501dc4 c1501da8
> [ 4588.001406] 1da0: c03ac91c c0c39b04 d9c8e900 00000002 00000002 000003c0 c03e4a18 00000000
> [ 4588.009625] 1dc0: db30ac10 00000000 00000001 00000080 00000004 000000a0 c1501e1c c1501de8
> [ 4588.017843] 1de0: bf16ff38 bf29eb68 c150d8c0 c03e4a18 c1501e3c d9d4fd80 db40b2a0 db40b250
> [ 4588.026062] 1e00: 00000001 000000b8 00000000 c1500020 c1501e6c c1501e20 c03c7260 bf16fe48
> [ 4588.034281] 1e20: 0000042c 00000000 00000000 c162b1a4 c162b1c0 db40b240 c15035ac 00000000
> [ 4588.042499] 1e40: c1501e7c db40b240 db40b2a0 db40b250 00000001 db02e000 c150361c 00000000
> [ 4588.050718] 1e60: c1501e8c c1501e70 c03c74a0 c03c71a8 db40b240 db40b2a0 db40b250 00000001
> [ 4588.058936] 1e80: c1501eac c1501e90 c03cabf0 c03c7464 c143b77c 00000000 00000000 00000001
> [ 4588.067154] 1ea0: c1501ebc c1501eb0 c03c676c c03cab40 c1501ee4 c1501ec0 c03c6abc c03c6744
> [ 4588.075373] 1ec0: c16f981c 600e0013 ffffffff c1501f34 c162b9a0 c150361c c1501efc c1501ee8
> [ 4588.083592] 1ee0: c0301770 c03c6a5c c0315568 600e0013 c1501f5c c1501f00 c0c3a280 c0301738
> [ 4588.091810] 1f00: 00000001 00000000 00000000 c032c5c0 c1500000 c1503614 00000000 c15035ac
> [ 4588.100029] 1f20: c162b9a0 c150361c 00000000 c1501f5c c1501f60 c1501f50 c0315560 c0315568
> [ 4588.108247] 1f40: 600e0013 ffffffff c03d5acc c03acc04 c1501f6c c1501f60 c03acc04 c0315524
> [ 4588.116466] 1f60: c1501f94 c1501f70 c03acf24 c03acbe0 00000002 c162ad8b c143d988 c1501f70
> [ 4588.124685] 1f80: c0c35e64 c1503500 c1501fac c1501f98 c0c33f18 c03acc24 c163f040 00000001
> [ 4588.132904] 1fa0: c1501ff4 c1501fb0 c1300db8 c0c33e90 ffffffff ffffffff 00000000 c1300714
> [ 4588.141122] 1fc0: 00000000 c13b4a28 00000000 c163f5d4 c1503588 c13b4a24 c150973c 80204059
> [ 4588.149340] 1fe0: 413fc082 00000000 00000000 c1501ff8 8020807c c13009c0 00000000 00000000
> [ 4588.157705] [<bf29f210>] (cppi41_dma_channel_program [musb_hdrc]) from [<bf297570>] (musb_host_rx+0xc54/0xdd4 [musb_hdrc])
> [ 4588.168901] [<bf297570>] (musb_host_rx [musb_hdrc]) from [<bf28ffb4>] (musb_dma_completion+0x98/0x9c [musb_hdrc])
> [ 4588.179310] [<bf28ffb4>] (musb_dma_completion [musb_hdrc]) from [<bf29eb10>] (cppi41_trans_done+0x18c/0x1d8 [musb_hdrc])
> [ 4588.190329] [<bf29eb10>] (cppi41_trans_done [musb_hdrc]) from [<bf29ec1c>] (cppi41_dma_callback+0xc0/0x288 [musb_hdrc])
> [ 4588.201224] [<bf29ec1c>] (cppi41_dma_callback [musb_hdrc]) from [<bf16ff38>] (cppi41_irq+0xfc/0x198 [cppi41])
> [ 4588.211214] [<bf16ff38>] (cppi41_irq [cppi41]) from [<c03c7260>] (handle_irq_event_percpu+0xc4/0x2bc)
> [ 4588.220486] [<c03c7260>] (handle_irq_event_percpu) from [<c03c74a0>] (handle_irq_event+0x48/0x70)
> [ 4588.229410] [<c03c74a0>] (handle_irq_event) from [<c03cabf0>] (handle_level_irq+0xbc/0x150)
> [ 4588.237807] [<c03cabf0>] (handle_level_irq) from [<c03c676c>] (generic_handle_irq+0x34/0x48)
> [ 4588.246290] [<c03c676c>] (generic_handle_irq) from [<c03c6abc>] (__handle_domain_irq+0x6c/0xc8)
> [ 4588.255038] [<c03c6abc>] (__handle_domain_irq) from [<c0301770>] (omap_intc_handle_irq+0x44/0xa8)
> [ 4588.263965] [<c0301770>] (omap_intc_handle_irq) from [<c0c3a280>] (__irq_svc+0x40/0x74)
> [ 4588.272006] Exception stack(0xc1501f00 to 0xc1501f48)
> [ 4588.277085] 1f00: 00000001 00000000 00000000 c032c5c0 c1500000 c1503614 00000000 c15035ac
> [ 4588.285304] 1f20: c162b9a0 c150361c 00000000 c1501f5c c1501f60 c1501f50 c0315560 c0315568
> [ 4588.293518] 1f40: 600e0013 ffffffff
> [ 4588.297035] [<c0c3a280>] (__irq_svc) from [<c0315568>] (arch_cpu_idle+0x50/0x54)
> [ 4588.304485] [<c0315568>] (arch_cpu_idle) from [<c03acc04>] (default_idle_call+0x30/0x44)
> [ 4588.312623] [<c03acc04>] (default_idle_call) from [<c03acf24>] (cpu_startup_entry+0x30c/0x370)
> [ 4588.321292] [<c03acf24>] (cpu_startup_entry) from [<c0c33f18>] (rest_init+0x94/0x98)
> [ 4588.329082] [<c0c33f18>] (rest_init) from [<c1300db8>] (start_kernel+0x404/0x410)
> [ 4588.336606] Code: e52de004 e8bd4000 e1a06001 e1a0a003 (e5904000)
> [ 4588.349648] ---[ end trace 603f1cfffd4f1ec2 ]---
> [ 4588.354298] Kernel panic - not syncing: Fatal exception in interrupt
> [ 4588.360689] Rebooting in 90 seconds..



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
