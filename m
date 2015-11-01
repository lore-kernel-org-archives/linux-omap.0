From: Peter Robinson <pbrobinson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: null pointer dereference in omap_wdt
Date: Sun, 1 Nov 2015 23:11:10 +0000
Message-ID: <CALeDE9O3nU1j_eu4v7JbmKr1-+C1L-qBk3qu3XCcQcnGbbtssA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Lars,

I'm seeing the following crash in omap_wdt in omap_wdt_get_timeleft
when I just run wdctl on a couple of different TI devices, the
beaglebone black/green or panda ES. I'm seeing it on both 4.2.3 and
4.3rc7, looking at git it looks like you added the fuction in June,
have you seen this on any of your platforms?

Peter

[  299.672508] Unable to handle kernel NULL pointer dereference at
virtual address 00000088
[  299.681372] pgd = de35c000
[  299.684385] [00000088] *pgd=00000000
[  299.688205] Internal error: Oops: 5 [#1] SMP ARM
[  299.693086] Modules linked in: ip6t_rpfilter ip6t_REJECT
nf_reject_ipv6 xt_conntrack ebtable_filter ebtable_nat ebtable_broute
bridge stp llc ebtables ip6table_mangle ip6table_security ip6table_nat
nf_conntra
ck_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_raw ip6table_filter
ip6_tables iptable_mangle iptable_security iptable_nat
nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack
iptable_raw musb_dsps musb_
hdrc phy_am335x udc_core phy_generic phy_am335x_control cppi41
omap_aes omap_sham omap_hwspinlock hwspinlock_core omap_rng
omap_mailbox at24 musb_am335x 8250_omap omap_wdt leds_gpio cpufreq_dt
smsc davinci_mdio
mmc_block ti_cpsw cpsw_common ptp pps_core cpsw_ale davinci_cpdma
omap_hsmmc omap_dma mmc_core i2c_dev
[  299.761395] CPU: 0 PID: 1242 Comm: wdctl Not tainted
4.3.0-0.rc7.git0.1.fc24.armv7hl #1
[  299.769841] Hardware name: Generic AM33XX (Flattened Device Tree)
[  299.776280] task: de505b00 ti: dcf26000 task.ti: dcf26000
[  299.782017] PC is at omap_wdt_get_timeleft+0xc/0x20 [omap_wdt]
[  299.788205] LR is at watchdog_ioctl+0x3cc/0x42c
[  299.793001] pc : [<bf09f138>]    lr : [<c0739c54>]    psr: 600f0013
[  299.793001] sp : dcf27f18  ip : 00000003  fp : 7f626bbe
[  299.805114] r10: 00000000  r9 : 00000003  r8 : becb1ab8
[  299.810634] r7 : dbc0837c  r6 : dbc08318  r5 : becb1ab8  r4 : 00000000
[  299.817526] r3 : 00000000  r2 : 00000000  r1 : 8004570a  r0 : dbc08318
[  299.824423] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  299.831958] Control: 10c5387d  Table: 9e35c019  DAC: 00000051
[  299.838026] Process wdctl (pid: 1242, stack limit = 0xdcf26220)
[  299.844280] Stack: (0xdcf27f18 to 0xdcf28000)
[  299.848890] 7f00:
    becb1ab8 dbf241b8
[  299.857541] 7f20: dc823840 8004570a becb1ab8 c03988a4 dcf27f48
dcf17100 00000000 de352850
[  299.866191] 7f40: dde86ee0 0000570a dc82380b dcf27f3c dbf241b8
00000020 c0df9250 c0df6c48
[  299.874840] 7f60: dc823840 8004570a 00000000 dc823840 dc823840
8004570a becb1ab8 00000003
[  299.883489] 7f80: 00000000 c03989d4 becb1b74 7f626bad 00000003
00000036 c020fcc4 dcf26000
[  299.892137] 7fa0: 00000000 c020fb00 becb1b74 7f626bad 00000003
8004570a becb1ab8 00000001
[  299.900786] 7fc0: becb1b74 7f626bad 00000003 00000036 00000001
00000000 7f637eb0 7f626bbe
[  299.909434] 7fe0: 7f637f10 becb1a3c 7f623a54 b6ee5e0c a00f0010
00000003 00000000 00000000
[  299.918136] [<bf09f138>] (omap_wdt_get_timeleft [omap_wdt]) from
[<c0739c54>] (watchdog_ioctl+0x3cc/0x42c)
[  299.928365] [<c0739c54>] (watchdog_ioctl) from [<c03988a4>]
(do_vfs_ioctl+0x5bc/0x698)
[  299.936747] [<c03988a4>] (do_vfs_ioctl) from [<c03989d4>]
(SyS_ioctl+0x54/0x7c)
[  299.944499] [<c03989d4>] (SyS_ioctl) from [<c020fb00>]
(ret_fast_syscall+0x0/0x3c)
[  299.952511] Code: e12fff1e e52de004 e8bd4000 e5903060 (e5933088)
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
