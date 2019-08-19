From: Keerthy <j-keerthy@ti.com>
Subject: Suspend/Resume Broken on AM43/AM33 Platforms
Date: Mon, 19 Aug 2019 09:54:58 +0530
Message-ID: <49fc7c64-88c0-74d0-2cb3-07986490941d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: swboyd@chromium.org, Tony Lindgren <tony@atomide.com>, herbert@gondor.apana.org.au
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Stephen,

commit 03a3bb7ae63150230c5de645dc95e673ebf17e1a
Author: Stephen Boyd <swboyd@chromium.org>
Date:   Mon Aug 5 16:32:41 2019 -0700

     hwrng: core - Freeze khwrng thread during suspend

Commit seems to be breaking suspend/resume on TI AM43/AM33 platforms.


rtcwake: wakeup from "mem" using /dev/rtc0 at Sun Nov 18 02:12:12 2018
[   54.033833] PM: suspend entry (deep)
[   54.037741] Filesystems sync: 0.000 seconds
[   54.062730] Freezing user space processes ... (elapsed 0.001 seconds) 
done.
[   54.071313] OOM killer disabled.
[   54.074572] Freezing remaining freezable tasks ...
[   74.083121] Freezing of tasks failed after 20.003 seconds (1 tasks 
refusing to freeze, wq_busy=0):
[   74.092257] hwrng           R  running task        0   289      2 
0x00000020
[   74.099511] [<c08c64c4>] (__schedule) from [<c08c6a10>] 
(schedule+0x3c/0xc0)
[   74.106720] [<c08c6a10>] (schedule) from [<c05dbd8c>] 
(add_hwgenerator_randomness+0xb0/0x100)
[   74.115358] [<c05dbd8c>] (add_hwgenerator_randomness) from 
[<bf1803c8>] (hwrng_fillfn+0xc0/0x14c [rng_core])
[   74.125356] [<bf1803c8>] (hwrng_fillfn [rng_core]) from [<c015abec>] 
(kthread+0x134/0x148)
[   74.133764] [<c015abec>] (kthread) from [<c01010e8>] 
(ret_from_fork+0x14/0x2c)
[   74.141093] Exception stack(0xec611fb0 to 0xec611ff8)
[   74.146239] 1fa0:                                     00000000 
00000000 00000000 00000000
[   74.154478] 1fc0: 00000000 00000000 00000000 00000000 00000000 
00000000 00000000 00000000
[   74.162764] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   74.169499] Restarting kernel threads ... done.
[   74.175628] OOM killer enabled.
[   74.178796] Restarting tasks ... done.
[   74.226769] PM: suspend exit
rtcwake: write error
1

One task refusing to freeze is the final error i am seeing.

- Keerthy
