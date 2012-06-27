From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: Current state of AM33xx patches
Date: Wed, 27 Jun 2012 12:07:58 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA5B7DE@DBDE01.ent.ti.com>
References: <4FD5BA4C.9070706@gmail.com>	<4FD5FD9E.5040203@ti.com>
 <CADjby3UTVBKWRZUBRNTX9Bh4TqQJsoWQrrBxW6HuqSNZCUcvCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42655 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754433Ab2F0MIJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 08:08:09 -0400
In-Reply-To: <CADjby3UTVBKWRZUBRNTX9Bh4TqQJsoWQrrBxW6HuqSNZCUcvCw@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Domenico Andreoli <cavokz@gmail.com>
Cc: Daniel Mack <zonque@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Jun 23, 2012 at 18:33:13, Domenico Andreoli wrote:
> Hello,
> 
> On Mon, Jun 11, 2012 at 4:15 PM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> >
> > I do maintain wiki page which you should refer for any updates:
> > http://processors.wiki.ti.com/index.php/Sitara_Linux_Upstream_Status
> >
> > In order to get latest and greatest kernel to boot, you can use my repo:
> > https://github.com/hvaibhav/am335x-linux
> 
> do you have any usable defconfig? I've some trouble with the build of
> this branch and I'm not sure about the configuration.
> 
> > Also, note that, currently there will be very minimal feature-set
> > supported in the kernel, so not sure how much can be leveraged for
> > production use-cases.
> 
> I need something that boots to userspace, nothing more (but I'm happy
> to test) :)
> 

Sorry for delayed response, I went out of station, supposed to come back on 
Monday itself but due to some known reason couldn't make it. I have just 
resumed my work today. Sorry for inconvenience...

Coming back to your question,

Omap2plus_defconfig should work for you, you should get linux prompt with 
ramdisk image (which I use). Just to be more clear, and for your reference I am pasting steps which I use for testing, 

Build Steps:
============
 - make ARCH=arm CROSS_COMPILE=<toolchain> distclean
 - make ARCH=arm CROSS_COMPILE=<toolchain> omap2plus_defconfig
 - Enable option CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT
 - make ARCH=arm CROSS_COMPILE=<toolchain> uImage-dtb.am335x-evm
   (Since I am not using DT aware u-boot)

Use the ramdisk image to boot kernel, since we do not have support for any 
storage devices in the mainline.

U-Boot commands to boot:
========================
setenv bootcmd 'mmc rescan 0; fatload mmc 0 81000000 uImage; fatload mmc 0 82000000 ramdisk-pm.gz; bootm 81000000'
setenv bootargs 'console=ttyO0,115200n8 mem=128M root=/dev/ram rw initrd=0x82000000,16MB ramdisk_size=65536 earlyprintk=serial'
boot


Hope this will help you to boot the kernel on BeagleBone.

Thanks,
Vaibhav

