From: "Ishigami" <ishigami@ti.com>
Subject: RE: DSP gateway build problems with 2.6.13.4
Date: Mon, 19 Dec 2005 20:11:07 +0900
Message-ID: <200512191111.jBJBBLj5007198@dmhp30.itg.ti.com>
References: <000e01c60486$2bd5f9d0$642aa8c0@BUFFY>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <000e01c60486$2bd5f9d0$642aa8c0@BUFFY>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: 'Richard Copeman' <richard.copeman@lauterbach.co.uk>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,

 1) Why is /sys not being created?

 The simple answer is --- because it's designed so.

 2) Is "m" the correct option to include the DSP 
 gateway driver?

 There are two ways to build a driver --- as built-in
and as module.
 Option "m" means you build this driver as
module, which you need to explicitly install every time
your system boots-up.

 Until you get familiar with the steps, I'd recommend 
to use option "y". ( embedded the  drivers in your kernel )

 Regards,
 Ishigami

-----Original Message-----
From: Richard Copeman [mailto:richard.copeman@lauterbach.co.uk] 
Sent: Monday, December 19, 2005 7:23 PM
To: 'Ishigami'
Cc: linux-omap-open-source@linux.omap.com
Subject: RE: DSP gateway build problems with 2.6.13.4

Hi,

Many thanks for the pointers. I've grep'ed my .config file and I can see the
following:

CONFIG_PROC_FS=y
CONFIG_SYSFS=y
#CONFIG_DEVPTS_FS_XATTR is not set
#CONFIG_TMPFS is not set
#CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y


CONFIG_OMAP_DSP=m
# CONFIG_OMAP_DSP_MBCMD_VERBOSE is not set
# CONFIG_OMAP_DSP_TASK_MULTIOPEN is not set
#CONFIG_OMAP_DSP_FBEXPORT is not set

This leaves me confused on two scores - 
1) Why is /sys not being created?
2) Is "m" the correct option to include the DSP gateway driver?

If anyone has any clues for me....

Thanks,

Richard.

-----Original Message-----
From: Ishigami [mailto:ishigami@ti.com] 
Sent: 16 December 2005 01:40
To: 'Richard Copeman'
Cc: linux-omap-open-source@linux.omap.com
Subject: RE: DSP gateway build problems with 2.6.13.4

Hello Richard,

> . /sys/devices/platform contains:
>
> i2c_omap	omap_ts	omapflash.0	
> serial8250	smc91x		omap_cf
> omapfb	power		serial8250.0

 Hmm, your kernel doesn't seem to have the dspgateway
driver. Could you double-check your kernel configuration?

> Also, how do I fix it so that this directory is automatically
> created and mounted at boot time? 

 Add "mount -t sysfs..." at your "/etc/inittab" file. In most
linux system, this file acts as "autoexec.bat" used for
old MS-DOS days. For its syntax, see the url below

	http://www.busybox.net/downloads/BusyBox.html
	(look for "init" command)

 Hope this helps.

 Regards,
 Ishigami

-----Original Message-----
From: Richard Copeman [mailto:richard.copeman@lauterbach.co.uk] 
Sent: Thursday, December 15, 2005 9:13 PM
To: 'Ishigami'
Cc: linux-omap-open-source@linux.omap.com
Subject: RE: DSP gateway build problems with 2.6.13.4

Hi Ishigami,

I did not have a /sys directory. I created it as per your instructions but I
still get the same message from dspctl when I try to load the example.

I do not have a /sys/devices/platform/dsp.0 entry. /sys/devices/platform
contains:

i2c_omap	omap_ts	omapflash.0	serial8250		smc91x
omap_cf	omapfb	power		serial8250.0

Have I missed something important somewhere?

Also, how do I fix it so that this directory is automatically created and
mounted at boot time?

Thanks,

Richard.


-----Original Message-----
From: Ishigami [mailto:ishigami@ti.com] 
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

Many thanks for the pointers. I re-built my kernel and it did link in the
dsp kernel objects. However, when I try to run

	dspctl start ex_task.out

on my target I get an error (some of which has been truncated by minicom)

Warning: none of /sys/devices/platform/dsp.0/ifver,
/sys/devices/platform/dsp0/<stuff missing here>.
(DSP Gateway driver is too old or not loaded)

I have grep'ed the header files and it is DSP Gateway 3.3 that has been
built. I built the ex_task.out and dspctl using the dspgateway 3.3 stuff I
downloaded from sourceforge. 

How can I check if the dsp gateway kernel object is loaded?
How can I get information about it's version?

Thanks,

Richard.
