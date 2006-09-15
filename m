From: "Amit Verma" <vermanamit@gmail.com>
Subject: Re: building kernel 2.6.17 for omap1710
Date: Fri, 15 Sep 2006 16:29:15 +0530
Message-ID: <5a2ffe1f0609150359x640b09a4p245a9e46f11f23f5@mail.gmail.com>
References: <7b1b9c8b0609150219n43c96443t15263b0427dffa44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <7b1b9c8b0609150219n43c96443t15263b0427dffa44@mail.gmail.com>
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
To: Prashant <prashantkhoje@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi

Looks like the kernel which u have got doen't configured for omap1701
support. check it.

basically it is searching for config file which attaches omap board
(your case 1710) support to the kernel.

regards
-Amit



On 9/15/06, Prashant <prashantkhoje@gmail.com> wrote:
> I have downloaded 2.6.17 kernel as follows:
> wget http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.17.tar.bz2
>
> While building the kernel
>
> [pkhoje@IN-00210 linux-2.6.17]$ make ARCH=arm CROSS_COMPILE=arm-linux-
> omap_h3_1710_defconfig
>
> gives following error:
>
> ***
> *** Can't find default configuration "arch/arm/configs/omap_h3_1710_defconfig"!
> ***
> make[1]: *** [omap_h3_1710_defconfig] Error 1
> make: *** [omap_h3_1710_defconfig] Error 2
>
> I didnt find arch/arm/configs/omap_h3_1710_defconfig in the source tree.
>
> What should I do?
>
> Regards,
> Prashant Khoje
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
