From: "=?gb2312?B?yq/R8w==?=" <shy828301@126.com>
Subject: OMAP2430sdp MMC driver for 2.6.21
Date: Mon, 23 Jul 2007 18:32:02 +0800 (CST)
Message-ID: <46A483A2.0000A7.03863@bj126app59.126.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi folks,

I'm doing on OMAP2430sdp MMC driver for 2.6.21.5. I  based on minimal OMA=
P2430 patch on this mailing list and ported twl4030 GPIO and virtual buss=
es drivers form 2.6.14.7.  Now kernel works well on my board. I2C also wo=
rks well on 2.6.21.5, following is I2C log message:

i2c_omap i2c_omap.2: bus 2 rev3.7 at 100 kHz
i2c_omap i2c_omap.1: bus 1 rev3.7 at 100 kHz
TWL4030: TRY attach Slave TWL4030-ID0 on Adapter OMAP I2C adapter[1][1]
TWL4030: TRY attach Slave TWL4030-ID1 on Adapter OMAP I2C adapter[1][1]
TWL4030: TRY attach Slave TWL4030-ID2 on Adapter OMAP I2C adapter[1][1]
TWL4030: TRY attach Slave TWL4030-ID3 on Adapter OMAP I2C adapter[1][1]
TWL4030 Power Companion Active
TWL4030: Driver registration complete.

TWL4030 GPIO Demux: IRQ Range 329 to 338, Initialization Success

 56:          0        INTC  i2c_omap
 57:        130        INTC  i2c_omap

So I ported MMC driver from 2.6.14.7. New driver can initialize host colt=
roller successfully. It seems power supply, clocks and interrupt work wel=
l. Following is MMC log message:

Registering OMAP device 'omap2430-mmc12'. Parent at L3

mmc0: set_ios: clock 0Hz busmode 1 powermode 0 Vdd 0 Bus Width 0

Advanced Linux Sound Architecture Driver Version 1.0.14rc3 (Wed Mar 14 07=
:25:50 2007 UTC).
mmc0: set_ios: clock 0Hz busmode 1 powermode 1 Vdd 15 Bus Width 0
mmc0: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 15 Bus Width 0
mmc0: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 15 Bus Width 0
mmc0: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 15 Bus Width 0
ALSA device list:

OMAP GPIO switch handler initializing
mmc0: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 14 Bus Width 0
mmc0: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 14 Bus Width 0
mmc0: set_ios: clock 400000Hz busmode 1 powermode 2 Vdd 14 Bus Width 0

 72:         74        INTC  serial
 83:        114        INTC  omap2430-mmc1
309:       2302        GPIO  eth0

There is a SD card in slot 1 on my board. But drvier can't detect this ca=
rd. I printed SYSCTL, CAPA, CUR_CAPA and HCTL registers' values(SYSCTL is=
 e0007. CAPA is 6e10080. CUR_CAPA is 0. HCTL is d00.), they are same as 2=
=2E6.14.7. And I enabled debug message for MMC driver. I found driver can=
 send CMD1 command, but CMD1's reponse value always is 0x00ff8000. But ac=
cording manual, the right reponse value should be 0x80ff8000. So CMD2 is =
always timeout. Following is the debug message:

=2E..
mmc0: CMD1, argument 0x00300000

, 32-bit response,

Status in IRQ 1

mmc0: Response 00ff8000

mmc0: End request, err 0

mmc0: CMD1, argument 0x00300000

, 32-bit response,

Status in IRQ 1

mmc0: Response 00ff8000

mmc0: End request, err 0

mmc0: CMD2, argument 0x00000000

, 128-bit response, CRC

Status in IRQ 18000

mmc0: Response 00000000 00000000 00000000 00ff8000

mmc0: End request, err 1

mmc0: CMD2, argument 0x00000000

, 128-bit response, CRC

Status in IRQ 18000

mmc0: Response 00000000 00000000 00000000 00ff8000

mmc0: End request, err 1

mmc0: CMD2, argument 0x00000000

, 128-bit response, CRC

Status in IRQ 18000

mmc0: Response 00000000 00000000 00000000 00ff8000

mmc0: End request, err 1

mmc0: CMD2, argument 0x00000000
,  128-bit response, CRC

Status in IRQ 18000

mmc0: Response 00000000 00000000 00000000 00ff8000

mmc0: End request, err 1

mmc0: set_ios: clock 400000Hz busmode 2 powermode 2 Vdd 14 Bus Width 0

mmc0: set_ios: clock 0Hz busmode 1 powermode 0 Vdd 0 Bus Width 0


I suspected the root cause is not in MMC driver, maybe I forgot something=
 else. So could anyone please give me some hints? Thanks.

Best Regards,
Yang Shi

 =20


=A1=B6=B4=F3 =BB=B0 =CE=F7 =D3=CE 3=A1=B7 =CA=D7 =BD=EC =CD=E6 =BC=D2 =BC=
=FB =C3=E6 =BB=E1 =BC=B4 =BD=AB =D4=DA =B9=E3 =D6=DD =D5=D9 =BF=AA=A3=A1=BE=
=B4 =C7=EB =B9=D8 =D7=A2 >>=20
