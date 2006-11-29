From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: TI 2430 MontaVista Kernel 2.6 Mobilinux - eth smc device
	notfound
Date: Wed, 29 Nov 2006 07:53:44 -0600
Message-ID: <EA12F909C0431D458B9D18A176BEE4A508C2464E@dlee02.ent.ti.com>
References: <13ECC251745F8F4BA0076A980813C7C29AF974@msl-ex02.corp.m-sys.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <13ECC251745F8F4BA0076A980813C7C29AF974@msl-ex02.corp.m-sys.com>
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

Hello Eyal,

If you have proper access to a MV kernel they should be able to help you
through.  I would expect there is some configuration error.

* My first guess based on your symptoms is you have a GPMC timing
mismatch between the u-boot on your board and the target speed as
defined in your kernel.  AFAIK in that build you need to have the
'fastest' u-boot to support kernels of other speeds.  There is not
currently a re-program of the GPMC timings.  You need to have a "PRCM
#2" built u-boot to work across the target clock speeds.

* What version of SDP board do you have?  Where did you get the u-boot
binary on your board?  As you did not provide the u-boot startup banner
its not obvious which u-boot you have on your board and the speed it is
set for.

* What is the problem in rebuilding a kernel from the TI builds?  They
should work... if not we will fix them.

The only time in recent kernels I have seen anything like you describe
is with bad hardware or mis-configured clocks.

Regards,
Richard W.=20

> -----Original Message-----
> From:=20
> linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linux.omap.c
> om=20
> [mailto:linux-omap-open-source-bounces+r-woodruff2=3Dti.com@linu
> x.omap.com] On Behalf Of Eyal Shani
> Sent: Wednesday, November 29, 2006 7:16 AM
> To: linux-omap-open-source@linux.omap.com
> Cc: Eyal Shani
> Subject: RE: TI 2430 MontaVista Kernel 2.6 Mobilinux - eth=20
> smc device notfound
>=20
> hi guys,
>=20
> Using MontaVista Mobilinux 4.1 for TI OMAP 2430 SDP.
> I am receiving the below PANIC while initializing the kernel=20
> from TFTP on the 2430 OMAP platform.
>=20
> The NETWORK CARD init code, smc91x is not finding the device -
> 'smc91x: not found (-19)'.
> The output is 'No network devices available' - from IP-CONFIG.=20
>=20
> This is a brand new kernel, that cannot jump start the=20
> platform for the first time.
>=20
> I have carried out some more debugging and found the following:
>=20
> from kernel init flow, after adding some prints into the=20
> smc91x.c code:
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> :
> :
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> loop: loaded (max 8 devices)
> before smc_probe::EYAL smc91x: ioaddr=3D0xc2864300
> smc91x: smc_probe
> smc91x: ioaddr=3D0xc2864300
> smc91x: bank signature probe returned 0x0187
> smc91x: not found (-19).
> :
> :
>=20
>=20
> Mind u:
> 1. I have ruled out a HW issue on the smc onboard card - The=20
> uImage for
> 2430 	2.6 kernel binary from TI identifies the ETH0 device, so it is
> not an 	HW issue. Alas, I cannot use that kernel, since=20
> I cannot compile
> it...
> 2. The OneNand is not recognized, since I pulled up it's CS - this is
> not 	the issue.
>=20
> Original U-boot TFTP & Kernel init flow output::
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> OMAP243X SDP # bootm
> ## Booting image at 80000000 ...
>    Image Name:   Linux-2.6.10_mobilinux410-omap24
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    1401456 Bytes =3D  1.3 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
> OK
> Starting kernel ...
> =20
> Uncompressing
> Linux.............................................................
> ................................. done, booting the kernel.
> Linux version 2.6.10_mobilinux410-omap2430_sdp
> (root@localhost.localdomain) (gcc
>=20
>  version 3.4.3 (MontaVista 3.4.3-25.0.109.0601319=20
> 2006-08-20)) #5 Tue Nov 21 17:
>=20
> 41:06 IST 2006
> CPU: TI OMAP2430 (ARM1136JF-S) [4107b362] revision 2 (ARMv6TEJ)
> CPU0: D VIPT write-back cache
> CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
> CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
> Machine: OMAP24xx 2430SDP
> Memory policy: ECC disabled, Data cache writeback Power=20
> Management for TI OMAP.
> Clocking rate (xtal/DPLL/MPU): 13.0/660/330 MHz
> clock.c: Enable for dpll_ck without enable code Disabling=20
> unused clock "i2chs2_fck"... <6> done Disabling unused clock=20
> "i2c2_ick"... <6> done Disabling unused clock "i2chs1_fck"...=20
> <6> done Disabling unused clock "i2c1_ick"... <6> done=20
> Disabling unused clock "wdt1_ick"... <6> done Disabling=20
> unused clock "mpu_wdt_fck"... <6> done Disabling unused clock=20
> "mpu_wdt_ick"... <6> done Disabling unused clock=20
> "gpios_fck"... <6> done Disabling unused clock "gpios_ick"...=20
> <6> done Disabling unused clock "gpt2_fck"... <6> done=20
> Disabling unused clock "gpt2_ick"... <6> done Disabling=20
> unused clock "mdm_osc_ck"... <6> done Disabling unused clock=20
> "iva2_1_fck"... <6> done Disabling unused clock=20
> "apll54_ck"... <6> done Built 1 zonelists Kernel command=20
> line: mem=3D32M console=3DttyS0,115200n8 noinitrd root=3D/dev/nfs=20
> ip=3Ddhcp PID hash table entries: 256 (order: 8, 4096 bytes)=20
> OMAP GPTimer1 hardware version 1.6 OMAP GPTimer2 hardware version 1.6
> Console: colour dummy device 80x30
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)=20
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 32MB =3D 32MB total
> Memory: 29312KB available (2396K code, 533K data, 128K init)=20
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> CPU: Testing write buffer coherency: ok
> spawn_desched_task(00000000)
> desched cpu_callback 3/00000000
> ksoftirqd started up.
> desched cpu_callback 2/00000000
> desched thread 0 started up.
> NET: Registered protocol family 16
> OMAP DMA4 hardware Initialized (max lch=3D32) OMAP GPIO=20
> hardware version 2.2 OMAP virtual buses initialized
> map2_disp: timeout waiting for display controller reset OMAP=20
> Display hardware version 1.0 Registering OMAP device=20
> 'OMAP24xx I2C 03'. Parent at L4CORE Registering OMAP device=20
> 'OMAP24xx I2C 13'. Parent at L4CORE TWL4030 Power Companion Active
> TWL4030: Driver registration complete.
> SCSI subsystem initialized
> usbcore: registered new driver usbfs
> usbcore: registered new driver hub
> musb_hdrc: version 2.2a/db-0.4.8 [musb-dma] [otg:=20
> peripheral+host] debug=3D0]
> usb_hdrc: USB OTG mode controller at c2800000 using DMA, IRQ=20
> 92 musb_hdrc musb_hdrc.0: new USB bus registered, assigned=20
> bus number 1 memmap 1.1 initialised OMAP24xx Dynamic Power=20
> Management NetWinder Floating Point Emulator V0.97 (double precision)
> JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
> Registering OMAP device 'sdp2430_lcd9'. Parent at L3=20
> Registering OMAP device 'sdp2430_tv10'. Parent at L3=20
> Registering OMAP device 'omap24xxfb6'. Parent at L3
> omap24xxfb: Options "<NULL>"
> Console: switching to colour frame buffer device 30x40
> omap24xxfb: fb0 frame buffer device
> omap24xxfb: display mode 240x320x16 hsync 19kHz vsync 58Hz
> omap_wdt: TI OMAP Watchdog Timer: timer margin 10000 sec
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ=20
> sharing disabled ttyS0 at MMIO 0x4806a000 (irq =3D 72) is a ST16654
> ttyS1 at MMIO 0x4806c000 (irq =3D 73) is a ST16654
> ttyS2 at MMIO 0x4806e000 (irq =3D 74) is a ST16654 io scheduler=20
> noop registered io scheduler anticipatory registered io=20
> scheduler deadline registered io scheduler cfq registered=20
> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> loop: loaded (max 8 devices)
> OMAP Timer32K is initialized
> Registering OMAP device 'omap-twl4030rtc16'. Parent at L4CORE=20
> omap-twl4030rtc:TWL4030-RTC Power up reset detected.
> omap-twl4030rtc:Enabling TWL4030-RTC.
> smc91x: not found (-19).
> TWL4030 GPIO Demux: IRQ Range 264 to 273, Initialization=20
> Success Linux video capture interface: v1.00 Registering OMAP=20
> device 'omap24xxcam0'. Parent at L3 EX3691:Failed to detect=20
> EX3691 SOC.
> omap24xxcam: cannot initialize sensor
> Registering OMAP device 'omap24xxvout111'. Parent at L3
> omap24xxvout: registered device video1 [v4l2] Registering=20
> OMAP device 'omap24xxvout212'. Parent at L3
> omap24xxvout: registered device video2 [v4l2] OMAP HDQ=20
> Hardware Revision 0.3. Driver in interrupt mode.
> elevator: using anticipatory as default io scheduler
> omapflash.1: Found 1 x16 devices at 0x0 in 16-bit bank
> omapflash.1: Found 1 x16 devices at 0x2000000 in 16-bit bank =20
> Intel/Sharp Extended Query Table at 0x010A  Intel/Sharp=20
> Extended Query Table at 0x010A  Intel/Sharp Extended Query=20
> Table at 0x010A  Intel/Sharp Extended Query Table at 0x010A =20
> Intel/Sharp Extended Query Table at 0x010A Using buffer write method
> cfi_cmdset_0001: Erase suspend on write enabled Creating 4=20
> MTD partitions on "omapflash.1":
> 0x00000000-0x00040000 : "(strata) bootloader"
> 0x00040000-0x00060000 : "(strata) params"
> 0x00060000-0x00260000 : "(strata) kernel"
> 0x00260000-0x04000000 : "(strata) filesystem"
> omapflash: probe of omapflash.0 failed with error -5
> NAND: Unable to find NAND settings in GPMC Configuration - quitting
> mice: PS/2 mouse device common for all mice Registering OMAP=20
> device 'omap_twl4030keypad1'. Parent at L4CORE Registering=20
> OMAP device 'omap_tsc20468'. Parent at L4CORE Registering=20
> OMAP device 'omap2430-mmc12'. Parent at L3 Registering OMAP=20
> device 'omap2430-mmc217'. Parent at L3 Registering OMAP=20
> device 'omap-audio7'. Parent at L3 OMAP243X TWL4030 Audio=20
> Support: Chip Rev[0x2f] Initialized
> NET: Registered protocol family 2
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 2048 bind 4096)
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> VFP support v0.3: implementor 41 architecture 1 part 20=20
> variant b rev 2
> IP-Config: No network devices available.
> Root-NFS: No NFS server available, giving up.
> VFS: Unable to mount root fs via NFS, trying floppy.
> VFS: Cannot open root device "nfs" or unknown-block(2,0)=20
> Please append a correct "root=3D" boot option Kernel panic -=20
> not syncing: VFS: Unable to mount root fs on
> unknown-block(2,0)
> =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D
>=20
>=20
>=20
> thanks in advacne,
> eyal s.
> =20
>=20
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit=20
> http://www.messagelabs.com/email=20
> ______________________________________________________________________
>=20
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit=20
> http://www.messagelabs.com/email=20
> ______________________________________________________________________
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>=20
