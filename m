From: Ola Helm <ola.hel@gmail.com>
Subject: Problem with flashing and/or starting UBoot with 2420
Date: Fri, 23 Dec 2005 11:39:46 +0200
Message-ID: <3d3153f60512230139v57b3a30dh2346e44ad2b17da8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi all,

My problem is following one:

I flashed the newest H4 UBoot available to ou board and after restart I get
following message in Hyperterminal:

U-Boot 1.1.3 (Sep  6 2005 - 14:24:25)

U-Boot code: 80E80000 -> 80E9F0E8  BSS: -> 80EA3F2C
OMAP2420-GP revision 3, PRCM II
TI H4 SDP Base Board + Menelaus Daughter Board + mDDR
RAM Configuration:
Bank #0: 80000000 32 MB
Bank #1: 82000000 32 MB
## Unknown FLASH on Bank 0 - Size =3D 0x00000000 =3D 0 MB
## Unknown FLASH on Bank 1 - Size =3D 0x00000000 =3D 0 MB
Flash:  0 kB
NAND:

So there seems to be nothing in the flash neither I am able to write
anything to command line. It seems to be that there might be some kind of
error in mapping of memory or something like that.

Our system consits of following items:
- MAIN BOARD 700-0561-001 Rev C.2
- PROCESSOR DAUGTHER CARD MENELAUS 2420 750-0009-007/B
- MULTIPORT II DEBUG BOARD 700-0582-000 REV B

- Blackhawk USB 560 JTAG Emulator BH-USB-560M

- Code Composer Studio 3.1 Platinum Edition
- TI OSTHost
- TI OSTBoot

We have used OSTTool 2.5 to flash the board, and there has been no problems
with it. We have used following settings:

Interface: USB
Platform: 2420 ES 2.1 Menelaus Combo
Flash: NOR
Device: GP
Multiple downloads: Enabled
CRC Checking: Enabled
ASIC ID logging: On
Default addresses


We have used following postions in two "most important" swithces (related t=
o
flashing) on daugther card when flashing the board:

SW 1
1 ON
2 OFF
3 ON
4 OFF

SW 2

1 OFF
2 ON
3 ON
4 ON

And while listening serial port in SW 1 number 4 is ON and in SW 2 all are
ON. This has worked fine with TI bootfiles.

Does anybody have an idea what is the problem or - even better - idea what
to do to solve it? Thanks already in advance.

Regs,

O
