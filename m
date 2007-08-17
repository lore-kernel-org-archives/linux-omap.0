From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH 1/3] [ARM] OMAP: Adding Support for 2K nand page support
 for	omap2430
Date: Thu, 16 Aug 2007 17:27:28 -0700
Message-ID: <46C4EB70.2020802@mvista.com>
References: <809D758398CC1F49AA8E493528AD4A27014DF6AD@ntxsjombx02.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <809D758398CC1F49AA8E493528AD4A27014DF6AD@ntxsjombx02.micron.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: sshahrom@micron.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

sshahrom@micron.com wrote:
> Hello,
> Following patches would add support for 2k Page nand with Enabled HW ECC on omap2430 v4.0. It has been Tested with Micron Nand. The Patch is against 2.6.22 linux-omap.git tree. As Always all the comments are welcomed.
> 

Shahrom,

Have you done any testing with your driver with the NAND part on the
2430SDP-v5.0 boards?

Using your driver, the chip is probed/reported correctly (see boot
excerpt below), but the I can't seem to use the MTD tools to work with
any of the partitions?

For example, flash_info gives: 'Device /dev/mtdX has 0 erase regions'
for each partition on the NAND device.  And trying a flash_erase gives
'File open error'.

Any ideas?

Kevin


[...]
omap2-nand driver initializing


NAND device: Manufacturer ID: 0xec, Chip ID: 0x46 (Samsung NAND 64MiB
1,8V 16-bi

t)


2048 byte HW ECC not possible on 512 byte page size, fallback to SW ECC


Creating 5 MTD partitions on "omap2-nand":


0x00000000-0x00080000 : "X-Loader"


0x00080000-0x00100000 : "U-Boot"


0x00100000-0x00140000 : "U-Boot Environment"


0x00140000-0x00540000 : "Kernel"


0x00540000-0x04000000 : "File System"
[...]
