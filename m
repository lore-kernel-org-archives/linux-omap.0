From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: mcount unresolved symbol - build module with
	mv2.6.10_mobilinux410-omap2430_sdp
Date: Mon, 4 Dec 2006 09:44:22 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4702ADA2@dlee13.ent.ti.com>
References: <13ECC251745F8F4BA0076A980813C7C29F1035@msl-ex02.corp.m-sys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
in-reply-to: <13ECC251745F8F4BA0076A980813C7C29F1035@msl-ex02.corp.m-sys.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Eyal Shani <Eyal.Shani@SanDisk.Com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Eyal,

The steps that I follow for building on 2.6 Mobilinux are,

1. Remove "export-objs		:=3D yxyxyx.o" from Makefile

2. Add these definitions at the end of driver file
MODULE_AUTHOR("");
MODULE_DESCRIPTION("");
MODULE_LICENSE("GPL");

3. Include the following headers in driver file.=20

#include <linux/module.h>=20
#include <linux/config.h>
#include <linux/init.h>
#include <linux/kernel.h>=20
#include <linux/sched.h>
#include <linux/errno.h>
#include <linux/delay.h>
#include <linux/types.h>
#include <linux/interrupt.h>
#include <linux/proc_fs.h>
#include <linux/version.h>

#include <asm/system.h>
#include <asm/irq.h>
#include <asm/hardware.h>
#include <asm/io.h>
#include <asm/arch/clock.h>
#include <asm/arch/hardware.h>

4. Few global definitions might be different from 2.4 make sure you have
updated the same.


One of this should fix your problem.

Regards,
Khasim

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Eyal
Shani
Sent: Monday, December 04, 2006 9:29 AM
To: linux-omap-open-source@linux.omap.com
Cc: Eyal Shani
Subject: mcount unresolved symbol - build module with
mv2.6.10_mobilinux410-omap2430_sdp

All,

=20

I am trying to build my hw driver as a module, with the mv
2.6.10_mobilinux410-omap2430_sdp kernel.

The driver is build, but while insmod I get the following output on the
target:

=20

root@172.17.54.81:~# insmod my_module.ko

my_module: no version for "struct_module" found: kernel tainted.

 my_module: module license 'Proprietary' taints kernel.

my_module: Unknown symbol mcount

insmod: error inserting ' my_module.ko': -1 Unknown symbol in module

=20

=20

I am used to building modules on the MV CEE3.1 set of kernels, for
kernel 2.4, but I have not seen this mcount before.

=20

Any idea anyone?!

=20

Thanks in advance,

Eyal Shani

=20


______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email=20
______________________________________________________________________
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
