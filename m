From: "=?gb2312?B?yq/R8w==?=" <shy828301@126.com>
Subject: Re: RE: OMAP2430sdp MMC driver for 2.6.2
 1
Date: Tue, 24 Jul 2007 17:30:58 +0800 (CST)
Message-ID: <46A5C6D2.000065.22915@bj126app23.126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: x0khasim@ti.com, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

    =D4=DA2007-07-24=A3=AC"Syed Mohammed, Khasim"  =D0=B4=B5=C0=A3=BA=20


>Hi folks,





>





>I'm doing on OMAP2430sdp MMC driver for 2.6.21.5. I  based on minimal





>OMAP2430 patch on this mailing list and ported twl4030 GPIO and virtual





>busses drivers form 2.6.14.7.  Now kernel works well on my board. I2C al=
so





>works well on 2.6.21.5, following is I2C log message:





>











>mmc0: Response 00ff8000











>Looks like your structure is corrupted, this value is default junk value=
=2E I was seeing this error with wrong INIT_WORK parameters, note that in=
it_work parameters are >changed now.


>


>


>


>I suggest you to use twl and I2C drivers from OMAP GIT instead of portin=
g it.


I got the latest OMAP GIT tree, and use I2C and twl drivers from this tre=
e. Following is I2C log message:





bus 2 rev3.7 at 2600 kHz


bus 1 rev3.7 at 400 kHz


TWL4030: TRY attach Slave TWL4030-ID0 on Adapter OMAP I2C adapter [1]


TWL4030: TRY attach Slave TWL4030-ID1 on Adapter OMAP I2C adapter [1]


TWL4030: TRY attach Slave TWL4030-ID2 on Adapter OMAP I2C adapter [1]


TWL4030: TRY attach Slave TWL4030-ID3 on Adapter OMAP I2C adapter [1]


<6>TWL4030: Driver registration complete.





i2c /dev entries driver


TWL4030 GPIO Demux: IRQ Range 329 to 338, Initialization Success





 56:          0        INTC  i2c_omap


 57:        100        INTC  i2c_omap





I think I2C should work well.


>


>


>


>I have a working 2430 MMC code base for Latest OMAP GIT, I am in the pro=
cess of adopting this to new data structures in include/asm/arch/mmc.h, s=
ome how not fitting >in straight. But the attached code should work with =
minimal configuration. Need some cleanups before submitting for comments.


>


>


>


>I have not validated SD but MMC is validated for sure. Should help you.


Thanks for your patches. I tried it on 2.6.21.5 and OMAP GIT tree for SD =
card. It seems driver doesn't work well for SD card (2.6.21.5 and OMAP GI=
T tree). I found the error is CMD1 is timeout. Following is the log messa=
ge:





mmc0: set_ios: clock 0Hz busmode 1 powermode 0 Vdd 0 Bus Width 0


=2E..


mmc0: set_ios: clock 0Hz busmode 1 powermode 1 Vdd 15 Bus Width 0


mmc0: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 15 Bus Width 0


mmc0: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 15 Bus Width 0


mmc0: CMD0, argument 0x00000000


IRQ Status is 1


mmc0: End request, err 0


mmc0: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 15 Bus Width 0


mmc0: CMD55, argument 0x00000000


IRQ Status is 18000


mmc0: End request, err 1


=2E..


mmc0: CMD55, argument 0x00000000


IRQ Status is 18000


mmc0: End request, err 1


mmc0: CMD55, argument 0x00000000


IRQ Status is 18000


mmc0: End request, err 1


mmc0: CMD55, argument 0x00000000


IRQ Status is 18000


mmc0: End request, err 1


mmc0: CMD1, argument 0x00000000


IRQ Status is 18000


mmc0: End request, err 1


mmc0: set_ios: clock 0Hz busmode 1 powermode 0 Vdd 0 Bus Width 0





I hope this log message is helpful for you. I will try this driver for MM=
C card, but I have to find a MMC card firstly :-). Thanks.





Best Regards,





Yang Shi


>


>


>


>Regards,


>


>Khasim











iPod=A1=A2=CD=F2 =B5=E3 =BE=DE =B6=EE =B5=E3 =BF=A8=A1=A2=BD=B1 =D1=A7 =BD=
=F0=A1=AD=A1=AD=BA=A3 =C1=BF =BD=B1 =C6=B7=A3=AC=CF=EB =C4=C3 =BE=CD =C4=C3=
=A3=A1=20
