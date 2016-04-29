From: Guenter Roeck <linux@roeck-us.net>
Subject: (v4.4/v4.5)-stable-queue build and qemu failures (arm:allmodconfig,
 arm:pxa_defconfig, arm:omap2plus_defconfig)
Date: Fri, 29 Apr 2016 13:19:14 -0700
Message-ID: <20160429201914.GA27596@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

v4.4 (arm:allmodconfig):

drivers/mtd/nand/pxa3xx_nand.c: In function 'alloc_nand_resource':
drivers/mtd/nand/pxa3xx_nand.c:1753:7: error: 'np' undeclared

v4.5 (arm:allmodconfig, arm:pxa_defconfig):

drivers/dma/pxa_dma.c: In function 'pxad_probe':
drivers/dma/pxa_dma.c:1421:24: error: 'struct mmp_dma_platdata' has no member named 'nb_requestors'

There is also a qemu runtime failure with omap2plus_defconfig in v4.4.

[    2.412322] omap_i2c 48070000.i2c: bus 0 rev3.3 at 2600 kHz
[    2.417541] omap_i2c 48060000.i2c: bus 2 rev3.3 at 100 kHz
[    2.429443] 
[    2.429534] =====================================
[    2.429718] [ BUG: bad unlock balance detected! ]
[    2.429962] 4.4.8-00025-gcd58757 #1 Not tainted
[    2.430145] -------------------------------------
[    2.430328] kworker/u2:0/6 is trying to release lock (&rdev->mutex) at:
[    2.430694] [<c03b40e4>] regulator_set_voltage+0x40/0x54
[    2.430877] but there are no more locks to release!

See logs at http://kerneltests.org/builders for details.
Please let me know if I need to bisect.

Thanks,
Guenter
