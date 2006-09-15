From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: building kernel 2.6.17 for omap1710
Date: Fri, 15 Sep 2006 07:55:52 -0500
Message-ID: <A794DE2F81AEF94099397C9D7D5B651E91F772@dlee08.ent.ti.com>
References: <7b1b9c8b0609150219n43c96443t15263b0427dffa44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-reply-to: <7b1b9c8b0609150219n43c96443t15263b0427dffa44@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Prashant <prashantkhoje@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

You need to apply the OMAP patch from www.muru.com before building a
kernel.

Steve K.

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Prashant
Sent: Friday, September 15, 2006 4:20 AM
To: linux-omap-open-source@linux.omap.com
Subject: building kernel 2.6.17 for omap1710

I have downloaded 2.6.17 kernel as follows:
wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.17.tar.bz2

While building the kernel

[pkhoje@IN-00210 linux-2.6.17]$ make ARCH=3Darm =
CROSS_COMPILE=3Darm-linux-
omap_h3_1710_defconfig

gives following error:

***
*** Can't find default configuration
"arch/arm/configs/omap_h3_1710_defconfig"!
***
make[1]: *** [omap_h3_1710_defconfig] Error 1
make: *** [omap_h3_1710_defconfig] Error 2

I didnt find arch/arm/configs/omap_h3_1710_defconfig in the source tree.

What should I do?

Regards,
Prashant Khoje
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
