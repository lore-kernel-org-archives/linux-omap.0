From: "Kyungmin Park" <kmpark@infradead.org>
Subject: Re: [PATCH 00/17] MMC: OMAP: Add MMC multislot support
Date: Thu, 29 Nov 2007 13:49:17 +0900
Message-ID: <9c9fda240711282049i30136022s9a5d6b9cd4df2a4c@mail.gmail.com>
References: <474AEDBB.1070006@indt.org.br> <20071128020300.GB11825@atomide.com>
	<9c9fda240711280006q209acc15r2de7cf5813385e1a@mail.gmail.com>
	<20071128180531.GM11825@atomide.com>
	<9c9fda240711281524j2ba3cb28qf895495db3705184@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9c9fda240711281524j2ba3cb28qf895495db3705184@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>, drzeus@drzeus.cx
List-Id: linux-omap@vger.kernel.org

Hi,

I roll-backed the mmc core part to 2.6.23 except the omap host. then
it's working.
I will try to find the wha't changed.

Thank you,
Kyungmin Pakr.

On 11/29/07, Kyungmin Park <kmpark@infradead.org> wrote:
> >
> > Where does it get stuck? If you enable CONFIG_MMC_DEBUG you may get a
> > clue if it's always the same command that gets it stuck.
> >
>
> It's boot message.
>
> mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 width 0 timing 0
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 21 width 0 timing 0
> mmc0: starting CMD0 arg 00000000 flags 000000c0
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 0): EOC
> mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 21 width 0 timing 0
> mmc0: starting CMD8 arg 000001aa flags 000002f5
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 8): CTO
> mmci-omap mmci-omap.1: command timeout (CMD8)
> mmc0: req done (CMD8): -110: 00000000 00000000 00000000 00000000
> mmc0: starting CMD5 arg 00000000 flags 000002e1
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 5): CTO
> mmci-omap mmci-omap.1: command timeout (CMD5)
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 5): CTO
> mmci-omap mmci-omap.1: command timeout (CMD5)
> mmc0: req failed (CMD5): -110, retrying...
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 5): CTO
> mmci-omap mmci-omap.1: command timeout (CMD5)
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 5): CTO
> mmci-omap mmci-omap.1: command timeout (CMD5)
> mmc0: req failed (CMD5): -110, retrying...
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 5): CTO
> mmci-omap mmci-omap.1: command timeout (CMD5)
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 5): CTO
> mmci-omap mmci-omap.1: command timeout (CMD5)
> mmc0: req failed (CMD5): -110, retrying...
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 5): CTO
> mmci-omap mmci-omap.1: command timeout (CMD5)
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 5): CTO
> mmci-omap mmci-omap.1: command timeout (CMD5)
> mmc0: req done (CMD5): -110: 00000000 00000000 00000000 00000000
> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 55): CTO
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 55): CTO
> mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 55): CTO
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 55): CTO
> mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 55): CTO
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 55): CTO
> mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
> mmc0: starting CMD55 arg 00000000 flags 000000f5
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 55): CTO
> mmci-omap mmci-omap.1: MMC IRQ 0080 (CMD 55): CTO
> mmc0: req done (CMD55): -110: 00000000 00000000 00000000 00000000
> mmc0: starting CMD1 arg 00000000 flags 000000e1
> mmci-omap mmci-omap.1: MMC IRQ 1001 (CMD 1): EOC OCRB
> mmci-omap mmci-omap.1: MMC IRQ 1000 (CMD 1): OCRB
> mmc0: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd 20 width 0 timing 0
> mmc0: starting CMD0 arg 00000000 flags 000000c0
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 0): EOC
> mmc0: req done (CMD0): 0: 00000000 00000000 00000000 00000000
> mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd 20 width 0 timing 0
> mmc0: starting CMD1 arg 40300000 flags 000000e1
> mmci-omap mmci-omap.1: MMC IRQ 1001 (CMD 1): EOC OCRB
> mmci-omap mmci-omap.1: MMC IRQ 1000 (CMD 1): OCRB
> mmc0: req done (CMD1): 0: 00ff8080 00000000 00000000 00000000
> mmc0: starting CMD1 arg 40300000 flags 000000e1
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 1): EOC
> mmc0: req done (CMD1): 0: c0ff8080 00000000 00000000 00000000
> mmc0: starting CMD2 arg 00000000 flags 00000067
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 2): EOC
> mmc0: req done (CMD2): 0: 15000030 30303030 30402007 020299d1
> mmc0: starting CMD3 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 3): EOC
> mmc0: req done (CMD3): 0: 00000500 00000000 00000000 00000000
> mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 0
> mmc0: starting CMD9 arg 00010000 flags 00000007
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 9): EOC
> mmc0: req done (CMD9): 0: 9026012a 0f5b03d3 f6dbffff 964040b3
> mmc0: starting CMD7 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 7): EOC
> mmc0: req done (CMD7): 0: 00000700 00000000 00000000 00000000
> mmc0: starting CMD8 arg 00000000 flags 000000b5
> mmc0:     blksz 512 blocks 1 flags 00000200 tsac 15 ms nsac 1000
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 8): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0008 (CMD -1): BRS
> mmc0: req done (CMD8): 0: 00000900 00000000 00000000 00000000
> mmc0:     512 bytes transferred: 0
> mmc0: starting CMD6 arg 03b90101 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 6): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 6): EOFB
> mmc0: req done (CMD6): 0: 00000900 00000000 00000000 00000000
> mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 1
> mmc0: clock 20000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 1
> mmc0: starting CMD6 arg 03b70101 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 6): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 6): EOFB
> mmc0: req done (CMD6): 0: 00000900 00000000 00000000 00000000
> mmc0: clock 20000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2 timing 1
> mmc0: new high speed MMC card at address 0001
> mmc0: starting CMD16 arg 00000200 flags 00000095
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 16): EOC
> mmc0: req done (CMD16): 0: 00000900 00000000 00000000 00000000
> mmcblk0: mmc0:0001 000000 4014080KiB
> mmcblk0:<7>mmc0: starting CMD18 arg 00000000 flags 000000b5
> mmc0:     blksz 512 blocks 8 flags 00000200 tsac 15 ms nsac 1000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 18): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0008 (CMD -1): BRS
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 12): EOC
> mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
> mmc0:     4096 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
>  p1 p2
> mmc0: starting CMD13 arg 00010000 flags 00000195
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
>
> At formatting...
> # mkfs.ext3 /dev/mmcb0p1
>
> mmc0: starting CMD18 arg 00002000 flags 000000b5
> mmc0:     blksz 512 blocks 8 flags 00000200 tsac 15 ms nsac 1000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 18): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0008 (CMD 18): BRS
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 12): EOC
> mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
> mmc0:     4096 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
> Filesystem label=
> OS type: Linux
> Block size=4096 (log=2)
> Fragment size=4096 (log=2)
> 125184 inodes, 250006 blocks
> 12500 blocks (5.00%) reserved for the super user
> First data block=0
> 8 block groups
> 32768 blocks per group, 32768 fragments per group
> 15648 inodes per group
> Superblock backups stored on blocks:
>        32768, 98304, 163840, 229376
>
> Writing inode tables:
> mmc0: starting CMD25 arg 00006000 flags 000000b5
> mmc0:     blksz 512 blocks 256 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 12): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 12): EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     131072 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 00026000 flags 000000b5
> mmc0:     blksz 512 blocks 256 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 12): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 12): EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     131072 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 00046000 flags 000000b5
> mmc0:     blksz 512 blocks 256 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 12): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 12): EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     131072 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 00066000 flags 000000b5
> mmc0:     blksz 512 blocks 256 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 12): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 12): EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     131072 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 00086000 flags 000000b5
> mmc0:     blksz 512 blocks 256 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 12): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 12): EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     131072 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 000a6000 flags 000000b5
> mmc0:     blksz 512 blocks 256 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 12): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 12): EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     131072 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 000c6000 flags 000000b5
> mmc0:     blksz 512 blocks 256 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 12): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 12): EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     131072 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 000e6000 flags 000000b5
> mmc0:     blksz 512 blocks 256 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 12): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 12): EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     131072 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 00106000 flags 000000b5
> mmc0:     blksz 512 blocks 256 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 12): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 12): EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     131072 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 00126000 flags 000000b5
> mmc0:     blksz 512 blocks 256 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 12): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 12): EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     131072 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 00146000 flags 000000b5
> mmc0:     blksz 512 blocks 256 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 12): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 12): EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     131072 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 00166000 flags 000000b5
> mmc0:     blksz 512 blocks 256 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 12): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 12): EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     131072 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 00186000 flags 000000b5
> mmc0:     blksz 512 blocks 256 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 12): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 12): EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     131072 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 001a6000 flags 000000b5
> mmc0:     blksz 512 blocks 256 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0005 (CMD 12): EOC CB
> mmci-omap mmci-omap.1: MMC IRQ 0010 (CMD 12): EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     131072 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 001c6000 flags 000000b5
> mmc0:     blksz 512 blocks 216 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0015 (CMD 12): EOC CB EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     110592 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 00002000 flags 000000b5
> mmc0:     blksz 512 blocks 8 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0015 (CMD 12): EOC CB EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     4096 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 001e1000 flags 000000b5
> mmc0:     blksz 512 blocks 112 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0014 (CMD 25): CB EOFB
> mmci-omap mmci-omap.1: MMC IRQ 001c (CMD -1): CB BRS EOFB
> mmci-omap mmci-omap.1: MMC IRQ 0015 (CMD 12): EOC CB EOFB
> mmc0: req done (CMD25): 0: 00000900 00000000 00000000 00000000
> mmc0:     57344 bytes transferred: 0
> mmc0:     (CMD12): 0: 00000d00 00000000 00000000 00000000
> mmc0: starting CMD13 arg 00010000 flags 00000015
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 13): EOC
> mmc0: req done (CMD13): 0: 00000900 00000000 00000000 00000000
> mmc0: starting CMD25 arg 08006000 flags 000000b5
> mmc0:     blksz 512 blocks 256 flags 00000100 tsac 480 ms nsac 32000
> mmc0:     CMD12 arg 00000000 flags 0000049d
> mmci-omap mmci-omap.1: MMC IRQ 0001 (CMD 25): EOC
> mmci-omap mmci-omap.1: MMC IRQ 0004 (CMD 25): CB
>
>
> Returned IRQ value is wrong? expected 0014 instead of 0004.
>
> Thank you,
> Kyungmin Park
>
