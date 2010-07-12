From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ARM defconfig files
Date: Mon, 12 Jul 2010 22:31:16 +0200
Message-ID: <201007122231.16283.arnd@arndb.de>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org> <AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com> <20100712185029.GB14425@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100712185029.GB14425@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Walker <dwalker@codeaurora.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Eric Miao <eric.miao@canonical.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-omap@vger.kernel.org

On Monday 12 July 2010 20:50:29 Uwe Kleine-K=F6nig wrote:
>=20
> [1] The following changes since commit 67a3e12b05e055c0415c556a315a3d=
3eb637e29e:
>=20
>   Linux 2.6.35-rc1 (2010-05-30 13:21:02 -0700)
>=20
> are available in the git repository at:
>   git://git.pengutronix.de/git/ukl/linux-2.6.git arm/defconfig/reduce=
d-v2.6.35-rc1

BTW, looking at the most common entries in there, I think we might at s=
ome
point want to change some of the defaults in the respective Kconfig fil=
es.
Right now an empty defconfig would result in a configuration without
file system, networking or modules:

sort arch/arm/configs/* | uniq -c | sort -n | tail -n 30
    114 CONFIG_BLK_DEV_RAM=3Dy
    116 CONFIG_BLK_DEV_INITRD=3Dy
    116 CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
    117 CONFIG_NFS_FS=3Dy
    118 CONFIG_MTD_CHAR=3Dy
    119 CONFIG_INOTIFY=3Dy
    122 # CONFIG_BLK_DEV_BSG is not set
    122 CONFIG_IP_PNP=3Dy
    123 # CONFIG_IPV6 is not set
    123 CONFIG_MTD_BLOCK=3Dy
    125 CONFIG_FPE_NWFPE=3Dy
    127 CONFIG_NET_ETHERNET=3Dy
    128 CONFIG_LOG_BUF_SHIFT=3D14
    128 CONFIG_MTD=3Dy
    131 CONFIG_PACKET=3Dy
    132 # CONFIG_INPUT_MOUSE is not set
    133 CONFIG_DEBUG_KERNEL=3Dy
    134 CONFIG_EXT2_FS=3Dy
    138 CONFIG_MODULE_UNLOAD=3Dy
    139 CONFIG_TMPFS=3Dy
    142 CONFIG_NETDEVICES=3Dy
    147 CONFIG_ZBOOT_ROM_BSS=3D0x0
    147 CONFIG_ZBOOT_ROM_TEXT=3D0x0
    151 CONFIG_INET=3Dy
    151 CONFIG_UNIX=3Dy
    153 CONFIG_NET=3Dy
    156 # CONFIG_VGA_CONSOLE is not set
    158 CONFIG_MODULES=3Dy
    164 CONFIG_SYSVIPC=3Dy
    174 CONFIG_EXPERIMENTAL=3Dy

Also, some of the defconfigs contain stuff that arguably does not belon=
g
into a defconfig and could be removed in the next merge window, e.g.

ezx_defconfig:CONFIG_LOCALVERSION=3D"-ezx200910312315"
pnx4008_defconfig:CONFIG_DECNET=3Dm
at572d940hfek_defconfig:CONFIG_SGI_PARTITION=3Dy

	Arnd
