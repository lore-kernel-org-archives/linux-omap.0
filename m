From: "Ishigami" <ishigami@ti.com>
Subject: RE: DSP gateway build problems with 2.6.13.4
Date: Thu, 15 Dec 2005 20:45:57 +0900
Message-ID: <200512151145.jBFBjxRC027347@dmhp30.itg.ti.com>
References: <001b01c6016b$fd660d50$642aa8c0@BUFFY>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <001b01c6016b$fd660d50$642aa8c0@BUFFY>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Richard Copeman' <richard.copeman@lauterbach.co.uk>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

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
