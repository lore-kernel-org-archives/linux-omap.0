From: Mohamed Thalib H <mohamed@e-consystems.com>
Subject: ECC error writing to the nand.
Date: Wed, 09 Feb 2011 12:19:27 +0530
Message-ID: <4D5238F7.7020200@e-consystems.com>
Reply-To: mohamed@e-consystems.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp7.myhsphere.biz ([204.10.105.69]:59656 "EHLO
	mail9.myhsphere.biz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751150Ab1BIGte (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 01:49:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP-KML <linux-omap@vger.kernel.org>

Hi,

I am using the kernel from OMAP git.  I got ECC error when writing to a 
nand partition. I have tested this in gumsitx overo board.

---Log---

root@overo:/# flash_eraseall -j /dev/mtd4
Erasing 128 Kibyte @ f980000 -- 100 % complete.Cleanmarker written at 
f960000.
root@overo:/# mkdir -p /media/mtdblock4
root@overo:/# mount -t jffs2 /dev/mtdblock4 /media/mtdblock4
[  228.339630] JFFS2 notice: (1340) jffs2_build_xattr_subsystem: 
complete building xatt
r subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of xref (0 dead, 
0 orphan) found
.
root@overo:/# cd /media/mtdblock4
root@overo:/media/mtdblock4# tar -xjf /omap3-console-image-overo.tar.bz2
[  248.941436] uncorrectable error :
[  248.944854] mtd->read(0x44 bytes from 0xf9176f4) returned ECC error
[  249.023651] uncorrectable error :
[  249.027252] mtd->read(0x16 bytes from 0xf8eaef8) returned ECC error
[  249.042236] uncorrectable error :
[  249.045654] mtd->read(0x11 bytes from 0xf8ec4f0) returned ECC error
[  249.783905] uncorrectable error :
[  249.787353] mtd->read(0x44 bytes from 0xf817ad8) returned ECC error
[  251.090057] uncorrectable error :
[  251.093475] mtd->read(0x44 bytes from 0xf6ca0e4) returned ECC error
[  251.104522] uncorrectable error :
[  251.107971] mtd->read(0x44 bytes from 0xf6ca2f4) returned ECC error
[  251.123260] uncorrectable error :
[  251.126861] mtd->read(0x44 bytes from 0xf6ca6f0) returned ECC error
[  251.148162] uncorrectable error :
[  251.151763] mtd->read(0x44 bytes from 0xf6caad4) returned ECC error
[  251.590454] uncorrectable error :
[  251.593872] mtd->read(0x10 bytes from 0xf6522fc) returned ECC error
[  251.630554] uncorrectable error :
[  251.634185] mtd->read(0x44 bytes from 0xf6550e0) returned ECC error
[  252.018066] uncorrectable error :
[  252.021484] uncorrectable error :
[  252.025177] uncorrectable error :
[  252.028747] uncorrectable error :
[  252.032379] uncorrectable error :
[  252.035949] uncorrectable error :
[  252.039581] uncorrectable error :
[  252.043182] mtd->read(0x9fc bytes from 0xf94044c) returned ECC error
[  252.199523] uncorrectable error :
[  252.202972] mtd->read(0x44 bytes from 0xf5b62dc) returned ECC error
[  252.239471] uncorrectable error :
[  252.243041] mtd->read(0x44 bytes from 0xf5bc0fc) returned ECC error
[  252.309631] uncorrectable error :
[  252.313201] mtd->read(0x44 bytes from 0xf5878c0) returned ECC error
[  252.334167] uncorrectable error :
[  252.337799] mtd->read(0x44 bytes from 0xf5890c8) returned ECC error
[  252.348480] uncorrectable error :
[  252.352081] mtd->read(0x44 bytes from 0xf5892c8) returned ECC error
[  258.017608] uncorrectable error :
[  258.021026] uncorrectable error :
[  258.025268] uncorrectable error :
[  258.028839] uncorrectable error :
[  258.032470] uncorrectable error :
[  258.036071] mtd->read(0xc4c bytes from 0xf940e48) returned ECC error
[  258.308532] uncorrectable error :
[  258.311950] mtd->read(0x44 bytes from 0xf0a34cc) returned ECC error
[  258.445922] uncorrectable error :
[  258.449371] mtd->read(0x44 bytes from 0xf0ad6c8) returned ECC error
[  258.571868] uncorrectable error :
[  258.575286] mtd->read(0x44 bytes from 0xf0b7cc8) returned ECC error
[  258.606262] uncorrectable error :
[  258.609832] mtd->read(0x44 bytes from 0xf0b8ac8) returned ECC error
[  258.763458] uncorrectable error :
[  258.767059] mtd->read(0x44 bytes from 0xf08a6f4) returned ECC error
[  258.779113] uncorrectable error :
[  258.782714] mtd->read(0x14 bytes from 0xf08a8f4) returned ECC error
[  258.977111] uncorrectable error :
[  258.980529] mtd->read(0x44 bytes from 0xf09c6f0) returned ECC error
[  259.003936] uncorrectable error :
[  259.007354] mtd->read(0x44 bytes from 0xf0604d8) returned ECC error
[  259.019409] uncorrectable error :
[  259.022827] mtd->read(0x11 bytes from 0xf0606fc) returned ECC error
[  259.151885] uncorrectable error :
[  259.155303] mtd->read(0x44 bytes from 0xf0712dc) returned ECC error
[  259.181518] uncorrectable error :
[  259.184936] mtd->read(0x44 bytes from 0xf071cf4) returned ECC error
[  259.436401] uncorrectable error :
[  259.440032] mtd->read(0x44 bytes from 0xf0462dc) returned ECC error
[  259.602844] uncorrectable error :
[  259.606262] mtd->read(0x44 bytes from 0xf0300c0) returned ECC error
[  259.669097] uncorrectable error :
[  259.672698] mtd->read(0x44 bytes from 0xf03bae8) returned ECC error
[  259.730194] uncorrectable error :
[  259.733642] mtd->read(0x44 bytes from 0xf007cec) returned ECC error
[  259.818786] uncorrectable error :
[  259.822387] mtd->read(0x44 bytes from 0xf01e0f8) returned ECC error
[  259.933715] uncorrectable error :
[  259.937133] mtd->read(0x12 bytes from 0xeffd8f8) returned ECC error
[  260.040313] uncorrectable error :
[  260.043731] mtd->read(0x44 bytes from 0xefd62f4) returned ECC error
[  260.690002] uncorrectable error :
[  260.693420] mtd->read(0x44 bytes from 0xef0f6dc) returned ECC error
[  260.778717] uncorrectable error :
[  260.782318] mtd->read(0x44 bytes from 0xeee0ee8) returned ECC error
[  260.888824] uncorrectable error :
[  260.892425] mtd->read(0x44 bytes from 0xeefc4f0) returned ECC error
[  261.040435] uncorrectable error :
[  261.043884] mtd->read(0x44 bytes from 0xeea1adc) returned ECC error
[  261.055603] uncorrectable error :
[  261.059020] mtd->read(0x18 bytes from 0xeea1cf0) returned ECC error
[  261.162292] uncorrectable error :
[  261.165893] mtd->read(0x44 bytes from 0xee822f0) returned ECC error
[  261.184204] uncorrectable error :
[  261.187622] mtd->read(0x44 bytes from 0xee83cd8) returned ECC error
[  263.250396] omap_device: omap_i2c.1: new worst case deactivate 
latency 0: 152587
[  264.016815] uncorrectable error :
[  264.020233] uncorrectable error :
[  264.023925] uncorrectable error :
[  264.027496] uncorrectable error :
[  264.031066] uncorrectable error :
[  264.034698] uncorrectable error :
[  264.038543] uncorrectable error :
[  264.042175] uncorrectable error :
[  264.045745] uncorrectable error :
[  264.049377] uncorrectable error :
[  264.052947] uncorrectable error :
[  264.056579] uncorrectable error :
[  264.060150] mtd->read(0xb4c bytes from 0xf941a94) returned ECC error
[  265.018157] uncorrectable error :
[  265.021606] mtd->read(0x44 bytes from 0xec266c8) returned ECC error
[  265.467773] uncorrectable error :
[  265.471374] mtd->read(0x44 bytes from 0xebadadc) returned ECC error
[  267.038482] uncorrectable error :
[  267.042114] mtd->read(0x44 bytes from 0xe9d74d0) returned ECC error
[  267.395324] uncorrectable error :
[  267.398925] mtd->read(0xc bytes from 0xe940cfc) returned ECC error
[  267.501403] uncorrectable error :
[  267.504852] mtd->read(0x44 bytes from 0xe95cccc) returned ECC error
[  268.143402] uncorrectable error :
[  268.146820] mtd->read(0x44 bytes from 0xe89b6f4) returned ECC error
[  268.182830] uncorrectable error :
[  268.186248] mtd->read(0x44 bytes from 0xe8622d0) returned ECC error
[  268.283233] uncorrectable error :
[  268.286682] mtd->read(0x44 bytes from 0xe873ae8) returned ECC error
[  268.460296] uncorrectable error :
[  268.463897] mtd->read(0x11 bytes from 0xe8574fc) returned ECC error
[  268.653228] uncorrectable error :
[  268.656860] mtd->read(0x44 bytes from 0xe8032fc) returned ECC error
[  268.689300] uncorrectable error :
[  268.692718] mtd->read(0x44 bytes from 0xe8094e0) returned ECC error
[  268.908538] uncorrectable error :
[  268.911987] mtd->read(0x44 bytes from 0xe7f78c0) returned ECC error
[  268.937896] uncorrectable error :
[  268.941345] mtd->read(0x44 bytes from 0xe7fb4c8) returned ECC error
[  268.982849] uncorrectable error :
[  268.986450] mtd->read(0x44 bytes from 0xe7c26e0) returned ECC error
[  269.153076] uncorrectable error :
[  269.156677] mtd->read(0x44 bytes from 0xe7ab0c8) returned ECC error
[  269.169738] uncorrectable error :
[  269.173339] mtd->read(0x44 bytes from 0xe7abcc4) returned ECC error
[  269.209594] uncorrectable error :
[  269.213195] mtd->read(0x44 bytes from 0xe7b16f4) returned ECC error
[  269.300750] uncorrectable error :
[  269.304199] mtd->read(0x44 bytes from 0xe7832f4) returned ECC error
[  269.619873] uncorrectable error :
[  269.623321] mtd->read(0x44 bytes from 0xe756ac8) returned ECC error
[  269.641326] uncorrectable error :
[  269.644775] mtd->read(0x44 bytes from 0xe7588d0) returned ECC error
[  269.715515] uncorrectable error :
[  269.718963] mtd->read(0x44 bytes from 0xe7284f4) returned ECC error
[  269.756500] uncorrectable error :
[  269.760101] mtd->read(0x44 bytes from 0xe72f2f8) returned ECC error
[  269.809844] uncorrectable error :
[  269.813446] mtd->read(0x44 bytes from 0xe738efc) returned ECC error
[  270.006042] uncorrectable error :
[  270.009643] mtd->read(0x44 bytes from 0xe6edeec) returned ECC error
[  270.017761] uncorrectable error :
[  270.021179] uncorrectable error :
[  270.024871] uncorrectable error :
[  270.029022] mtd->read(0xd44 bytes from 0xf9425e0) returned ECC error
[  270.517578] uncorrectable error :
[  270.520996] mtd->read(0x11 bytes from 0xe6792f8) returned ECC error
[  272.955505] uncorrectable error :
[  272.958953] mtd->read(0x44 bytes from 0xe5776d8) returned ECC error
[  274.067779] uncorrectable error :
[  274.071411] mtd->read(0x44 bytes from 0xe4e6acc) returned ECC error
[  274.548919] uncorrectable error :
[  274.552337] mtd->read(0x44 bytes from 0xe4d34fc) returned ECC error
[  274.952728] uncorrectable error :
[  274.956359] mtd->read(0x44 bytes from 0xe4b90fc) returned ECC error
[  276.938385] uncorrectable error :
[  276.941802] mtd->read(0x44 bytes from 0xe3c68c8) returned ECC error
[  278.531005] uncorrectable error :
[  278.534606] mtd->read(0x11 bytes from 0xe2c0af4) returned ECC error
[  279.434631] uncorrectable error :
[  279.438262] mtd->read(0x44 bytes from 0xe1cf6ec) returned ECC error
[  279.476562] uncorrectable error :
[  279.480194] mtd->read(0x44 bytes from 0xe1d58e4) returned ECC error
[  279.534423] uncorrectable error :
[  279.537872] mtd->read(0x44 bytes from 0xe1de2d0) returned ECC error
[  279.942596] uncorrectable error :
[  279.946197] mtd->read(0x11 bytes from 0xe1546f0) returned ECC error
root@overo:/media/mtdblock4# sync
root@overo:/media/mtdblock4# ls
bin      dev      home     linuxrc  mnt      sbin     tmp      var
boot     etc      lib      media    proc     sys      usr
root@overo:/media/mtdblock4#

-- 
Regards,
Mohamed Thalib H

