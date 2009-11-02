From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: manual merge of the sound tree with the  tree
Date: Mon, 2 Nov 2009 12:22:22 +1100
Message-ID: <20091102122222.542dac88.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Mike Rapoport <mike@compulab.co.il>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Takashi,

Today's linux-next merge of the sound tree got a conflict in
arch/arm/mach-omap2/board-omap3evm.c between commit
fa48a99192e3ee862f6d26c5248347c772b33b84 ("omap3: evm: initialize vmmc
and vmmc_aux regulators") from the omap tree and commit
f8d9aad96d0d7b57d0bf2e4de21fdda3a42f4449 ("OMAP: Platform support for
twl4030_codec MFD") from the sound tree.

Just overlapping additions.  I fixed it up (see below) and can carry the
fix as necessary.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --cc arch/arm/mach-omap2/board-omap3evm.c
index 660ef8c,d9a6103..0000000
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@@ -247,8 -211,7 +255,9 @@@ static struct twl4030_platform_data oma
  	.madc		= &omap3evm_madc_data,
  	.usb		= &omap3evm_usb_data,
  	.gpio		= &omap3evm_gpio_data,
 +	.vmmc1		= &omap3evm_vmmc1,
 +	.vsim		= &omap3evm_vsim,
+ 	.codec		= &omap3evm_codec_data,
  };
  
  static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] = {
