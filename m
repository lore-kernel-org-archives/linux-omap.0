From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: MMC problem OMAP
Date: Fri, 23 Jun 2006 17:10:59 -0400
Message-ID: <449C58E3.3010208@indt.org.br>
References: <9343BE359FA4224CA72A94D8CC362C9C0936E4@edpc500.cedt.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9343BE359FA4224CA72A94D8CC362C9C0936E4@edpc500.cedt.iisc.ernet.in>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Prakash Narayanan M <mnarayan@cedt.iisc.ernet.in>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Prakash,

Which MMC card (vendor, size) are you using? Did you test different MMC cards? I remember
that others developers were having problems with some MMC vendors that don't follow the
MMC spec.

Cheers,

Anderson Briglia

> 
> Thanks very much for that quick check. I have a few doubts.  In my case
> the kernel dmesg says some error with CMD3 and also the clock settles at
> 0Hz.  Please have a look at the message parts attached below.  Does it
> indicate a wrong kernel (buggy) I am using? My kernel is
> 2.6.17.rc6-omap1 from GIT.
> 
> mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0
> mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0 CMD 0080
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0
> mmc0: starting CMD3 arg 00000000 flags 00000065 mmci-omap mmci-omap.1:
> MMC IRQ 4000 (CMD 3): CERR mmci-omap mmci-omap.1: card status error
> (CMD3)
> mmc0: req done (CMD3): 4/0/0: a95c0520 00000000 00000000 00000000
> mmci-omap mmci-omap.1: MMC IRQ 4000 (CMD 3): CERR mmci-omap mmci-omap.1:
> card status error (CMD3)
> mmc0: req done (CMD3): 4/0/0: a95d0700 00000000 00000000 00000000
> mmci-omap mmci-omap.1: MMC IRQ 4000 (CMD 3): CERR mmci-omap mmci-omap.1:
> card status error (CMD3)
> mmc0: req done (CMD3): 4/0/0: a95e0700 00000000 00000000 00000000
> mmci-omap mmci-omap.1: MMC IRQ 4000 (CMD 3): CERR mmci-omap mmci-omap.1:
> card status error (CMD3)
> mmc0: req done (CMD3): 4/0/0: a95f0700 00000000 00000000 00000000
> mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0
> mmc0: selected 24.000MHz transfer rate
> mmc0: clock 24000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0
> mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0
> 
> 
> 
> -----Original Message-----
> From: Anderson Briglia [mailto:anderson.briglia@indt.org.br] 
> Sent: Monday, June 19, 2006 8:08 PM
> To: Prakash Narayanan M
> Cc: linux-omap-open-source@linux.omap.com
> Subject: Re: MMC problem OMAP
> 
> Hi Prakash,
> 
> I did a quick test here and seems that the MMC code for 1510 Innovator
> is working
> properly. I used the 1510's defconfig and a rootfilesystem with UDEV
> installed, so I did
> not worry about the device's node creation, it was done automatically at
> /dev/mmcblk0p1. I
> created an ext2 partition at the MMC card and mounted it without
> problems.
> 
> For your reference:
> root@arm:~# ls -la /dev/mmcblk0p1
> brw-rw----  1 root disk 254, 1 Dec 31  1969 /dev/mmcblk0p1
> 
> I noticed only a problem, that is that the MMC card is recognized only
> at boot process,
> but I think it is related to a hardware issue on 1510 Innovator.
> 
> Best Regards,
> 
> Anderson Briglia
> 
> 
>>>>I am trying to mount MMC/SD file system in OMAP 1510 (TI Innovator).
>>
>>I
>>
>>
>>>>have enabled SD support and ext2 support in the kernel
>>>>(2.6.16.13-omap1).  When the kernel boots up the following messages
>>
>>are
>>
>>
>>>>coming. 
>>>>
>>>>1)       Anyone got the same error?  What is the source of the error?
>>
>>
>>>Seems that you do not have a valid partition table available in the
> 
> MMC
> 
>>card and/or the
>>
>>
>>>MMC card is broken. AFAIK, the MMC code available for OMAP 1510
>>
>>Innovator is not broken,
>>
>>
>>>but I still not tested it recently. Use fdisk to make an ext2
> 
> partition
> 
>>in the MMC and
>>
>>
>>>test again, if it is already done let me know and I will test the
>>
>>latest >Innovator MMC
>>
>>
>>>code to give you some feedback.
>>
>>
>>
>>I tried with latest GIT (2.6.17-rc6-omap1)which looks like recognizing
>>the device without this problem.  That means what you said is correct
>>there was some broken link in kerenel 2.6.16.13.  We used the fdisk to
>>make ext2 partition.  I am attaching the kernel dmesg down for your
> 
> ref.
> 
>>
>>>>2)       Anyone mounted a ext2 file system from MMC/SD?  How do I go
>>>>about doing this?
>>
>>
>>>Yes. I guess you can do this just setting up the MMC card properly and
>>>using 'mount'. :)
>>
>>
>>To use mount I should have /dev/xxx, which is the device used.  I
>>created statically /dev/mmc and /dev/mmc1 (with major number 254 and
>>minors 0 and 1).  But it looks this is not properly initialized as cat
>>/dev/mmc gives 'no such device' message. I find in /sys somethings
>>related to mmc.
>>
>>
>>MUX: initialized MMC_CMD
>>MUX: initialized MMC_DAT0
>>MUX: initialized MMC_DAT1
>>MUX: initialized MMC_DAT2
>>MUX: initialized MMC_DAT3
>>mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0
>>mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0
>>CMD 0080
>>mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0
>>mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0
>>mmc0: starting CMD0 arg 00000000 flags 00000040
>>mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 0): EOC
>>mmc0: req done (CMD0): 0/0/0: 00000000 00000000 00000000 00000000
>>mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0
>>mmc0: starting CMD55 arg 00000000 flags 00000015
>>mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 55): EOC
>>mmc0: req done (CMD55): 0/0/0: 00000120 00000000 00000000 00000000
>>mmc0: starting CMD41 arg 00000000 flags 00000061
>>mmci-omap mmci-omap.1: MMC IRQ 1001 (CMD 41): EOC OCRB
>>mmc0: req done (CMD41): 0/0/0: 00ff8000 00000000 00000000 00000000
>>mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0
>>mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0
>>mmc0: starting CMD0 arg 00000000 flags 00000040
>>mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 0): EOC
>>mmc0: req done (CMD0): 0/0/0: 00000000 00000000 00000000 00000000
>>mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0
>>mmc0: starting CMD55 arg 00000000 flags 00000015
>>mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 55): EOC
>>mmc0: req done (CMD55): 0/0/0: 00000120 00000000 00000000 00000000
>>mmc0: starting CMD41 arg 00300000 flags 00000061
>>mmci-omap mmci-omap.1: MMC IRQ 1001 (CMD 41): EOC OCRB
>>mmc0: req done (CMD41): 0/0/0: 00ff8000 00000000 00000000 00000000
>>mmc0: starting CMD55 arg 00000000 flags 00000015
>>mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 55): EOC
>>mmc0: req done (CMD55): 0/0/0: 00000120 00000000 00000000 00000000
>>mmc0: starting CMD41 arg 00300000 flags 00000061
>>mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 41): EOC
>>mmc0: req done (CMD41): 0/0/0: 80ff8000 00000000 00000000 00000000
>>mmc0: starting CMD2 arg 00000000 flags 00000067
>>mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 2): EOC
>>mmc0: req done (CMD2): 0/0/0: 03534453 44303136 55402379 370043ad
>>mmc0: starting CMD3 arg 00000000 flags 00000065
>>mmci-omap mmci-omap.1: MMC IRQ 4000 (CMD 3): CERR
>>mmci-omap mmci-omap.1: card status error (CMD3)
>>mmc0: req done (CMD3): 4/0/0: a95c0520 00000000 00000000 00000000
>>mmci-omap mmci-omap.1: MMC IRQ 4000 (CMD 3): CERR
>>mmci-omap mmci-omap.1: card status error (CMD3)
>>mmc0: req done (CMD3): 4/0/0: a95d0700 00000000 00000000 00000000
>>mmci-omap mmci-omap.1: MMC IRQ 4000 (CMD 3): CERR
>>mmci-omap mmci-omap.1: card status error (CMD3)
>>mmc0: req done (CMD3): 4/0/0: a95e0700 00000000 00000000 00000000
>>mmci-omap mmci-omap.1: MMC IRQ 4000 (CMD 3): CERR
>>mmci-omap mmci-omap.1: card status error (CMD3)
>>mmc0: req done (CMD3): 4/0/0: a95f0700 00000000 00000000 00000000
>>mmc0: starting CMD2 arg 00000000 flags 00000067
>>mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 2): CTO
>>mmc0: req done (CMD2): 1/0/0: 00000000 00000000 00000000 00000000
>>mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 2): CTO
>>mmc0: req done (CMD2): 1/0/0: 00000000 00000000 00000000 00000000
>>mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 2): CTO
>>mmc0: req done (CMD2): 1/0/0: 00000000 00000000 00000000 00000000
>>mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 2): CTO
>>mmc0: req done (CMD2): 1/0/0: 00000000 00000000 00000000 00000000
>>mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0
>>mmc0: selected 24.000MHz transfer rate
>>mmc0: clock 24000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0
>>mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0
>>
>>
> 
> 
> 
