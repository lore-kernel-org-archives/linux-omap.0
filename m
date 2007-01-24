From: "zhangshigeng" <zsg@dislab.nju.edu.cn>
Subject: Errores arise when compiling a 2.6.8 kernel
Date: Wed, 24 Jan 2007 22:47:40 +0800
Message-ID: <200701241357.l0ODvrPW027928@dislab.nju.edu.cn>
References: <20070123180003.0F0C78062B@linux.omap.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070123180003.0F0C78062B@linux.omap.com>
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

Hi, everybody. We are now following instructions in a document released =
with
OMAP5912 OSK to port a linux 2.6.8 kernel to the omap5912 board. The =
kernel
source we are using is downloaded from
http://linux.omap.com(2.6.8-rc3080804.tar.bz2).
We used scratchbox to set a arm-linux cross compiler. We passed the =
command
       make omap_osk_5912_defconfig=20
 But when we execute=20
	  make=20
 the following errors arised:
	/home/autom/2.6.8-rc3/scripts/basic/split-include: find: No such
file or directory
And the corresponding makefile is:
# 	Split autoconf.h into include/linux/config/*

705 include/config/MARKER: include/linux/autoconf.h
706
707
708 	@echo '  SPLIT   include/linux/autoconf.h -> include/config/*'
709
/scratchbox/users/autom/home/autom/2.6.8-rc3/scripts/basic/split-include
include/linux/autoconf.h include/config
710 	@touch $@
And in the "make omap_osk_5912_defconfig" step, the following warning
appears:
arch/arm/configs/omap_osk_5912_defconfig:52: trying to assign =
nonexistent
symbol ARCH_ADIFCC
arch/arm/configs/omap_osk_5912_defconfig:543: trying to assign =
nonexistent
symbol INTERMEZZO_FS

can anyone tell me how to fix this? Thanks.
					=09
ZHANG Shi-Geng
-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
linux-omap-open-source-request@linux.omap.com
Sent: 2007=C4=EA1=D4=C224=C8=D5 2:00
To: linux-omap-open-source@linux.omap.com
Subject: Linux-omap-open-source Digest, Vol 33, Issue 40

Send Linux-omap-open-source mailing list submissions to
	linux-omap-open-source@linux.omap.com

To subscribe or unsubscribe via the World Wide Web, visit
	http://linux.omap.com/mailman/listinfo/linux-omap-open-source
or, via email, send a message with subject or body 'help' to
	linux-omap-open-source-request@linux.omap.com

You can reach the person managing the list at
	linux-omap-open-source-owner@linux.omap.com

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Linux-omap-open-source digest..."


Today's Topics:

   1. RE: Linux-omap-open-source Digest, Vol 33, Issue 38
      (Woodruff, Richard)


----------------------------------------------------------------------

Message: 1
Date: Tue, 23 Jan 2007 07:51:41 -0600
From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Linux-omap-open-source Digest, Vol 33, Issue 38
To: "Leo Qin" <Leo.Qin@BENQ.COM>,
	<linux-omap-open-source@linux.omap.com>
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742928875B@dlee13.ent.ti.com>
Content-Type: text/plain;	charset=3D"US-ASCII"

> Hi,
> has Linux been ported on OMAP1030V (Neptune ) ?
> Anyone has tried it ?

It has been booted for sure.  Not sure if web trees have it, you might
check the tar balls.  Beyond that you should inquire with your TI-Rep if
it is something you really need.

Regards,
Richard W.



------------------------------

_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source


End of Linux-omap-open-source Digest, Vol 33, Issue 40
******************************************************
