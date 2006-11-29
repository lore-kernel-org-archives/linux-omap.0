From: "Eyal Shani" <Eyal.Shani@SanDisk.Com>
Subject: RE: TI 2430 MontaVista Kernel 2.6 Mobilinux - eth smc device
	notfound
Date: Wed, 29 Nov 2006 17:21:57 +0200
Message-ID: <13ECC251745F8F4BA0076A980813C7C29AF9D2@msl-ex02.corp.m-sys.com>
References: <EA12F909C0431D458B9D18A176BEE4A508C2464E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A508C2464E@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>, linux-omap-open-source@linux.omap.com
Cc: Eyal Shani <Eyal.Shani@SanDisk.Com>
List-Id: linux-omap@vger.kernel.org

Hi=20Richard,

Thanks=20for=20your=20swift=20answer.

Regarding=20your=20questions,=20see=20answers=20below.
Wrote=20it=20in=20[eyal=20s.].

Thanks=20in=20advance,

Eyal=20Shani


-----Original=20Message-----
From:=20Woodruff,=20Richard=20[mailto:r-woodruff2@ti.com]=20
Sent:=20Wednesday,=20November=2029,=202006=203:54=20PM
To:=20Eyal=20Shani;=20linux-omap-open-source@linux.omap.com
Subject:=20RE:=20TI=202430=20MontaVista=20Kernel=202.6=20Mobilinux=20-=20e=
th=20smc=20device
notfound

Hello=20Eyal,

If=20you=20have=20proper=20access=20to=20a=20MV=20kernel=20they=20should=20=
be=20able=20to=20help=20you
through.=20=20I=20would=20expect=20there=20is=20some=20configuration=20err=
or.
[eyal=20s.]=20I=20too=20feel=20it=20is=20a=20configuration=20error.=20Stil=
l,=20no=20way=20of
finding=20what=20it=20is.

*=20My=20first=20guess=20based=20on=20your=20symptoms=20is=20you=20have=20=
a=20GPMC=20timing
mismatch=20between=20the=20u-boot=20on=20your=20board=20and=20the=20target=
=20speed=20as
defined=20in=20your=20kernel.=20=20AFAIK=20in=20that=20build=20you=20need=20=
to=20have=20the
'fastest'=20u-boot=20to=20support=20kernels=20of=20other=20speeds.=20=20Th=
ere=20is=20not
currently=20a=20re-program=20of=20the=20GPMC=20timings.=20=20You=20need=20=
to=20have=20a=20"PRCM
#2"=20built=20u-boot=20to=20work=20across=20the=20target=20clock=20speeds.=

[eyal=20s.]=20how=20do=20I=20build=20this=20kind=20of=20u-boot?!=20I=20mea=
n=20how=20do=20I=20make=20it
PRCM=20#2?

*=20What=20version=20of=20SDP=20board=20do=20you=20have?=20=20
[eyal=20s.]=20I=20am=20using=20SDP2430=20V1.1=20board.

Where=20did=20you=20get=20the=20u-boot=20binary=20on=20your=20board?=20=20=

[eyal=20s.]=20Took=20the=20u-boot.bin=20from=20TI=20Download=20site,=20for=
=202430=20board,
linux.

As=20you=20did=20not=20provide=20the=20u-boot=20startup=20banner=20its=20n=
ot=20obvious=20which
u-boot=20you=20have=20on=20your=20board=20and=20the=20speed=20it=20is=20se=
t=20for.
[eyal=20s.]
=09U-Boot=201.1.3=20(Feb=2027=202006=20-=2012:23:36)

=09U-Boot=20code:=2080E80000=20->=2080E9F608=20=20BSS:=20->=2080EA4EB4
=09OMAP2430C-GP=20revision=200,=20PRCM=20#5A
=09TI=202430SDP=20Base=20Board=20+=200.1=20Version=20+=20mDDR
=09RAM=20Configuration:
=09Bank=20#0:=2080000000=20128=20MB
=09Bank=20#1:=2088000000=20=200=20kB
=09Flash:=20192=20MB
=09NAND:64=20MB
=09In:=20=20=20=20serial
=09Out:=20=20=20serial
=09Err:=20=20=20serial
=09OMAP243X=20SDP=20#

*=20What=20is=20the=20problem=20in=20rebuilding=20a=20kernel=20from=20the=20=
TI=20builds?=20=20They
should=20work...=20if=20not=20we=20will=20fix=20them.
[eyal=20s.]=20I=20have=20the=20kernel=20from=20site=20http://linux.omap.co=
m/pub/
The=20tool-chain=20there=20is=20not=20relevant=20for=20the=20build=20of=20=
arm=20V6=20kernel.


The=20only=20time=20in=20recent=20kernels=20I=20have=20seen=20anything=20l=
ike=20you=20describe
is=20with=20bad=20hardware=20or=20mis-configured=20clocks.

Regards,
Richard=20W.=20

>=20-----Original=20Message-----
>=20From:=20
>=20linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.c
>=20om=20
>=20[mailto:linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linu
>=20x.omap.com]=20On=20Behalf=20Of=20Eyal=20Shani
>=20Sent:=20Wednesday,=20November=2029,=202006=207:16=20AM
>=20To:=20linux-omap-open-source@linux.omap.com
>=20Cc:=20Eyal=20Shani
>=20Subject:=20RE:=20TI=202430=20MontaVista=20Kernel=202.6=20Mobilinux=20-=
=20eth=20
>=20smc=20device=20notfound
>=20
>=20hi=20guys,
>=20
>=20Using=20MontaVista=20Mobilinux=204.1=20for=20TI=20OMAP=202430=20SDP.
>=20I=20am=20receiving=20the=20below=20PANIC=20while=20initializing=20the=20=
kernel=20
>=20from=20TFTP=20on=20the=202430=20OMAP=20platform.
>=20
>=20The=20NETWORK=20CARD=20init=20code,=20smc91x=20is=20not=20finding=20th=
e=20device=20-
>=20'smc91x:=20not=20found=20(-19)'.
>=20The=20output=20is=20'No=20network=20devices=20available'=20-=20from=20=
IP-CONFIG.=20
>=20
>=20This=20is=20a=20brand=20new=20kernel,=20that=20cannot=20jump=20start=20=
the=20
>=20platform=20for=20the=20first=20time.
>=20
>=20I=20have=20carried=20out=20some=20more=20debugging=20and=20found=20the=
=20following:
>=20
>=20from=20kernel=20init=20flow,=20after=20adding=20some=20prints=20into=20=
the=20
>=20smc91x.c=20code:
>=20=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20:
>=20:
>=20RAMDISK=20driver=20initialized:=2016=20RAM=20disks=20of=208192K=20size=
=201024=20blocksize
>=20loop:=20loaded=20(max=208=20devices)
>=20before=20smc_probe::EYAL=20smc91x:=20ioaddr=3D0xc2864300
>=20smc91x:=20smc_probe
>=20smc91x:=20ioaddr=3D0xc2864300
>=20smc91x:=20bank=20signature=20probe=20returned=200x0187
>=20smc91x:=20not=20found=20(-19).
>=20:
>=20:
>=20
>=20
>=20Mind=20u:
>=201.=20I=20have=20ruled=20out=20a=20HW=20issue=20on=20the=20smc=20onboar=
d=20card=20-=20The=20
>=20uImage=20for
>=202430=20=092.6=20kernel=20binary=20from=20TI=20identifies=20the=20ETH0=20=
device,=20so=20it=20is
>=20not=20an=20=09HW=20issue.=20Alas,=20I=20cannot=20use=20that=20kernel,=20=
since=20
>=20I=20cannot=20compile
>=20it...
>=202.=20The=20OneNand=20is=20not=20recognized,=20since=20I=20pulled=20up=20=
it's=20CS=20-=20this=20is
>=20not=20=09the=20issue.
>=20
>=20Original=20U-boot=20TFTP=20&=20Kernel=20init=20flow=20output::
>=20=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20OMAP243X=20SDP=20#=20bootm
>=20##=20Booting=20image=20at=2080000000=20...
>=20=20=20=20Image=20Name:=20=20=20Linux-2.6.10_mobilinux410-omap24
>=20=20=20=20Image=20Type:=20=20=20ARM=20Linux=20Kernel=20Image=20(uncompr=
essed)
>=20=20=20=20Data=20Size:=20=20=20=201401456=20Bytes=20=3D=20=201.3=20MB
>=20=20=20=20Load=20Address:=2080008000
>=20=20=20=20Entry=20Point:=20=2080008000
>=20=20=20=20Verifying=20Checksum=20...=20OK
>=20OK
>=20Starting=20kernel=20...
>=20=20
>=20Uncompressing
>=20Linux.............................................................
>=20.................................=20done,=20booting=20the=20kernel.
>=20Linux=20version=202.6.10_mobilinux410-omap2430_sdp
>=20(root@localhost.localdomain)=20(gcc
>=20
>=20=20version=203.4.3=20(MontaVista=203.4.3-25.0.109.0601319=20
>=202006-08-20))=20#5=20Tue=20Nov=2021=2017:
>=20
>=2041:06=20IST=202006
>=20CPU:=20TI=20OMAP2430=20(ARM1136JF-S)=20[4107b362]=20revision=202=20(AR=
Mv6TEJ)
>=20CPU0:=20D=20VIPT=20write-back=20cache
>=20CPU0:=20I=20cache:=2032768=20bytes,=20associativity=204,=2032=20byte=20=
lines,=20256=20sets
>=20CPU0:=20D=20cache:=2032768=20bytes,=20associativity=204,=2032=20byte=20=
lines,=20256=20sets
>=20Machine:=20OMAP24xx=202430SDP
>=20Memory=20policy:=20ECC=20disabled,=20Data=20cache=20writeback=20Power=20=

>=20Management=20for=20TI=20OMAP.
>=20Clocking=20rate=20(xtal/DPLL/MPU):=2013.0/660/330=20MHz
>=20clock.c:=20Enable=20for=20dpll_ck=20without=20enable=20code=20Disablin=
g=20
>=20unused=20clock=20"i2chs2_fck"...=20<6>=20done=20Disabling=20unused=20c=
lock=20
>=20"i2c2_ick"...=20<6>=20done=20Disabling=20unused=20clock=20"i2chs1_fck"=
...=20
>=20<6>=20done=20Disabling=20unused=20clock=20"i2c1_ick"...=20<6>=20done=20=

>=20Disabling=20unused=20clock=20"wdt1_ick"...=20<6>=20done=20Disabling=20=

>=20unused=20clock=20"mpu_wdt_fck"...=20<6>=20done=20Disabling=20unused=20=
clock=20
>=20"mpu_wdt_ick"...=20<6>=20done=20Disabling=20unused=20clock=20
>=20"gpios_fck"...=20<6>=20done=20Disabling=20unused=20clock=20"gpios_ick"=
...=20
>=20<6>=20done=20Disabling=20unused=20clock=20"gpt2_fck"...=20<6>=20done=20=

>=20Disabling=20unused=20clock=20"gpt2_ick"...=20<6>=20done=20Disabling=20=

>=20unused=20clock=20"mdm_osc_ck"...=20<6>=20done=20Disabling=20unused=20c=
lock=20
>=20"iva2_1_fck"...=20<6>=20done=20Disabling=20unused=20clock=20
>=20"apll54_ck"...=20<6>=20done=20Built=201=20zonelists=20Kernel=20command=
=20
>=20line:=20mem=3D32M=20console=3DttyS0,115200n8=20noinitrd=20root=3D/dev/=
nfs=20
>=20ip=3Ddhcp=20PID=20hash=20table=20entries:=20256=20(order:=208,=204096=20=
bytes)=20
>=20OMAP=20GPTimer1=20hardware=20version=201.6=20OMAP=20GPTimer2=20hardwar=
e=20version=201.6
>=20Console:=20colour=20dummy=20device=2080x30
>=20Dentry=20cache=20hash=20table=20entries:=208192=20(order:=203,=2032768=
=20bytes)=20
>=20Inode-cache=20hash=20table=20entries:=204096=20(order:=202,=2016384=20=
bytes)
>=20Memory:=2032MB=20=3D=2032MB=20total
>=20Memory:=2029312KB=20available=20(2396K=20code,=20533K=20data,=20128K=20=
init)=20
>=20Mount-cache=20hash=20table=20entries:=20512=20(order:=200,=204096=20by=
tes)
>=20CPU:=20Testing=20write=20buffer=20coherency:=20ok
>=20spawn_desched_task(00000000)
>=20desched=20cpu_callback=203/00000000
>=20ksoftirqd=20started=20up.
>=20desched=20cpu_callback=202/00000000
>=20desched=20thread=200=20started=20up.
>=20NET:=20Registered=20protocol=20family=2016
>=20OMAP=20DMA4=20hardware=20Initialized=20(max=20lch=3D32)=20OMAP=20GPIO=20=

>=20hardware=20version=202.2=20OMAP=20virtual=20buses=20initialized
>=20map2_disp:=20timeout=20waiting=20for=20display=20controller=20reset=20=
OMAP=20
>=20Display=20hardware=20version=201.0=20Registering=20OMAP=20device=20
>=20'OMAP24xx=20I2C=2003'.=20Parent=20at=20L4CORE=20Registering=20OMAP=20d=
evice=20
>=20'OMAP24xx=20I2C=2013'.=20Parent=20at=20L4CORE=20TWL4030=20Power=20Comp=
anion=20Active
>=20TWL4030:=20Driver=20registration=20complete.
>=20SCSI=20subsystem=20initialized
>=20usbcore:=20registered=20new=20driver=20usbfs
>=20usbcore:=20registered=20new=20driver=20hub
>=20musb_hdrc:=20version=202.2a/db-0.4.8=20[musb-dma]=20[otg:=20
>=20peripheral+host]=20debug=3D0]
>=20usb_hdrc:=20USB=20OTG=20mode=20controller=20at=20c2800000=20using=20DM=
A,=20IRQ=20
>=2092=20musb_hdrc=20musb_hdrc.0:=20new=20USB=20bus=20registered,=20assign=
ed=20
>=20bus=20number=201=20memmap=201.1=20initialised=20OMAP24xx=20Dynamic=20P=
ower=20
>=20Management=20NetWinder=20Floating=20Point=20Emulator=20V0.97=20(double=
=20precision)
>=20JFFS2=20version=202.2.=20(NAND)=20(C)=202001-2003=20Red=20Hat,=20Inc.
>=20Registering=20OMAP=20device=20'sdp2430_lcd9'.=20Parent=20at=20L3=20
>=20Registering=20OMAP=20device=20'sdp2430_tv10'.=20Parent=20at=20L3=20
>=20Registering=20OMAP=20device=20'omap24xxfb6'.=20Parent=20at=20L3
>=20omap24xxfb:=20Options=20"<NULL>"
>=20Console:=20switching=20to=20colour=20frame=20buffer=20device=2030x40
>=20omap24xxfb:=20fb0=20frame=20buffer=20device
>=20omap24xxfb:=20display=20mode=20240x320x16=20hsync=2019kHz=20vsync=2058=
Hz
>=20omap_wdt:=20TI=20OMAP=20Watchdog=20Timer:=20timer=20margin=2010000=20s=
ec
>=20Serial:=208250/16550=20driver=20$Revision:=201.90=20$=204=20ports,=20I=
RQ=20
>=20sharing=20disabled=20ttyS0=20at=20MMIO=200x4806a000=20(irq=20=3D=2072)=
=20is=20a=20ST16654
>=20ttyS1=20at=20MMIO=200x4806c000=20(irq=20=3D=2073)=20is=20a=20ST16654
>=20ttyS2=20at=20MMIO=200x4806e000=20(irq=20=3D=2074)=20is=20a=20ST16654=20=
io=20scheduler=20
>=20noop=20registered=20io=20scheduler=20anticipatory=20registered=20io=20=

>=20scheduler=20deadline=20registered=20io=20scheduler=20cfq=20registered=20=

>=20RAMDISK=20driver=20initialized:=2016=20RAM=20disks=20of=208192K=20size=
=201024=20blocksize
>=20loop:=20loaded=20(max=208=20devices)
>=20OMAP=20Timer32K=20is=20initialized
>=20Registering=20OMAP=20device=20'omap-twl4030rtc16'.=20Parent=20at=20L4C=
ORE=20
>=20omap-twl4030rtc:TWL4030-RTC=20Power=20up=20reset=20detected.
>=20omap-twl4030rtc:Enabling=20TWL4030-RTC.
>=20smc91x:=20not=20found=20(-19).
>=20TWL4030=20GPIO=20Demux:=20IRQ=20Range=20264=20to=20273,=20Initializati=
on=20
>=20Success=20Linux=20video=20capture=20interface:=20v1.00=20Registering=20=
OMAP=20
>=20device=20'omap24xxcam0'.=20Parent=20at=20L3=20EX3691:Failed=20to=20det=
ect=20
>=20EX3691=20SOC.
>=20omap24xxcam:=20cannot=20initialize=20sensor
>=20Registering=20OMAP=20device=20'omap24xxvout111'.=20Parent=20at=20L3
>=20omap24xxvout:=20registered=20device=20video1=20[v4l2]=20Registering=20=

>=20OMAP=20device=20'omap24xxvout212'.=20Parent=20at=20L3
>=20omap24xxvout:=20registered=20device=20video2=20[v4l2]=20OMAP=20HDQ=20
>=20Hardware=20Revision=200.3.=20Driver=20in=20interrupt=20mode.
>=20elevator:=20using=20anticipatory=20as=20default=20io=20scheduler
>=20omapflash.1:=20Found=201=20x16=20devices=20at=200x0=20in=2016-bit=20ba=
nk
>=20omapflash.1:=20Found=201=20x16=20devices=20at=200x2000000=20in=2016-bi=
t=20bank=20=20
>=20Intel/Sharp=20Extended=20Query=20Table=20at=200x010A=20=20Intel/Sharp=20=

>=20Extended=20Query=20Table=20at=200x010A=20=20Intel/Sharp=20Extended=20Q=
uery=20
>=20Table=20at=200x010A=20=20Intel/Sharp=20Extended=20Query=20Table=20at=20=
0x010A=20=20
>=20Intel/Sharp=20Extended=20Query=20Table=20at=200x010A=20Using=20buffer=20=
write=20method
>=20cfi_cmdset_0001:=20Erase=20suspend=20on=20write=20enabled=20Creating=20=
4=20
>=20MTD=20partitions=20on=20"omapflash.1":
>=200x00000000-0x00040000=20:=20"(strata)=20bootloader"
>=200x00040000-0x00060000=20:=20"(strata)=20params"
>=200x00060000-0x00260000=20:=20"(strata)=20kernel"
>=200x00260000-0x04000000=20:=20"(strata)=20filesystem"
>=20omapflash:=20probe=20of=20omapflash.0=20failed=20with=20error=20-5
>=20NAND:=20Unable=20to=20find=20NAND=20settings=20in=20GPMC=20Configurati=
on=20-=20quitting
>=20mice:=20PS/2=20mouse=20device=20common=20for=20all=20mice=20Registerin=
g=20OMAP=20
>=20device=20'omap_twl4030keypad1'.=20Parent=20at=20L4CORE=20Registering=20=

>=20OMAP=20device=20'omap_tsc20468'.=20Parent=20at=20L4CORE=20Registering=20=

>=20OMAP=20device=20'omap2430-mmc12'.=20Parent=20at=20L3=20Registering=20O=
MAP=20
>=20device=20'omap2430-mmc217'.=20Parent=20at=20L3=20Registering=20OMAP=20=

>=20device=20'omap-audio7'.=20Parent=20at=20L3=20OMAP243X=20TWL4030=20Audi=
o=20
>=20Support:=20Chip=20Rev[0x2f]=20Initialized
>=20NET:=20Registered=20protocol=20family=202
>=20IP:=20routing=20cache=20hash=20table=20of=20512=20buckets,=204Kbytes
>=20TCP:=20Hash=20tables=20configured=20(established=202048=20bind=204096)=

>=20NET:=20Registered=20protocol=20family=201
>=20NET:=20Registered=20protocol=20family=2017
>=20VFP=20support=20v0.3:=20implementor=2041=20architecture=201=20part=202=
0=20
>=20variant=20b=20rev=202
>=20IP-Config:=20No=20network=20devices=20available.
>=20Root-NFS:=20No=20NFS=20server=20available,=20giving=20up.
>=20VFS:=20Unable=20to=20mount=20root=20fs=20via=20NFS,=20trying=20floppy.=

>=20VFS:=20Cannot=20open=20root=20device=20"nfs"=20or=20unknown-block(2,0)=
=20
>=20Please=20append=20a=20correct=20"root=3D"=20boot=20option=20Kernel=20p=
anic=20-=20
>=20not=20syncing:=20VFS:=20Unable=20to=20mount=20root=20fs=20on
>=20unknown-block(2,0)
>=20=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20=3D=3D=3D=3D
>=20
>=20
>=20
>=20thanks=20in=20advacne,
>=20eyal=20s.
>=20=20
>=20
>=20______________________________________________________________________=

>=20This=20email=20has=20been=20scanned=20by=20the=20MessageLabs=20Email=20=
Security=20System.
>=20For=20more=20information=20please=20visit=20
>=20http://www.messagelabs.com/email=20
>=20______________________________________________________________________=

>=20
>=20______________________________________________________________________=

>=20This=20email=20has=20been=20scanned=20by=20the=20MessageLabs=20Email=20=
Security=20System.
>=20For=20more=20information=20please=20visit=20
>=20http://www.messagelabs.com/email=20
>=20______________________________________________________________________=

>=20_______________________________________________
>=20Linux-omap-open-source=20mailing=20list
>=20Linux-omap-open-source@linux.omap.com
>=20http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20

______________________________________________________________________
This=20email=20has=20been=20scanned=20by=20the=20MessageLabs=20Email=20Sec=
urity=20System.
For=20more=20information=20please=20visit=20http://www.messagelabs.com/ema=
il=20
______________________________________________________________________
