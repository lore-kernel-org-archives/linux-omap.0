From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: RE: DSP gateway build problems with 2.6.13.4
Date: Mon, 19 Dec 2005 14:49:45 -0000
Message-ID: <003801c604ab$73c99fb0$642aa8c0@BUFFY>
References: <200512191111.jBJBBLj5007198@dmhp30.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200512191111.jBJBBLj5007198@dmhp30.itg.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Ishigami' <ishigami@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

I'm definitely getting closer with this now.. ;-)

I changed the CONFIG_OMAP_DSP option in my .config from "m" to "y" so =
now I
have the driver built into the kernel.

I created a /sys directory in my ramdisk root and added the appropriate =
line
to /etc/inittab so busybox creates all the correct entries under there =
for
me.

I built the DSPtools 3.3 for my host system (linux 2.6.13.4) using gcc =
3.4.1
and built the ex_task demo application that comes with it. I placed the
binary fro this into my target /root directory.

I built the dspctl binary (cross compiled to arm with gcc 3.4.1) and =
placed
that in my target /sbin directory.

I boot that target, load he ramdisk, start the shell and enter:

dspctl start ex_task.out

I get lots of info scroll across my terminal and then the last few lines
give me:

Setting DSP reset vector to 0x0182a7
Releasing DSP reset
DSP configuration ... succeeded
Open taskdev: No such file or directory
/ #

My next question is... Can somebody tell me what I've missed please?

I checked into /dev/dsptask because the instructions for the demo say to =
cat
initial1.txt /dev/dsptask/test2 and I didn't have a test2 entry but I =
had
dsptask0 - dsptask9. I then tried:

Echo 'hello' > /dev/dsptask/dsptask2 and got:

mbx: ERR from DSP (TASKBUSY): 0x1002
mbx: ERR from DSP (IPBFULL): 0x00fe

Is this error related to the one above or something else I should worry
about?

Thanks,

Richard.

-----Original Message-----
From: Ishigami [mailto:ishigami@ti.com]=20
Sent: 19 December 2005 11:11
To: 'Richard Copeman'
Cc: linux-omap-open-source@linux.omap.com
Subject: RE: DSP gateway build problems with 2.6.13.4

Hello,

 1) Why is /sys not being created?

 The simple answer is --- because it's designed so.

 2) Is "m" the correct option to include the DSP=20
 gateway driver?

 There are two ways to build a driver --- as built-in
and as module.
 Option "m" means you build this driver as
module, which you need to explicitly install every time
your system boots-up.

 Until you get familiar with the steps, I'd recommend=20
to use option "y". ( embedded the  drivers in your kernel )

 Regards,
 Ishigami

-----Original Message-----
From: Richard Copeman [mailto:richard.copeman@lauterbach.co.uk]=20
Sent: Monday, December 19, 2005 7:23 PM
To: 'Ishigami'
Cc: linux-omap-open-source@linux.omap.com
Subject: RE: DSP gateway build problems with 2.6.13.4

Hi,

Many thanks for the pointers. I've grep'ed my .config file and I can see =
the
following:

CONFIG_PROC_FS=3Dy
CONFIG_SYSFS=3Dy
#CONFIG_DEVPTS_FS_XATTR is not set
#CONFIG_TMPFS is not set
#CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=3Dy


CONFIG_OMAP_DSP=3Dm
# CONFIG_OMAP_DSP_MBCMD_VERBOSE is not set
# CONFIG_OMAP_DSP_TASK_MULTIOPEN is not set
#CONFIG_OMAP_DSP_FBEXPORT is not set

This leaves me confused on two scores -=20
1) Why is /sys not being created?
2) Is "m" the correct option to include the DSP gateway driver?

If anyone has any clues for me....

Thanks,

Richard.

-----Original Message-----
From: Ishigami [mailto:ishigami@ti.com]=20
Sent: 16 December 2005 01:40
To: 'Richard Copeman'
Cc: linux-omap-open-source@linux.omap.com
Subject: RE: DSP gateway build problems with 2.6.13.4

Hello Richard,

> . /sys/devices/platform contains:
>
> i2c_omap	omap_ts	omapflash.0=09
> serial8250	smc91x		omap_cf
> omapfb	power		serial8250.0

 Hmm, your kernel doesn't seem to have the dspgateway
driver. Could you double-check your kernel configuration?

> Also, how do I fix it so that this directory is automatically
> created and mounted at boot time?=20

 Add "mount -t sysfs..." at your "/etc/inittab" file. In most
linux system, this file acts as "autoexec.bat" used for
old MS-DOS days. For its syntax, see the url below

	http://www.busybox.net/downloads/BusyBox.html
	(look for "init" command)

 Hope this helps.

 Regards,
 Ishigami

-----Original Message-----
From: Richard Copeman [mailto:richard.copeman@lauterbach.co.uk]=20
Sent: Thursday, December 15, 2005 9:13 PM
To: 'Ishigami'
Cc: linux-omap-open-source@linux.omap.com
Subject: RE: DSP gateway build problems with 2.6.13.4

Hi Ishigami,

I did not have a /sys directory. I created it as per your instructions =
but I
still get the same message from dspctl when I try to load the example.

I do not have a /sys/devices/platform/dsp.0 entry. /sys/devices/platform
contains:

i2c_omap	omap_ts	omapflash.0	serial8250		smc91x
omap_cf	omapfb	power		serial8250.0

Have I missed something important somewhere?

Also, how do I fix it so that this directory is automatically created =
and
mounted at boot time?

Thanks,

Richard.


-----Original Message-----
From: Ishigami [mailto:ishigami@ti.com]=20
Sent: 15 December 2005 11:46
To: 'Richard Copeman'
Cc: linux-omap-open-source@linux.omap.com
Subject: RE: DSP gateway build problems with 2.6.13.4

Hello Richard,

 Do you have the /sys directory? The dsp gateway needs
the sysfs mounted in the directory, as other drivers do.

 If not, please try

	# mkdir /sys
	# mount -t sysfs sysfs /sys

 Regards,
 Ishigami

-----Original Message-----
From: Richard Copeman
Sent: Thursday, December 15, 2005 8:38 PM
To: linux-omap-open-source@linux.omap.com
Subject: Re: DSP gateway build problems with 2.6.13.4

Hi Matthew,

Many thanks for the pointers. I re-built my kernel and it did link in =
the
dsp kernel objects. However, when I try to run

	dspctl start ex_task.out

on my target I get an error (some of which has been truncated by =
minicom)

Warning: none of /sys/devices/platform/dsp.0/ifver,
/sys/devices/platform/dsp0/<stuff missing here>.
(DSP Gateway driver is too old or not loaded)

I have grep'ed the header files and it is DSP Gateway 3.3 that has been
built. I built the ex_task.out and dspctl using the dspgateway 3.3 stuff =
I
downloaded from sourceforge.=20

How can I check if the dsp gateway kernel object is loaded?
How can I get information about it's version?

Thanks,

Richard.
