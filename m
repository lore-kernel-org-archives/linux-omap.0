From: Prashant <prashantkhoje@gmail.com>
Subject: building kernel 2.6.17 for omap1710
Date: Fri, 15 Sep 2006 14:49:59 +0530
Message-ID: <7b1b9c8b0609150219n43c96443t15263b0427dffa44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I have downloaded 2.6.17 kernel as follows:
wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.17.tar.bz2

While building the kernel

[pkhoje@IN-00210 linux-2.6.17]$ make ARCH=arm CROSS_COMPILE=arm-linux-
omap_h3_1710_defconfig

gives following error:

***
*** Can't find default configuration "arch/arm/configs/omap_h3_1710_defconfig"!
***
make[1]: *** [omap_h3_1710_defconfig] Error 1
make: *** [omap_h3_1710_defconfig] Error 2

I didnt find arch/arm/configs/omap_h3_1710_defconfig in the source tree.

What should I do?

Regards,
Prashant Khoje
