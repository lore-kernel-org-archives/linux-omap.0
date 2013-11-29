From: Sourav Poddar <sourav.poddar@ti.com>
Subject: HDQ 1 Wire on AM43x
Date: Fri, 29 Nov 2013 11:41:25 +0530
Message-ID: <5298300D.4010304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52257 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296Ab3K2GL3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Nov 2013 01:11:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

I am trying to cleanup and use HDQ 1wire on AM43x with
3.12-rc6 kernel.

Slave device connected on my board  is DS18B20, for which I have
enabled the w1_therm.c driver. I populated the required hwmod entries and
the log obtained is inlined[1].

Is there any way to test this out?
In some older thread, I saw that there is some discussion on some
'hdq idle fixes' done to get the hdq working. ?

I see a lot of sys entires, but all looks to be the attributes and could 
not
figure out any slave where I can 'cat' the temperature data.

Do I need to enable anything more apart from what my below configs looks 
like:
#
CONFIG_W1=y
CONFIG_W1_CON=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_DS2490 is not set
# CONFIG_W1_MASTER_DS2482 is not set
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_HDQ_MASTER_OMAP=y

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y

Thanks,
Sourav

[1]:

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.12.0-67367-g2d1978c-dirty 
(a0131647@a0131647) (gcc version 4.7.3 20130226 (prerelease) 
(crosstool-NG linaro-1.13.1-4.7-2013.03
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), 
cr=10c53c7d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing 
instruction cache
[    0.000000] Machine: Generic AM43 (Flattened Device Tree), model: TI 
AM43x EPOS EVM
[    0.000000] cma: CMA: reserved 16 MiB at 9e800000
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] AM437x ES1.0 (sgx neon )
[    0.000000] PERCPU: Embedded 9 pages/cpu @c12c9000 s14656 r8192 
d14016 u36864
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  
Total pages: 129280
[    0.000000] Kernel command line: root=/dev/ram0 rw mem=512M 
console=ttyO0,115200n8 initrd=0x82000000,20M ramdisk_size=20480 
no_console_suspend
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 
bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 
bytes)
[    0.000000] Memory: 464604K/521216K available (6012K kernel code, 
690K rwdata, 2340K rodata, 426K init, 5536K bss, 56612K reserved, 0K 
highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff000000   ( 488 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc083058c   (8354 kB)
[    0.000000]       .init : 0xc0831000 - 0xc089b940   ( 427 kB)
[    0.000000]       .data : 0xc089c000 - 0xc0948b20   ( 691 kB)
[    0.000000]        .bss : 0xc0948b20 - 0xc0eb0f00   (5537 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=2 to nr_cpu_ids=1.
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] GIC CPU mask not found - kernel will fail to boot.
[    0.000000] GIC CPU mask not found - kernel will fail to boot.
[    0.000000] OMAP clockevent source: timer1 at 32786 Hz
[    0.000000] sched_clock: 32 bits at 32kHz, resolution 30517ns, wraps 
every 131071999ms
[    0.000000] OMAP clocksource: 32k_counter at 32768 Hz
[    0.000000] Console: colour dummy device 80x30

.....

[    2.861450] Driver for 1-wire Dallas network protocol.
[    2.878417] omap_hdq 48347000.hdq: OMAP HDQ Hardware Rev 0.:. Driver 
in Interrupt mode
[    3.250061] w1_master_driver w1_bus_master1: Family 1 for 
01.000000000000.3d is not registered.

[    3.262054] omap_wdt: OMAP Watchdog Timer Rev 0x01: initial timeout 
60 sec
[    3.275054] edma-dma-engine edma-dma-engine.0: allocated channel for 0:25
[    3.282073] edma-dma-engine edma-dma-engine.0: allocated channel for 0:24
[    3.336029] ledtrig-cpu: registered to indicate activity on CPUs
[    3.342712] edma-dma-engine edma-dma-engine.0: allocated channel for 0:36
[    3.349639] omap-sham 53100000.sham: hw accel on OMAP rev 0.0
[    3.364746] omap-aes 53501000.aes: OMAP AES hw accel rev: 0.1
[    3.370758] edma-dma-engine edma-dma-engine.0: allocated channel for 0:5

......

[    3.675811] platform connector.6: Driver connector-hdmi requests 
probe deferral
[    3.687438] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    3.712982] RAMDISK: ext2 filesystem found at block 0
[    3.718017] RAMDISK: Loading 15360KiB [1 disk] into ram disk... [    
3.724517] connector-hdmi connector.6: failed to find video source
[    3.730957] platform connector.6: Driver connector-hdmi requests 
probe deferral
done.
[    4.392822] EXT2-fs (ram0): warning: mounting unchecked fs, running 
e2fsck is recommended
[    4.401641] VFS: Mounted root (ext2 filesystem) on device 1:0.
[    4.408569] devtmpfs: mounted
[    4.412353] Freeing unused kernel memory: 424K (c0831000 - c089b000)
Mounting proc : OK
Mounting sysfs : OK
Mounting /dev : OK
Creating local mdev devices
umount: can't umount /mnt/mmc: Invalid argument

***********************************************
Starting System Init for: Generic AM43 (Flattened Device Tree)
Release: 3.12.0-67367-g2d1978c-dirty
***********************************************
Saving kernel ring buffer : OK
Mounting devpts : OK
Setting up networking
Configuring lo : OK
Configuring eth0 : ifup: can't open '/etc/network/interfaces': No such 
file or directory
Failed
Starting syslogd : OK
Starting klogd : OK
Mounting filesystems : OK
Mounting Debug filesystem : OK

Please press Enter to activate this console.
/ #
/ # cd /
/ #
/ #
/ # cd /sys/bus/
/sys/bus # ls
clockevents   event_source  mdio_bus      scsi          soc           w1
clocksource   hid           mmc           sdio          spi           
workqueue
cpu           i2c           platform      serio         usb
/sys/bus # cd w1/
/sys/bus/w1 # ls
devices            drivers_autoprobe  uevent
drivers            drivers_probe
/sys/bus/w1 # cd devices/
/sys/bus/w1/devices # ls
01-000000000000  w1_bus_master1
/sys/bus/w1/devices # cd w1_bus_master1/
/sys/devices/w1_bus_master1 # ls
01-000000000000            w1_master_attempts         w1_master_search
driver                     w1_master_max_slave_count  w1_master_slave_count
power                      w1_master_name             w1_master_slaves
subsystem                  w1_master_pointer          w1_master_timeout
uevent                     w1_master_pullup
w1_master_add              w1_master_remove
/sys/devices/w1_bus_master1 # cd ..
/sys/bus/w1/devices # ls
01-000000000000  w1_bus_master1
/sys/bus/w1/devices # cd ..
/sys/bus/w1 # ls
devices            drivers_autoprobe  uevent
drivers            drivers_probe
/sys/bus/w1 # cd drivers/
/sys/bus/w1/drivers # ls
w1_master_driver  w1_slave_driver
/sys/bus/w1/drivers # cd w1_master_driver/
/sys/bus/w1/drivers/w1_master_driver # ls
bind            uevent          unbind          w1_bus_master1
/sys/bus/w1/drivers/w1_master_driver # cd w1_bus_master1/
/sys/devices/w1_bus_master1 # ls
01-000000000000            w1_master_attempts         w1_master_search
driver                     w1_master_max_slave_count  w1_master_slave_count
power                      w1_master_name             w1_master_slaves
subsystem                  w1_master_pointer          w1_master_timeout
uevent                     w1_master_pullup
w1_master_add              w1_master_remove
/sys/devices/w1_bus_master1 # cd ..
/sys/bus/w1/drivers/w1_master_driver # cd ..
/sys/bus/w1/drivers # ls
w1_master_driver  w1_slave_driver
/sys/bus/w1/drivers # cd w1_slave_driver/
/sys/bus/w1/drivers/w1_slave_driver # ls
01-000000000000  bind             uevent           unbind
/sys/bus/w1/drivers/w1_slave_driver # cd 01-000000000000/
/sys/devices/w1_bus_master1/01-000000000000 # ls
driver     id         name       power      rw         subsystem  uevent
/sys/devices/w1_bus_master1/01-000000000000 #
/sys/devices/w1_bus_master1/01-000000000000 #
/sys/devices/w1_bus_master1/01-000000000000 # cd ..
/sys/bus/w1/drivers/w1_slave_driver # cd
/ # cd /sys/class/
/sys/class # ls
ata_device    extcon        input         mmc_host      rtc           ubi
ata_link      firmware      lcd           mtd           scsi_device   udc
ata_port      gpio          leds          net           scsi_disk     usbmon
backlight     graphics      mbox          phy           scsi_host     vc
bdi           hwmon         mdio_bus      power_supply  spi_master    
vtconsole
block         i2c-adapter   mem           pwm           thermal       
watchdog
dma           i2c-dev       misc          regulator     tty
/sys/class # cd ..
/sys # cd ..
/ #



