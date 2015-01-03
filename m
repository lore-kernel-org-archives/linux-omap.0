From: Paul Walmsley <paul@pwsan.com>
Subject: Re: OMAP baseline test results for v3.19-rc1
Date: Sat, 3 Jan 2015 20:28:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501031955170.27058@utopia.booyaka.com>
References: <alpine.DEB.2.02.1501030712210.27058@utopia.booyaka.com> <8629693.mvYldWiixb@wuerfel>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40565 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbbACU23 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Jan 2015 15:28:29 -0500
In-Reply-To: <8629693.mvYldWiixb@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel-build-reports@lists.linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, 3 Jan 2015, Arnd Bergmann wrote:

> On Saturday 03 January 2015 07:21:49 Paul Walmsley wrote:
> > Another ~300KB kernel object size increase for omap2plus_defconfig 
> > kernels.
> 
> 300kb seems like a lot for a single release. 

+300KB is high, but not exceptionally so.

The data, since I started keeping track of it, is below.  The last numeric 
column represents the total kernel object size delta in bytes.

> Have you looked into where this is coming from?

I have not.


- Paul


http://www.pwsan.com/omap/testlogs/

test_v3.7-rc1/20121017205513/build/size.txt:+128332   -67728    +2144   +62748  omap2plus_defconfig
test_v3.8-rc1/20121228031713/build/size.txt:+168843   +25288     +900  +195031  omap2plus_defconfig
test_v3.9-rc1/20130312100243/build/size.txt:+195310   +37968    +1364  +234642  omap2plus_defconfig
test_v3.10-rc1/20130518212204/build/size.txt: -59854   -98552   +37136  -121270  omap2plus_defconfig
test_v3.11-rc1/20130721020309/build/size.txt:+159173    -2456    +1680  +158397  omap2plus_defconfig
test_v3.12-rc1/20130922202452/build_z/size.txt:+237402   +47344     +760  +285506  omap2plus_defconfig
test_v3.13-rc1/20131208173326/build_z/size.txt:-276029    -5584    +5008  -276605  omap2plus_defconfig
test_v3.14-rc1/20140210035354/build_z/size.txt: +94801   -17448    -9016   +68337  omap2plus_defconfig
test_v3.15-rc1/20140421113253/build_z/size.txt: +30722   +11392    +4312   +46426  omap2plus_defconfig
test_v3.16-rc1/20140629224344/build_z/size.txt:+133191   +20776  +2750728  +2904695  omap2plus_defconfig
test_v3.17-rc1/20140821122707/build_z/size.txt: +54469   -34424    +1728   +21773  omap2plus_defconfig
test_v3.18-rc1/20141020095901/build_z/size.txt:+677950   +32008   +54408  +764366  omap2plus_defconfig
test_v3.19-rc1/20150102151849/build_z/size.txt:+297698    +9648    -4528  +302818  omap2plus_defconfig

