From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v9 00/25] gpio/omap: driver cleanup and fixes
Date: Fri, 10 Feb 2012 11:24:16 -0800
Message-ID: <20120210192416.GW1426@atomide.com>
References: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1328203851-20435-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, grant.likely@secretlab.ca, khilman@ti.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tarun,

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [120202 09:00]:
> 
>   Used following patches to avoid exception during system suspend:-
>   [PATCH RFC 1/2] mtd : Prevent the NULL pointer access
>   [PATCH RFC 2/2] mtd : Make the mtd_suspend return 0 if the suspend is not implemented

OK so MTD fixes those are supposedly going in during the -rc cycle..
 
> # echo mem > /sys/power/state
> [   47.128021] PM: Syncing filesystems ... done.
> [   47.144104] Freezing user space processes ... (elapsed 0.01 seconds) done.
> [   47.168243] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) don                                                                                                 e.
> [   47.205139] Unable to handle kernel NULL pointer dereference at virtual addre                                                                                                 ss 000000a0
> [   47.213317] pgd = deaac000
> [   47.216033] [000000a0] *pgd=9e932831, *pte=00000000, *ppte=00000000
> [   47.222381] Internal error: Oops: 17 [#1] SMP
> [   47.226745] Modules linked in:
> [   47.229827] CPU: 0    Not tainted  (3.3.0-rc2-00031-g12c5c5c #235)
> [   47.236022] PC is at mtd_cls_suspend+0x8/0x20
> [   47.240386] LR is at mtd_cls_suspend+0x8/0x20
> [   47.244750] pc : [<c02e78f8>]    lr : [<c02e78f8>]    psr: a0000013
> [   47.244750] sp : dea1fe60  ip : 22222222  fp : c0ee7d40
> [   47.256256] r10: c0ee7cf0  r9 : 00000000  r8 : c02e78f0
> [   47.261474] r7 : 00000000  r6 : 00000000  r5 : 00000002  r4 : dea45800
> [   47.268005] r3 : deb4cac0  r2 : 00000000  r1 : 00000002  r0 : 00000000
> [   47.274536] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> [   47.281677] Control: 10c5387d  Table: 9eaac019  DAC: 00000015
> [   47.287445] Process sh (pid: 1177, stack limit = 0xdea1e2f8)
> [   47.293090] Stack: (0xdea1fe60 to 0xdea20000)
> [...]

..but are there also some patches in your series that should also be
applied separately as fixes for the -rc cycle?

Regards,

Tony
