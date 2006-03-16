From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: OSK5912 and CF and network broken?
Date: Thu, 16 Mar 2006 18:03:02 +0100
Message-ID: <44199A46.3080303@gmail.com>
References: <20060315183006.GA16873@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060315183006.GA16873@smtp.west.cox.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tom Rini wrote:
> Has anyone seen this before?  Or should I just looking at the interrupt
> routes?  I'm assuming that the board does support me using both CF and
> network at the same time.  Thanks!

Yes, board supports both, CF and network. However, OSK CF 
hardware is limited and is really troublesome.

But using recent git without any special patches I get no 
transmit timeouts:

# pccard: PCMCIA card inserted into slot 0
pcmcia: registering new device pcmcia0.0

# ping 192.0.0.1
PING 192.0.0.1 (192.0.0.1): 56 data bytes
64 bytes from 192.0.0.1: icmp_seq=0 ttl=64 time=1.0 ms
64 bytes from 192.0.0.1: icmp_seq=1 ttl=64 time=0.8 ms

--- 192.0.0.1 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 0.8/0.9/1.0 ms
# cp /mnt/nfs/foo.mp3 /dev/null
...
# pccard: card ejected from slot 0

=> No timeouts

Kernel configuration:

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_BLK_DEV_IDEDISK=m
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_BLK_DEV_IDECS=m
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set

#
# PCCARD (PCMCIA/CardBus) support
#
CONFIG_PCCARD=m
# CONFIG_PCMCIA_DEBUG is not set
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_PCMCIA_IOCTL=y

#
# PC-card bridges
#
CONFIG_OMAP_CF=m

However, seems that my cardmgr is configured wrong again, 
but this is another issue:

# cardmgr
cardmgr[978]: watching 1 socket
cardmgr[978]: could not adjust resource: IO ports 
0xc00-0xcff: Function not implemented
cardmgr[978]: could not adjust resource: IO ports 
0x800-0x8ff: Function not implemented
cardmgr[978]: could not adjust resource: IO ports 
0x100-0x4ff: Function not implemented
cardmgr[978]: could not adjust resource: memory 
0xc0000-0xfffff: Function not implemented
cardmgr[978]: could not adjust resource: memory 
0x60000000-0x60ffffff: Function not implemented
cardmgr[978]: could not adjust resource: memory 
0xa0000000-0xa0ffffff: Function not implemented
cardmgr[978]: could not adjust resource: IO ports 
0xa00-0xaff: Function not implemented
# pccard: PCMCIA card inserted into slot 0
cardmgr[979]: socket 0: Anonymous Memory
cardmgr[979]: executing: 'modprobe memory_cs 2>&1'
cardmgr[979]: + modprobe: module memory_cs not found.
cardmgr[979]: + modprobe: failed to load module memory_cs
cardmgr[979]: modprobe exited with status 1
cardmgr[979]: module 
/lib/modules/2.6.16-rc5-omap1/pcmcia/memory_cs.o not available
cardmgr[979]: bind 'memory_cs' to socket 0 failed: Invalid 
argument

Best regards

Dirk
