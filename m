From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: omap1710 h3: problem while accessing audio device
Date: Tue, 9 Jan 2007 04:21:13 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470C5861@dlee13.ent.ti.com>
References: <7b1b9c8b0701082322v2c927378u2a3d50a21fff2400@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <7b1b9c8b0701082322v2c927378u2a3d50a21fff2400@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Prashant <prashantkhoje@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I think this is because we are on udev now. The FS needs a udev script
that creates device nodes. This might be missing in this FS.

Regards,
Khasim

> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-
> open-source-bounces@linux.omap.com] On Behalf Of Prashant
> Sent: Tuesday, January 09, 2007 1:23 AM
> To: linux-omap-open-source@linux.omap.com
> Subject: omap1710 h3: problem while accessing audio device
>=20
> Hi All,
> I am using NFS with linux kernel 2.6.19.
> I set bootargs to "console=3DttyS0,115200n8 noinitrd rw ip=3Ddhcp
> root=3D/dev/nfs
nfsroot=3D172.25.0.107:/home/pkhoje/omap1710/rootfs/,nolock
> mem=3D32M devfs=3Dmount".
>=20
> When I run command, "cat /dev/sound/dsp > /dev/sound/dsp"; kernel
> prints that no such device is available. But I see such a node being
> present in the filesystem.
>=20
> # ls -l /dev/sound/dsp
> crw-r--r--    1 root     root      14,   3 Dec  4  2006 /dev/sound/dsp
>=20
> I have downloaded NFS from
> http://linux.omap.com/pub/filesystem/rootfs.tar.bz2. It seems to work
> fine with 2.6.11 which I was using earlier. I see various devices
> created in /dev with 2.6.11. But I dont see all such devices created
> with 2.6.19. There's only console, tty, ttyS0, and sound/dsp in case
> of 2.6.19.
>=20
> Any help in this regard will be helpful.
>=20
> My kernel config file is as follows:
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.19-omap1
> # Sat Jan  6 17:04:34 2007
> #
> CONFIG_ARM=3Dy
> # CONFIG_GENERIC_TIME is not set
> CONFIG_MMU=3Dy
> CONFIG_GENERIC_HARDIRQS=3Dy
> CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> CONFIG_HARDIRQS_SW_RESEND=3Dy
> CONFIG_GENERIC_IRQ_PROBE=3Dy
> CONFIG_RWSEM_GENERIC_SPINLOCK=3Dy
> CONFIG_GENERIC_HWEIGHT=3Dy
> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> CONFIG_VECTORS_BASE=3D0xffff0000
> CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
>=20
> #
> # Code maturity level options
> #
> CONFIG_EXPERIMENTAL=3Dy
> CONFIG_BROKEN_ON_SMP=3Dy
> CONFIG_LOCK_KERNEL=3Dy
> CONFIG_INIT_ENV_ARG_LIMIT=3D32
>=20
> #
> # General setup
> #
> CONFIG_LOCALVERSION=3D""
> CONFIG_LOCALVERSION_AUTO=3Dy
> CONFIG_SWAP=3Dy
> CONFIG_SYSVIPC=3Dy
> # CONFIG_IPC_NS is not set
> # CONFIG_POSIX_MQUEUE is not set
> # CONFIG_BSD_PROCESS_ACCT is not set
> # CONFIG_TASKSTATS is not set
> # CONFIG_UTS_NS is not set
> # CONFIG_AUDIT is not set
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> # CONFIG_RELAY is not set
> CONFIG_INITRAMFS_SOURCE=3D""
> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
> CONFIG_SYSCTL=3Dy
> # CONFIG_EMBEDDED is not set
> CONFIG_UID16=3Dy
> CONFIG_SYSCTL_SYSCALL=3Dy
> CONFIG_KALLSYMS=3Dy
> # CONFIG_KALLSYMS_ALL is not set
> # CONFIG_KALLSYMS_EXTRA_PASS is not set
> CONFIG_HOTPLUG=3Dy
> CONFIG_PRINTK=3Dy
> CONFIG_BUG=3Dy
> CONFIG_ELF_CORE=3Dy
> CONFIG_BASE_FULL=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_SLAB=3Dy
> CONFIG_VM_EVENT_COUNTERS=3Dy
> CONFIG_RT_MUTEXES=3Dy
> # CONFIG_TINY_SHMEM is not set
> CONFIG_BASE_SMALL=3D0
> # CONFIG_SLOB is not set
>=20
> #
> # Loadable module support
> #
> CONFIG_MODULES=3Dy
> CONFIG_MODULE_UNLOAD=3Dy
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_KMOD is not set
>=20
> #
> # Block layer
> #
> CONFIG_BLOCK=3Dy
> # CONFIG_BLK_DEV_IO_TRACE is not set
>=20
> #
> # IO Schedulers
> #
> CONFIG_IOSCHED_NOOP=3Dy
> CONFIG_IOSCHED_AS=3Dy
> CONFIG_IOSCHED_DEADLINE=3Dy
> CONFIG_IOSCHED_CFQ=3Dy
> # CONFIG_DEFAULT_AS is not set
> # CONFIG_DEFAULT_DEADLINE is not set
> CONFIG_DEFAULT_CFQ=3Dy
> # CONFIG_DEFAULT_NOOP is not set
> CONFIG_DEFAULT_IOSCHED=3D"cfq"
>=20
> #
> # System Type
> #
> # CONFIG_ARCH_AAEC2000 is not set
> # CONFIG_ARCH_INTEGRATOR is not set
> # CONFIG_ARCH_REALVIEW is not set
> # CONFIG_ARCH_VERSATILE is not set
> # CONFIG_ARCH_AT91 is not set
> # CONFIG_ARCH_CLPS7500 is not set
> # CONFIG_ARCH_CLPS711X is not set
> # CONFIG_ARCH_CO285 is not set
> # CONFIG_ARCH_EBSA110 is not set
> # CONFIG_ARCH_EP93XX is not set
> # CONFIG_ARCH_FOOTBRIDGE is not set
> # CONFIG_ARCH_NETX is not set
> # CONFIG_ARCH_H720X is not set
> # CONFIG_ARCH_IMX is not set
> # CONFIG_ARCH_IOP32X is not set
> # CONFIG_ARCH_IOP33X is not set
> # CONFIG_ARCH_IXP4XX is not set
> # CONFIG_ARCH_IXP2000 is not set
> # CONFIG_ARCH_IXP23XX is not set
> # CONFIG_ARCH_L7200 is not set
> # CONFIG_ARCH_PNX4008 is not set
> # CONFIG_ARCH_PXA is not set
> # CONFIG_ARCH_RPC is not set
> # CONFIG_ARCH_SA1100 is not set
> # CONFIG_ARCH_S3C2410 is not set
> # CONFIG_ARCH_SHARK is not set
> # CONFIG_ARCH_LH7A40X is not set
> CONFIG_ARCH_OMAP=3Dy
>=20
> #
> # TI OMAP Implementations
> #
> CONFIG_ARCH_OMAP_OTG=3Dy
> CONFIG_ARCH_OMAP1=3Dy
> # CONFIG_ARCH_OMAP2 is not set
>=20
> #
> # OMAP Feature Selections
> #
> # CONFIG_OMAP_RESET_CLOCKS is not set
> # CONFIG_OMAP_BOOT_TAG is not set
> # CONFIG_OMAP_GPIO_SWITCH is not set
> CONFIG_OMAP_MUX=3Dy
> # CONFIG_OMAP_MUX_DEBUG is not set
> CONFIG_OMAP_MUX_WARNINGS=3Dy
> # CONFIG_OMAP_STI is not set
> CONFIG_OMAP_MCBSP=3Dy
> CONFIG_OMAP_MPU_TIMER=3Dy
> # CONFIG_OMAP_32K_TIMER is not set
> # CONFIG_OMAP_DM_TIMER is not set
> CONFIG_OMAP_LL_DEBUG_UART1=3Dy
> # CONFIG_OMAP_LL_DEBUG_UART2 is not set
> # CONFIG_OMAP_LL_DEBUG_UART3 is not set
> CONFIG_OMAP_SERIAL_WAKE=3Dy
> # CONFIG_OMAP_DSP is not set
>=20
> #
> # OMAP Core Type
> #
> # CONFIG_ARCH_OMAP730 is not set
> # CONFIG_ARCH_OMAP15XX is not set
> CONFIG_ARCH_OMAP16XX=3Dy
>=20
> #
> # OMAP Board Type
> #
> # CONFIG_MACH_OMAP_INNOVATOR is not set
> # CONFIG_MACH_OMAP_H2 is not set
> CONFIG_MACH_OMAP_H3=3Dy
> # CONFIG_MACH_OMAP_OSK is not set
> # CONFIG_MACH_NOKIA770 is not set
> # CONFIG_MACH_OMAP_GENERIC is not set
>=20
> #
> # OMAP CPU Speed
> #
> # CONFIG_OMAP_CLOCKS_SET_BY_BOOTLOADER is not set
> CONFIG_OMAP_ARM_216MHZ=3Dy
> # CONFIG_OMAP_ARM_192MHZ is not set
> # CONFIG_OMAP_ARM_168MHZ is not set
> # CONFIG_OMAP_ARM_120MHZ is not set
> # CONFIG_OMAP_ARM_60MHZ is not set
> # CONFIG_OMAP_ARM_30MHZ is not set
>=20
> #
> # Processor Type
> #
> CONFIG_CPU_32=3Dy
> CONFIG_CPU_ARM926T=3Dy
> CONFIG_CPU_32v5=3Dy
> CONFIG_CPU_ABRT_EV5TJ=3Dy
> CONFIG_CPU_CACHE_VIVT=3Dy
> CONFIG_CPU_COPY_V4WB=3Dy
> CONFIG_CPU_TLB_V4WBI=3Dy
> CONFIG_CPU_CP15=3Dy
> CONFIG_CPU_CP15_MMU=3Dy
>=20
> #
> # Processor Features
> #
> CONFIG_ARM_THUMB=3Dy
> # CONFIG_CPU_ICACHE_DISABLE is not set
> # CONFIG_CPU_DCACHE_DISABLE is not set
> # CONFIG_CPU_DCACHE_WRITETHROUGH is not set
> # CONFIG_CPU_CACHE_ROUND_ROBIN is not set
>=20
> #
> # Bus support
> #
>=20
> #
> # PCCARD (PCMCIA/CardBus) support
> #
> # CONFIG_PCCARD is not set
>=20
> #
> # Kernel Features
> #
> CONFIG_PREEMPT=3Dy
> # CONFIG_NO_IDLE_HZ is not set
> CONFIG_HZ=3D100
> CONFIG_AEABI=3Dy
> CONFIG_OABI_COMPAT=3Dy
> # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
> CONFIG_SELECT_MEMORY_MODEL=3Dy
> CONFIG_FLATMEM_MANUAL=3Dy
> # CONFIG_DISCONTIGMEM_MANUAL is not set
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_FLATMEM=3Dy
> CONFIG_FLAT_NODE_MEM_MAP=3Dy
> # CONFIG_SPARSEMEM_STATIC is not set
> CONFIG_SPLIT_PTLOCK_CPUS=3D4096
> # CONFIG_RESOURCES_64BIT is not set
> CONFIG_LEDS=3Dy
> # CONFIG_LEDS_TIMER is not set
> # CONFIG_LEDS_CPU is not set
> CONFIG_ALIGNMENT_TRAP=3Dy
>=20
> #
> # Boot options
> #
> CONFIG_ZBOOT_ROM_TEXT=3D0x10C08000
> CONFIG_ZBOOT_ROM_BSS=3D0x10200000
> # CONFIG_ZBOOT_ROM is not set
> CONFIG_CMDLINE=3D"mem=3D32M console=3DttyS0,115200n8 =
initrd=3D0x10A00000,8M
> root=3D/dev/ram0 rw ip=3Ddhcp devfs=3Dmount"
> # CONFIG_XIP_KERNEL is not set
>=20
> #
> # CPU Frequency scaling
> #
> # CONFIG_CPU_FREQ is not set
>=20
> #
> # Floating point emulation
> #
>=20
> #
> # At least one emulation must be selected
> #
> CONFIG_FPE_NWFPE=3Dy
> # CONFIG_FPE_NWFPE_XP is not set
> # CONFIG_FPE_FASTFPE is not set
> # CONFIG_VFP is not set
>=20
> #
> # Userspace binary formats
> #
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_BINFMT_AOUT=3Dy
> # CONFIG_BINFMT_MISC is not set
>=20
> #
> # Power management options
> #
> CONFIG_PM=3Dy
> CONFIG_PM_LEGACY=3Dy
> # CONFIG_PM_DEBUG is not set
> # CONFIG_PM_SYSFS_DEPRECATED is not set
> # CONFIG_APM is not set
>=20
> #
> # Networking
> #
> CONFIG_NET=3Dy
>=20
> #
> # Networking options
> #
> # CONFIG_NETDEBUG is not set
> CONFIG_PACKET=3Dy
> # CONFIG_PACKET_MMAP is not set
> CONFIG_UNIX=3Dy
> CONFIG_XFRM=3Dy
> # CONFIG_XFRM_USER is not set
> # CONFIG_XFRM_SUB_POLICY is not set
> # CONFIG_NET_KEY is not set
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> # CONFIG_IP_ADVANCED_ROUTER is not set
> CONFIG_IP_FIB_HASH=3Dy
> CONFIG_IP_PNP=3Dy
> CONFIG_IP_PNP_DHCP=3Dy
> CONFIG_IP_PNP_BOOTP=3Dy
> # CONFIG_IP_PNP_RARP is not set
> # CONFIG_NET_IPIP is not set
> # CONFIG_NET_IPGRE is not set
> # CONFIG_IP_MROUTE is not set
> # CONFIG_ARPD is not set
> # CONFIG_SYN_COOKIES is not set
> # CONFIG_INET_AH is not set
> # CONFIG_INET_ESP is not set
> # CONFIG_INET_IPCOMP is not set
> # CONFIG_INET_XFRM_TUNNEL is not set
> # CONFIG_INET_TUNNEL is not set
> CONFIG_INET_XFRM_MODE_TRANSPORT=3Dy
> CONFIG_INET_XFRM_MODE_TUNNEL=3Dy
> CONFIG_INET_XFRM_MODE_BEET=3Dy
> CONFIG_INET_DIAG=3Dy
> CONFIG_INET_TCP_DIAG=3Dy
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=3Dy
> CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> # CONFIG_IPV6 is not set
> # CONFIG_INET6_XFRM_TUNNEL is not set
> # CONFIG_INET6_TUNNEL is not set
> # CONFIG_NETWORK_SECMARK is not set
> # CONFIG_NETFILTER is not set
>=20
> #
> # DCCP Configuration (EXPERIMENTAL)
> #
> # CONFIG_IP_DCCP is not set
>=20
> #
> # SCTP Configuration (EXPERIMENTAL)
> #
> # CONFIG_IP_SCTP is not set
>=20
> #
> # TIPC Configuration (EXPERIMENTAL)
> #
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_BRIDGE is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_IPX is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_ECONET is not set
> # CONFIG_WAN_ROUTER is not set
>=20
> #
> # QoS and/or fair queueing
> #
> # CONFIG_NET_SCHED is not set
>=20
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> # CONFIG_HAMRADIO is not set
> CONFIG_IRDA=3Dy
>=20
> #
> # IrDA protocols
> #
> # CONFIG_IRLAN is not set
> # CONFIG_IRNET is not set
> # CONFIG_IRCOMM is not set
> # CONFIG_IRDA_ULTRA is not set
>=20
> #
> # IrDA options
> #
> # CONFIG_IRDA_CACHE_LAST_LSAP is not set
> # CONFIG_IRDA_FAST_RR is not set
> # CONFIG_IRDA_DEBUG is not set
>=20
> #
> # Infrared-port device drivers
> #
>=20
> #
> # SIR device drivers
> #
> # CONFIG_IRTTY_SIR is not set
>=20
> #
> # Dongle support
> #
>=20
> #
> # Old SIR device drivers
> #
> # CONFIG_IRPORT_SIR is not set
>=20
> #
> # Old Serial dongle support
> #
>=20
> #
> # FIR device drivers
> #
> # CONFIG_OMAP_IR is not set
> # CONFIG_BT is not set
> # CONFIG_IEEE80211 is not set
>=20
> #
> # Device Drivers
> #
>=20
> #
> # Generic Driver Options
> #
> CONFIG_STANDALONE=3Dy
> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
> # CONFIG_FW_LOADER is not set
> CONFIG_DEBUG_DRIVER=3Dy
> # CONFIG_SYS_HYPERVISOR is not set
>=20
> #
> # Connector - unified userspace <-> kernelspace linker
> #
> # CONFIG_CONNECTOR is not set
>=20
> #
> # Memory Technology Devices (MTD)
> #
> CONFIG_MTD=3Dy
> # CONFIG_MTD_DEBUG is not set
> CONFIG_MTD_CONCAT=3Dy
> CONFIG_MTD_PARTITIONS=3Dy
> # CONFIG_MTD_REDBOOT_PARTS is not set
> CONFIG_MTD_CMDLINE_PARTS=3Dy
> # CONFIG_MTD_AFS_PARTS is not set
>=20
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_CHAR=3Dy
> CONFIG_MTD_BLOCK=3Dy
> # CONFIG_FTL is not set
> # CONFIG_NFTL is not set
> # CONFIG_INFTL is not set
> # CONFIG_RFD_FTL is not set
> # CONFIG_SSFDC is not set
>=20
> #
> # RAM/ROM/Flash chip drivers
> #
> CONFIG_MTD_CFI=3Dy
> # CONFIG_MTD_JEDECPROBE is not set
> CONFIG_MTD_GEN_PROBE=3Dy
> # CONFIG_MTD_CFI_ADV_OPTIONS is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
> CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
> CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
> # CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
> # CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> # CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
> CONFIG_MTD_CFI_I1=3Dy
> CONFIG_MTD_CFI_I2=3Dy
> # CONFIG_MTD_CFI_I4 is not set
> # CONFIG_MTD_CFI_I8 is not set
> CONFIG_MTD_CFI_INTELEXT=3Dy
> CONFIG_MTD_CFI_AMDSTD=3Dy
> CONFIG_MTD_CFI_STAA=3Dy
> CONFIG_MTD_CFI_UTIL=3Dy
> CONFIG_MTD_RAM=3Dy
> CONFIG_MTD_ROM=3Dy
> # CONFIG_MTD_ABSENT is not set
> # CONFIG_MTD_OBSOLETE_CHIPS is not set
>=20
> #
> # Mapping drivers for chip access
> #
> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> # CONFIG_MTD_PHYSMAP is not set
> # CONFIG_MTD_ARM_INTEGRATOR is not set
> CONFIG_MTD_OMAP_NOR=3Dy
> # CONFIG_MTD_PLATRAM is not set
>=20
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_SLRAM is not set
> # CONFIG_MTD_PHRAM is not set
> # CONFIG_MTD_MTDRAM is not set
> # CONFIG_MTD_BLOCK2MTD is not set
>=20
> #
> # Disk-On-Chip Device Drivers
> #
> # CONFIG_MTD_DOC2000 is not set
> # CONFIG_MTD_DOC2001 is not set
> # CONFIG_MTD_DOC2001PLUS is not set
>=20
> #
> # NAND Flash Device Drivers
> #
> # CONFIG_MTD_NAND is not set
>=20
> #
> # OneNAND Flash Device Drivers
> #
> # CONFIG_MTD_ONENAND is not set
>=20
> #
> # Parallel port support
> #
> # CONFIG_PARPORT is not set
>=20
> #
> # Plug and Play support
> #
>=20
> #
> # Block devices
> #
> # CONFIG_BLK_DEV_COW_COMMON is not set
> # CONFIG_BLK_DEV_LOOP is not set
> # CONFIG_BLK_DEV_NBD is not set
> CONFIG_BLK_DEV_RAM=3Dy
> CONFIG_BLK_DEV_RAM_COUNT=3D16
> CONFIG_BLK_DEV_RAM_SIZE=3D4096
> CONFIG_BLK_DEV_RAM_BLOCKSIZE=3D1024
> CONFIG_BLK_DEV_INITRD=3Dy
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
>=20
> #
> # SCSI device support
> #
> # CONFIG_RAID_ATTRS is not set
> # CONFIG_SCSI is not set
> # CONFIG_SCSI_NETLINK is not set
>=20
> #
> # Serial ATA (prod) and Parallel ATA (experimental) drivers
> #
> # CONFIG_ATA is not set
>=20
> #
> # Multi-device support (RAID and LVM)
> #
> # CONFIG_MD is not set
>=20
> #
> # Fusion MPT device support
> #
> # CONFIG_FUSION is not set
>=20
> #
> # IEEE 1394 (FireWire) support
> #
>=20
> #
> # I2O device support
> #
>=20
> #
> # Network device support
> #
> CONFIG_NETDEVICES=3Dy
> # CONFIG_DUMMY is not set
> # CONFIG_BONDING is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_TUN is not set
>=20
> #
> # PHY device support
> #
> # CONFIG_PHYLIB is not set
>=20
> #
> # Ethernet (10 or 100Mbit)
> #
> CONFIG_NET_ETHERNET=3Dy
> CONFIG_MII=3Dy
> CONFIG_SMC91X=3Dy
> # CONFIG_DM9000 is not set
>=20
> #
> # Ethernet (1000 Mbit)
> #
>=20
> #
> # Ethernet (10000 Mbit)
> #
>=20
> #
> # Token Ring devices
> #
>=20
> #
> # Wireless LAN (non-hamradio)
> #
> # CONFIG_NET_RADIO is not set
>=20
> #
> # Wan interfaces
> #
> # CONFIG_WAN is not set
> CONFIG_PPP=3Dy
> # CONFIG_PPP_MULTILINK is not set
> # CONFIG_PPP_FILTER is not set
> # CONFIG_PPP_ASYNC is not set
> # CONFIG_PPP_SYNC_TTY is not set
> # CONFIG_PPP_DEFLATE is not set
> # CONFIG_PPP_BSDCOMP is not set
> # CONFIG_PPP_MPPE is not set
> # CONFIG_PPPOE is not set
> CONFIG_SLIP=3Dy
> CONFIG_SLIP_COMPRESSED=3Dy
> CONFIG_SLHC=3Dy
> # CONFIG_SLIP_SMART is not set
> # CONFIG_SLIP_MODE_SLIP6 is not set
> # CONFIG_SHAPER is not set
> # CONFIG_NETCONSOLE is not set
> # CONFIG_NETPOLL is not set
> # CONFIG_NET_POLL_CONTROLLER is not set
>=20
> #
> # ISDN subsystem
> #
> # CONFIG_ISDN is not set
>=20
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
> # CONFIG_INPUT_FF_MEMLESS is not set
>=20
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=3Dy
> CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> # CONFIG_INPUT_JOYDEV is not set
> CONFIG_INPUT_TSDEV=3Dy
> CONFIG_INPUT_TSDEV_SCREEN_X=3D240
> CONFIG_INPUT_TSDEV_SCREEN_Y=3D320
> CONFIG_INPUT_EVDEV=3Dy
> # CONFIG_INPUT_EVBUG is not set
>=20
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=3Dy
> # CONFIG_KEYBOARD_ATKBD is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> CONFIG_KEYBOARD_OMAP=3Dy
> # CONFIG_INPUT_MOUSE is not set
> # CONFIG_INPUT_JOYSTICK is not set
> CONFIG_INPUT_TOUCHSCREEN=3Dy
> # CONFIG_TOUCHSCREEN_GUNZE is not set
> # CONFIG_TOUCHSCREEN_ELO is not set
> # CONFIG_TOUCHSCREEN_MTOUCH is not set
> # CONFIG_TOUCHSCREEN_MK712 is not set
> # CONFIG_TOUCHSCREEN_PENMOUNT is not set
> # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
> # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
> # CONFIG_TOUCHSCREEN_OMAP is not set
> # CONFIG_INPUT_MISC is not set
>=20
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=3Dy
> CONFIG_SERIO_SERPORT=3Dy
> # CONFIG_SERIO_RAW is not set
> # CONFIG_GAMEPORT is not set
>=20
> #
> # Character devices
> #
> CONFIG_VT=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_HW_CONSOLE=3Dy
> # CONFIG_VT_HW_CONSOLE_BINDING is not set
> # CONFIG_SERIAL_NONSTANDARD is not set
>=20
> #
> # Serial drivers
> #
> CONFIG_SERIAL_8250=3Dy
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_NR_UARTS=3D4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> # CONFIG_SERIAL_8250_EXTENDED is not set
>=20
> #
> # Non-8250 serial port support
> #
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> CONFIG_UNIX98_PTYS=3Dy
> # CONFIG_LEGACY_PTYS is not set
>=20
> #
> # IPMI
> #
> # CONFIG_IPMI_HANDLER is not set
>=20
> #
> # Watchdog Cards
> #
> CONFIG_WATCHDOG=3Dy
> CONFIG_WATCHDOG_NOWAYOUT=3Dy
>=20
> #
> # Watchdog Device Drivers
> #
> # CONFIG_SOFT_WATCHDOG is not set
> # CONFIG_OMAP_WATCHDOG is not set
> CONFIG_HW_RANDOM=3Dy
> CONFIG_HW_RANDOM_OMAP=3Dy
> # CONFIG_OMAP_RNG is not set
> # CONFIG_NVRAM is not set
> CONFIG_OMAP_RTC=3Dy
> # CONFIG_DTLK is not set
> # CONFIG_R3964 is not set
>=20
> #
> # Ftape, the floppy tape device driver
> #
> # CONFIG_RAW_DRIVER is not set
>=20
> #
> # TPM devices
> #
> # CONFIG_TCG_TPM is not set
>=20
> #
> # I2C support
> #
> CONFIG_I2C=3Dy
> # CONFIG_I2C_CHARDEV is not set
>=20
> #
> # I2C Algorithms
> #
> # CONFIG_I2C_ALGOBIT is not set
> # CONFIG_I2C_ALGOPCF is not set
> # CONFIG_I2C_ALGOPCA is not set
>=20
> #
> # I2C Hardware Bus support
> #
> # CONFIG_I2C_OCORES is not set
> CONFIG_I2C_OMAP=3Dy
> # CONFIG_I2C_PARPORT_LIGHT is not set
> # CONFIG_I2C_STUB is not set
> # CONFIG_I2C_PCA_ISA is not set
>=20
> #
> # Miscellaneous I2C Chip support
> #
> # CONFIG_SENSORS_DS1337 is not set
> # CONFIG_SENSORS_DS1374 is not set
> # CONFIG_SENSORS_EEPROM is not set
> # CONFIG_SENSORS_PCF8574 is not set
> # CONFIG_SENSORS_PCA9539 is not set
> # CONFIG_SENSORS_PCF8591 is not set
> CONFIG_ISP1301_OMAP=3Dm
> CONFIG_TPS65010=3Dy
> # CONFIG_SENSORS_TLV320AIC23 is not set
> CONFIG_GPIOEXPANDER_OMAP=3Dy
> # CONFIG_SENSORS_MAX6875 is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # CONFIG_I2C_DEBUG_CHIP is not set
>=20
> #
> # SPI support
> #
> # CONFIG_SPI is not set
> # CONFIG_SPI_MASTER is not set
>=20
> #
> # Dallas's 1-wire bus
> #
> # CONFIG_W1 is not set
>=20
> #
> # Hardware Monitoring support
> #
> CONFIG_HWMON=3Dy
> # CONFIG_HWMON_VID is not set
> # CONFIG_SENSORS_ABITUGURU is not set
> # CONFIG_SENSORS_ADM1021 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM1026 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ADM9240 is not set
> # CONFIG_SENSORS_ASB100 is not set
> # CONFIG_SENSORS_ATXP1 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_F71805F is not set
> # CONFIG_SENSORS_FSCHER is not set
> # CONFIG_SENSORS_FSCPOS is not set
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_LM63 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM77 is not set
> # CONFIG_SENSORS_LM78 is not set
> # CONFIG_SENSORS_LM80 is not set
> # CONFIG_SENSORS_LM83 is not set
> # CONFIG_SENSORS_LM85 is not set
> # CONFIG_SENSORS_LM87 is not set
> # CONFIG_SENSORS_LM90 is not set
> # CONFIG_SENSORS_LM92 is not set
> # CONFIG_SENSORS_MAX1619 is not set
> # CONFIG_SENSORS_PC87360 is not set
> # CONFIG_SENSORS_SMSC47M1 is not set
> # CONFIG_SENSORS_SMSC47M192 is not set
> # CONFIG_SENSORS_SMSC47B397 is not set
> # CONFIG_SENSORS_VT1211 is not set
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_W83791D is not set
> # CONFIG_SENSORS_W83792D is not set
> # CONFIG_SENSORS_W83L785TS is not set
> # CONFIG_SENSORS_W83627HF is not set
> # CONFIG_SENSORS_W83627EHF is not set
> # CONFIG_HWMON_DEBUG_CHIP is not set
>=20
> #
> # Misc devices
> #
> # CONFIG_TIFM_CORE is not set
>=20
> #
> # LED devices
> #
> # CONFIG_NEW_LEDS is not set
>=20
> #
> # LED drivers
> #
>=20
> #
> # LED Triggers
> #
>=20
> #
> # Multimedia devices
> #
> CONFIG_VIDEO_DEV=3Dy
> CONFIG_VIDEO_V4L1=3Dy
> CONFIG_VIDEO_V4L1_COMPAT=3Dy
> CONFIG_VIDEO_V4L2=3Dy
>=20
> #
> # Video Capture Adapters
> #
>=20
> #
> # Video Capture Adapters
> #
> # CONFIG_VIDEO_ADV_DEBUG is not set
> CONFIG_VIDEO_HELPER_CHIPS_AUTO=3Dy
> # CONFIG_VIDEO_VIVI is not set
> # CONFIG_VIDEO_CPIA is not set
> # CONFIG_VIDEO_SAA5246A is not set
> # CONFIG_VIDEO_SAA5249 is not set
> # CONFIG_TUNER_3036 is not set
> # CONFIG_VIDEO_OMAP_CAMERA is not set
>=20
> #
> # Radio Adapters
> #
>=20
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
>=20
> #
> # Graphics support
> #
> CONFIG_FIRMWARE_EDID=3Dy
> CONFIG_FB=3Dy
> # CONFIG_FB_CFB_FILLRECT is not set
> # CONFIG_FB_CFB_COPYAREA is not set
> # CONFIG_FB_CFB_IMAGEBLIT is not set
> # CONFIG_FB_MACMODES is not set
> # CONFIG_FB_BACKLIGHT is not set
> CONFIG_FB_MODE_HELPERS=3Dy
> # CONFIG_FB_TILEBLITTING is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_VIRTUAL is not set
> CONFIG_FB_OMAP=3Dy
> # CONFIG_FB_OMAP_LCDC_EXTERNAL is not set
> # CONFIG_FB_OMAP_LCD_MIPID is not set
> # CONFIG_FB_OMAP_BOOTLOADER_INIT is not set
> CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=3D2
> # CONFIG_FB_OMAP_DMA_TUNE is not set
>=20
> #
> # Console display driver support
> #
> # CONFIG_VGA_CONSOLE is not set
> CONFIG_DUMMY_CONSOLE=3Dy
> CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=3Dy
> CONFIG_FONT_8x16=3Dy
>=20
> #
> # Logo configuration
> #
> CONFIG_LOGO=3Dy
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> CONFIG_LOGO_LINUX_CLUT224=3Dy
> # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
>=20
> #
> # Sound
> #
> CONFIG_SOUND=3Dy
>=20
> #
> # Advanced Linux Sound Architecture
> #
> CONFIG_SND=3Dy
> CONFIG_SND_TIMER=3Dy
> CONFIG_SND_PCM=3Dy
> # CONFIG_SND_SEQUENCER is not set
> # CONFIG_SND_MIXER_OSS is not set
> # CONFIG_SND_PCM_OSS is not set
> # CONFIG_SND_DYNAMIC_MINORS is not set
> CONFIG_SND_SUPPORT_OLD_API=3Dy
> CONFIG_SND_VERBOSE_PROCFS=3Dy
> CONFIG_SND_VERBOSE_PRINTK=3Dy
> CONFIG_SND_DEBUG=3Dy
> CONFIG_SND_DEBUG_DETECT=3Dy
> CONFIG_SND_PCM_XRUN_DEBUG=3Dy
>=20
> #
> # Generic devices
> #
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_MPU401 is not set
>=20
> #
> # ALSA ARM devices
> #
> # CONFIG_SND_OMAP_AIC23 is not set
> CONFIG_SND_OMAP_TSC2101=3Dy
> # CONFIG_SND_SX1 is not set
> # CONFIG_SND_OMAP_TSC2102 is not set
>=20
> #
> # Open Sound System
> #
> CONFIG_SOUND_PRIME=3Dy
> # CONFIG_OSS_OBSOLETE_DRIVER is not set
> # CONFIG_SOUND_MSNDCLAS is not set
> # CONFIG_SOUND_MSNDPIN is not set
> # CONFIG_SOUND_TVMIXER is not set
>=20
> #
> # USB support
> #
> CONFIG_USB_ARCH_HAS_HCD=3Dy
> CONFIG_USB_ARCH_HAS_OHCI=3Dy
> # CONFIG_USB_ARCH_HAS_EHCI is not set
> # CONFIG_USB is not set
>=20
> #
> # Enable Host or Gadget support to see Inventra options
> #
>=20
> #
> # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
> #
>=20
> #
> # USB Gadget Support
> #
> # CONFIG_USB_GADGET is not set
>=20
> #
> # MMC/SD Card support
> #
> CONFIG_MMC=3Dy
> # CONFIG_MMC_DEBUG is not set
> CONFIG_MMC_BLOCK=3Dy
> CONFIG_MMC_OMAP=3Dy
> # CONFIG_MMC_TIFM_SD is not set
>=20
> #
> # Real Time Clock
> #
> CONFIG_RTC_LIB=3Dy
> # CONFIG_RTC_CLASS is not set
>=20
> #
> # Synchronous Serial Interfaces (SSI)
> #
> CONFIG_OMAP_UWIRE=3Dy
> CONFIG_OMAP_TSC2101=3Dy
>=20
> #
> # CBUS support
> #
> # CONFIG_CBUS is not set
>=20
> #
> # File systems
> #
> CONFIG_EXT2_FS=3Dy
> CONFIG_EXT2_FS_XATTR=3Dy
> # CONFIG_EXT2_FS_POSIX_ACL is not set
> # CONFIG_EXT2_FS_SECURITY is not set
> # CONFIG_EXT2_FS_XIP is not set
> # CONFIG_EXT3_FS is not set
> # CONFIG_EXT4DEV_FS is not set
> CONFIG_FS_MBCACHE=3Dy
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_FS_POSIX_ACL is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_GFS2_FS is not set
> # CONFIG_OCFS2_FS is not set
> # CONFIG_MINIX_FS is not set
> CONFIG_ROMFS_FS=3Dy
> CONFIG_INOTIFY=3Dy
> CONFIG_INOTIFY_USER=3Dy
> # CONFIG_QUOTA is not set
> CONFIG_DNOTIFY=3Dy
> # CONFIG_AUTOFS_FS is not set
> # CONFIG_AUTOFS4_FS is not set
> # CONFIG_FUSE_FS is not set
>=20
> #
> # CD-ROM/DVD Filesystems
> #
> # CONFIG_ISO9660_FS is not set
> # CONFIG_UDF_FS is not set
>=20
> #
> # DOS/FAT/NT Filesystems
> #
> # CONFIG_MSDOS_FS is not set
> # CONFIG_VFAT_FS is not set
> # CONFIG_NTFS_FS is not set
>=20
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=3Dy
> CONFIG_PROC_SYSCTL=3Dy
> CONFIG_SYSFS=3Dy
> # CONFIG_TMPFS is not set
> # CONFIG_HUGETLB_PAGE is not set
> CONFIG_RAMFS=3Dy
> # CONFIG_CONFIGFS_FS is not set
>=20
> #
> # Miscellaneous filesystems
> #
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_JFFS_FS is not set
> CONFIG_JFFS2_FS=3Dy
> CONFIG_JFFS2_FS_DEBUG=3D0
> CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
> # CONFIG_JFFS2_SUMMARY is not set
> # CONFIG_JFFS2_FS_XATTR is not set
> # CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
> CONFIG_JFFS2_ZLIB=3Dy
> CONFIG_JFFS2_RTIME=3Dy
> # CONFIG_JFFS2_RUBIN is not set
> # CONFIG_CRAMFS is not set
> # CONFIG_VXFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
>=20
> #
> # Network File Systems
> #
> CONFIG_NFS_FS=3Dy
> CONFIG_NFS_V3=3Dy
> # CONFIG_NFS_V3_ACL is not set
> # CONFIG_NFS_V4 is not set
> # CONFIG_NFS_DIRECTIO is not set
> # CONFIG_NFSD is not set
> CONFIG_ROOT_NFS=3Dy
> CONFIG_LOCKD=3Dy
> CONFIG_LOCKD_V4=3Dy
> CONFIG_NFS_COMMON=3Dy
> CONFIG_SUNRPC=3Dy
> # CONFIG_RPCSEC_GSS_KRB5 is not set
> # CONFIG_RPCSEC_GSS_SPKM3 is not set
> # CONFIG_SMB_FS is not set
> # CONFIG_CIFS is not set
> # CONFIG_NCP_FS is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> # CONFIG_9P_FS is not set
>=20
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=3Dy
>=20
> #
> # Native Language Support
> #
> # CONFIG_NLS is not set
>=20
> #
> # Profiling support
> #
> # CONFIG_PROFILING is not set
>=20
> #
> # Kernel hacking
> #
> # CONFIG_PRINTK_TIME is not set
> CONFIG_ENABLE_MUST_CHECK=3Dy
> # CONFIG_MAGIC_SYSRQ is not set
> # CONFIG_UNUSED_SYMBOLS is not set
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_LOG_BUF_SHIFT=3D14
> CONFIG_DETECT_SOFTLOCKUP=3Dy
> # CONFIG_SCHEDSTATS is not set
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_DEBUG_PREEMPT=3Dy
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_RT_MUTEX_TESTER is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_RWSEMS is not set
> # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_DEBUG_KOBJECT is not set
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> CONFIG_DEBUG_INFO=3Dy
> # CONFIG_DEBUG_FS is not set
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_LIST is not set
> CONFIG_FRAME_POINTER=3Dy
> CONFIG_FORCED_INLINING=3Dy
> # CONFIG_HEADERS_CHECK is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> CONFIG_DEBUG_USER=3Dy
> # CONFIG_DEBUG_WAITQ is not set
> CONFIG_DEBUG_ERRORS=3Dy
> # CONFIG_DEBUG_LL is not set
>=20
> #
> # Security options
> #
> # CONFIG_KEYS is not set
> # CONFIG_SECURITY is not set
>=20
> #
> # Cryptographic options
> #
> # CONFIG_CRYPTO is not set
>=20
> #
> # Library routines
> #
> CONFIG_CRC_CCITT=3Dy
> # CONFIG_CRC16 is not set
> CONFIG_CRC32=3Dy
> # CONFIG_LIBCRC32C is not set
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_ZLIB_DEFLATE=3Dy
> CONFIG_PLIST=3Dy
>=20
>=20
> Thank you,
> Prashant
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
