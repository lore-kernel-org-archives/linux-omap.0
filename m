From: "Eyal Shani" <Eyal.Shani@SanDisk.Com>
Subject: RE: TI 2430 MontaVista Kernel 2.6 Mobilinux - eth smc device not
	found
Date: Wed, 29 Nov 2006 15:15:49 +0200
Message-ID: <13ECC251745F8F4BA0076A980813C7C29AF974@msl-ex02.corp.m-sys.com>
References: <13ECC251745F8F4BA0076A980813C7C20FB398@msl-ex02.corp.m-sys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <13ECC251745F8F4BA0076A980813C7C20FB398@msl-ex02.corp.m-sys.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Eyal Shani <Eyal.Shani@SanDisk.Com>
List-Id: linux-omap@vger.kernel.org

hi=20guys,

Using=20MontaVista=20Mobilinux=204.1=20for=20TI=20OMAP=202430=20SDP.
I=20am=20receiving=20the=20below=20PANIC=20while=20initializing=20the=20ke=
rnel=20from=20TFTP
on=20the=202430=20OMAP=20platform.

The=20NETWORK=20CARD=20init=20code,=20smc91x=20is=20not=20finding=20the=20=
device=20-=20
'smc91x:=20not=20found=20(-19)'.
The=20output=20is=20'No=20network=20devices=20available'=20-=20from=20IP-C=
ONFIG.=20

This=20is=20a=20brand=20new=20kernel,=20that=20cannot=20jump=20start=20the=
=20platform=20for=20the
first=20time.

I=20have=20carried=20out=20some=20more=20debugging=20and=20found=20the=20f=
ollowing:

from=20kernel=20init=20flow,=20after=20adding=20some=20prints=20into=20the=
=20smc91x.c=20code:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
:
:
RAMDISK=20driver=20initialized:=2016=20RAM=20disks=20of=208192K=20size=201=
024=20blocksize
loop:=20loaded=20(max=208=20devices)
before=20smc_probe::EYAL=20smc91x:=20ioaddr=3D0xc2864300
smc91x:=20smc_probe
smc91x:=20ioaddr=3D0xc2864300
smc91x:=20bank=20signature=20probe=20returned=200x0187
smc91x:=20not=20found=20(-19).
:
:


Mind=20u:
1.=20I=20have=20ruled=20out=20a=20HW=20issue=20on=20the=20smc=20onboard=20=
card=20-=20The=20uImage=20for
2430=20=092.6=20kernel=20binary=20from=20TI=20identifies=20the=20ETH0=20de=
vice,=20so=20it=20is
not=20an=20=09HW=20issue.=20Alas,=20I=20cannot=20use=20that=20kernel,=20si=
nce=20I=20cannot=20compile
it...
2.=20The=20OneNand=20is=20not=20recognized,=20since=20I=20pulled=20up=20it=
's=20CS=20-=20this=20is
not=20=09the=20issue.

Original=20U-boot=20TFTP=20&=20Kernel=20init=20flow=20output::
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
OMAP243X=20SDP=20#=20bootm
##=20Booting=20image=20at=2080000000=20...
=20=20=20Image=20Name:=20=20=20Linux-2.6.10_mobilinux410-omap24
=20=20=20Image=20Type:=20=20=20ARM=20Linux=20Kernel=20Image=20(uncompresse=
d)
=20=20=20Data=20Size:=20=20=20=201401456=20Bytes=20=3D=20=201.3=20MB
=20=20=20Load=20Address:=2080008000
=20=20=20Entry=20Point:=20=2080008000
=20=20=20Verifying=20Checksum=20...=20OK
OK
Starting=20kernel=20...
=20
Uncompressing
Linux.............................................................
.................................=20done,=20booting=20the=20kernel.
Linux=20version=202.6.10_mobilinux410-omap2430_sdp
(root@localhost.localdomain)=20(gcc

=20version=203.4.3=20(MontaVista=203.4.3-25.0.109.0601319=202006-08-20))=20=
#5=20Tue
Nov=2021=2017:

41:06=20IST=202006
CPU:=20TI=20OMAP2430=20(ARM1136JF-S)=20[4107b362]=20revision=202=20(ARMv6T=
EJ)
CPU0:=20D=20VIPT=20write-back=20cache
CPU0:=20I=20cache:=2032768=20bytes,=20associativity=204,=2032=20byte=20lin=
es,=20256=20sets
CPU0:=20D=20cache:=2032768=20bytes,=20associativity=204,=2032=20byte=20lin=
es,=20256=20sets
Machine:=20OMAP24xx=202430SDP
Memory=20policy:=20ECC=20disabled,=20Data=20cache=20writeback
Power=20Management=20for=20TI=20OMAP.
Clocking=20rate=20(xtal/DPLL/MPU):=2013.0/660/330=20MHz
clock.c:=20Enable=20for=20dpll_ck=20without=20enable=20code
Disabling=20unused=20clock=20"i2chs2_fck"...=20<6>=20done
Disabling=20unused=20clock=20"i2c2_ick"...=20<6>=20done
Disabling=20unused=20clock=20"i2chs1_fck"...=20<6>=20done
Disabling=20unused=20clock=20"i2c1_ick"...=20<6>=20done
Disabling=20unused=20clock=20"wdt1_ick"...=20<6>=20done
Disabling=20unused=20clock=20"mpu_wdt_fck"...=20<6>=20done
Disabling=20unused=20clock=20"mpu_wdt_ick"...=20<6>=20done
Disabling=20unused=20clock=20"gpios_fck"...=20<6>=20done
Disabling=20unused=20clock=20"gpios_ick"...=20<6>=20done
Disabling=20unused=20clock=20"gpt2_fck"...=20<6>=20done
Disabling=20unused=20clock=20"gpt2_ick"...=20<6>=20done
Disabling=20unused=20clock=20"mdm_osc_ck"...=20<6>=20done
Disabling=20unused=20clock=20"iva2_1_fck"...=20<6>=20done
Disabling=20unused=20clock=20"apll54_ck"...=20<6>=20done
Built=201=20zonelists
Kernel=20command=20line:=20mem=3D32M=20console=3DttyS0,115200n8=20noinitrd=

root=3D/dev/nfs=20ip=3Ddhcp
PID=20hash=20table=20entries:=20256=20(order:=208,=204096=20bytes)
OMAP=20GPTimer1=20hardware=20version=201.6
OMAP=20GPTimer2=20hardware=20version=201.6
Console:=20colour=20dummy=20device=2080x30
Dentry=20cache=20hash=20table=20entries:=208192=20(order:=203,=2032768=20b=
ytes)
Inode-cache=20hash=20table=20entries:=204096=20(order:=202,=2016384=20byte=
s)
Memory:=2032MB=20=3D=2032MB=20total
Memory:=2029312KB=20available=20(2396K=20code,=20533K=20data,=20128K=20ini=
t)
Mount-cache=20hash=20table=20entries:=20512=20(order:=200,=204096=20bytes)=

CPU:=20Testing=20write=20buffer=20coherency:=20ok
spawn_desched_task(00000000)
desched=20cpu_callback=203/00000000
ksoftirqd=20started=20up.
desched=20cpu_callback=202/00000000
desched=20thread=200=20started=20up.
NET:=20Registered=20protocol=20family=2016
OMAP=20DMA4=20hardware=20Initialized=20(max=20lch=3D32)
OMAP=20GPIO=20hardware=20version=202.2
OMAP=20virtual=20buses=20initialized
map2_disp:=20timeout=20waiting=20for=20display=20controller=20reset
OMAP=20Display=20hardware=20version=201.0
Registering=20OMAP=20device=20'OMAP24xx=20I2C=2003'.=20Parent=20at=20L4COR=
E
Registering=20OMAP=20device=20'OMAP24xx=20I2C=2013'.=20Parent=20at=20L4COR=
E
TWL4030=20Power=20Companion=20Active
TWL4030:=20Driver=20registration=20complete.
SCSI=20subsystem=20initialized
usbcore:=20registered=20new=20driver=20usbfs
usbcore:=20registered=20new=20driver=20hub
musb_hdrc:=20version=202.2a/db-0.4.8=20[musb-dma]=20[otg:=20peripheral+hos=
t]
debug=3D0]
usb_hdrc:=20USB=20OTG=20mode=20controller=20at=20c2800000=20using=20DMA,=20=
IRQ=2092
musb_hdrc=20musb_hdrc.0:=20new=20USB=20bus=20registered,=20assigned=20bus=20=
number=201
memmap=201.1=20initialised
OMAP24xx=20Dynamic=20Power=20Management
NetWinder=20Floating=20Point=20Emulator=20V0.97=20(double=20precision)
JFFS2=20version=202.2.=20(NAND)=20(C)=202001-2003=20Red=20Hat,=20Inc.
Registering=20OMAP=20device=20'sdp2430_lcd9'.=20Parent=20at=20L3
Registering=20OMAP=20device=20'sdp2430_tv10'.=20Parent=20at=20L3
Registering=20OMAP=20device=20'omap24xxfb6'.=20Parent=20at=20L3
omap24xxfb:=20Options=20"<NULL>"
Console:=20switching=20to=20colour=20frame=20buffer=20device=2030x40
omap24xxfb:=20fb0=20frame=20buffer=20device
omap24xxfb:=20display=20mode=20240x320x16=20hsync=2019kHz=20vsync=2058Hz
omap_wdt:=20TI=20OMAP=20Watchdog=20Timer:=20timer=20margin=2010000=20sec
Serial:=208250/16550=20driver=20$Revision:=201.90=20$=204=20ports,=20IRQ=20=
sharing
disabled
ttyS0=20at=20MMIO=200x4806a000=20(irq=20=3D=2072)=20is=20a=20ST16654
ttyS1=20at=20MMIO=200x4806c000=20(irq=20=3D=2073)=20is=20a=20ST16654
ttyS2=20at=20MMIO=200x4806e000=20(irq=20=3D=2074)=20is=20a=20ST16654
io=20scheduler=20noop=20registered
io=20scheduler=20anticipatory=20registered
io=20scheduler=20deadline=20registered
io=20scheduler=20cfq=20registered
RAMDISK=20driver=20initialized:=2016=20RAM=20disks=20of=208192K=20size=201=
024=20blocksize
loop:=20loaded=20(max=208=20devices)
OMAP=20Timer32K=20is=20initialized
Registering=20OMAP=20device=20'omap-twl4030rtc16'.=20Parent=20at=20L4CORE
omap-twl4030rtc:TWL4030-RTC=20Power=20up=20reset=20detected.
omap-twl4030rtc:Enabling=20TWL4030-RTC.
smc91x:=20not=20found=20(-19).
TWL4030=20GPIO=20Demux:=20IRQ=20Range=20264=20to=20273,=20Initialization=20=
Success
Linux=20video=20capture=20interface:=20v1.00
Registering=20OMAP=20device=20'omap24xxcam0'.=20Parent=20at=20L3
EX3691:Failed=20to=20detect=20EX3691=20SOC.
omap24xxcam:=20cannot=20initialize=20sensor
Registering=20OMAP=20device=20'omap24xxvout111'.=20Parent=20at=20L3
omap24xxvout:=20registered=20device=20video1=20[v4l2]
Registering=20OMAP=20device=20'omap24xxvout212'.=20Parent=20at=20L3
omap24xxvout:=20registered=20device=20video2=20[v4l2]
OMAP=20HDQ=20Hardware=20Revision=200.3.=20Driver=20in=20interrupt=20mode.
elevator:=20using=20anticipatory=20as=20default=20io=20scheduler
omapflash.1:=20Found=201=20x16=20devices=20at=200x0=20in=2016-bit=20bank
omapflash.1:=20Found=201=20x16=20devices=20at=200x2000000=20in=2016-bit=20=
bank
=20Intel/Sharp=20Extended=20Query=20Table=20at=200x010A
=20Intel/Sharp=20Extended=20Query=20Table=20at=200x010A
=20Intel/Sharp=20Extended=20Query=20Table=20at=200x010A
=20Intel/Sharp=20Extended=20Query=20Table=20at=200x010A
=20Intel/Sharp=20Extended=20Query=20Table=20at=200x010A
Using=20buffer=20write=20method
cfi_cmdset_0001:=20Erase=20suspend=20on=20write=20enabled
Creating=204=20MTD=20partitions=20on=20"omapflash.1":
0x00000000-0x00040000=20:=20"(strata)=20bootloader"
0x00040000-0x00060000=20:=20"(strata)=20params"
0x00060000-0x00260000=20:=20"(strata)=20kernel"
0x00260000-0x04000000=20:=20"(strata)=20filesystem"
omapflash:=20probe=20of=20omapflash.0=20failed=20with=20error=20-5
NAND:=20Unable=20to=20find=20NAND=20settings=20in=20GPMC=20Configuration=20=
-=20quitting
mice:=20PS/2=20mouse=20device=20common=20for=20all=20mice
Registering=20OMAP=20device=20'omap_twl4030keypad1'.=20Parent=20at=20L4COR=
E
Registering=20OMAP=20device=20'omap_tsc20468'.=20Parent=20at=20L4CORE
Registering=20OMAP=20device=20'omap2430-mmc12'.=20Parent=20at=20L3
Registering=20OMAP=20device=20'omap2430-mmc217'.=20Parent=20at=20L3
Registering=20OMAP=20device=20'omap-audio7'.=20Parent=20at=20L3
OMAP243X=20TWL4030=20Audio=20Support:=20Chip=20Rev[0x2f]=20Initialized
NET:=20Registered=20protocol=20family=202
IP:=20routing=20cache=20hash=20table=20of=20512=20buckets,=204Kbytes
TCP:=20Hash=20tables=20configured=20(established=202048=20bind=204096)
NET:=20Registered=20protocol=20family=201
NET:=20Registered=20protocol=20family=2017
VFP=20support=20v0.3:=20implementor=2041=20architecture=201=20part=2020=20=
variant=20b=20rev=202
IP-Config:=20No=20network=20devices=20available.
Root-NFS:=20No=20NFS=20server=20available,=20giving=20up.
VFS:=20Unable=20to=20mount=20root=20fs=20via=20NFS,=20trying=20floppy.
VFS:=20Cannot=20open=20root=20device=20"nfs"=20or=20unknown-block(2,0)
Please=20append=20a=20correct=20"root=3D"=20boot=20option
Kernel=20panic=20-=20not=20syncing:=20VFS:=20Unable=20to=20mount=20root=20=
fs=20on
unknown-block(2,0)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D



thanks=20in=20advacne,
eyal=20s.
=20

______________________________________________________________________
This=20email=20has=20been=20scanned=20by=20the=20MessageLabs=20Email=20Sec=
urity=20System.
For=20more=20information=20please=20visit=20http://www.messagelabs.com/ema=
il=20
______________________________________________________________________

______________________________________________________________________
This=20email=20has=20been=20scanned=20by=20the=20MessageLabs=20Email=20Sec=
urity=20System.
For=20more=20information=20please=20visit=20http://www.messagelabs.com/ema=
il=20
______________________________________________________________________
