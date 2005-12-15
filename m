From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: RE: DSP gateway build problems with 2.6.13.4
Date: Thu, 15 Dec 2005 12:12:32 -0000
Message-ID: <000001c60170$d3da45a0$642aa8c0@BUFFY>
References: <200512151145.jBFBjxRC027347@dmhp30.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200512151145.jBFBjxRC027347@dmhp30.itg.ti.com>
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
