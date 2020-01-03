From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: v5.5-rc4: OMAP build failure
Date: Fri, 3 Jan 2020 10:18:07 +0200
Message-ID: <20200103081807.GE15023@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Build fails when CONFIG_RESET_CONTROLLER is not set:

  LD      .tmp_vmlinux1
arm-linux-gnueabi-ld: drivers/soc/ti/omap_prm.o: in function `omap_prm_reset_init':
/home/aakoskin/git/devel/linux/drivers/soc/ti/omap_prm.c:345: undefined reference to `devm_reset_controller_register'
make[5]: *** [/home/aakoskin/git/devel/linux/Makefile:1078: vmlinux] Error 1

Some missing dependency?

A.
