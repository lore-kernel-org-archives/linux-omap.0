From: "Giron, Jeremy" <jwgiron@sandia.gov>
Subject: RE: U-boot 1.1.4 compilation problem
Date: Tue, 28 Mar 2006 08:47:31 -0700
Message-ID: <C4DF42131A1F374CA3675F7B2EF03ECB0223992C@ES22SNLNT.srn.sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hiroki,
Yes, you are correct. I'm not sure how it worked without it.

It should mimic omap1510imm.h:

#define PHYS_FLASH_1	0x00000000	/* Flash Bank #1 */

#define CFG_FLASH_BASE	PHYS_FLASH_1
<...>
#define CFG_MAX_FLASH_BANKS	2	/* max number of memory banks */
#define PHYS_FLASH_SIZE		0x01000000 /* 16MB */
#define PHYS_FLASH_SECT_SIZE	(128*1024)	/* Size of a sector
(128kB) */
#define CFG_MAX_FLASH_SECT	(128)	/* max number of sectors on one
chip */
#define CFG_ENV_ADDR		(CFG_FLASH_BASE + PHYS_FLASH_SECT_SIZE)
#define CFG_MONITOR_BASE	CFG_FLASH_BASE	/* Monitor at beginning
of flash */
#define CFG_MONITOR_LEN		PHYS_FLASH_SECT_SIZE	/* Reserve 1
sector */
#define CFG_FLASH_BANKS_LIST	{ CFG_FLASH_BASE, CFG_FLASH_BASE +
PHYS_FLASH_SIZE }


Result:
OMAP5912 OSK # flinfo

=20

Bank # 1: CFI conformant FLASH (16 x 16)  Size: 16 MB in 128 Sectors

 Erase timeout 16384 ms, write timeout 2 ms, buffer write timeout 2048
ms, buffe
r size 32

  Sector Start Addresses:

    00000000 (RO) 00020000 (RO) 00040000      00060000      00080000

    000A0000      000C0000      000E0000      00100000      00120000

    <...>
    00F00000      00F20000      00F40000      00F60000      00F80000

    00FA0000      00FC0000      00FE0000

=20

Bank # 2: CFI conformant FLASH (16 x 16)  Size: 16 MB in 128 Sectors

 Erase timeout 16384 ms, write timeout 2 ms, buffer write timeout 2048
ms, buffe
r size 32

  Sector Start Addresses:

    01000000      01020000      01040000      01060000      01080000

    010A0000      010C0000      010E0000      01100000      01120000

    <...>           =20
    01F00000      01F20000      01F40000      01F60000      01F80000

    01FA0000      01FC0000      01FE0000 =20

Best regards,
Jeremy

-----Original Message-----
From: Hiroki Kaminaga [mailto:kaminaga@sm.sony.co.jp]=20
Sent: Sunday, March 26, 2006 11:48 PM
To: Giron, Jeremy
Cc: chief@verat.net; linux-omap-open-source@linux.omap.com;
kaminaga@sm.sony.co.jp
Subject: Re: U-boot 1.1.4 compilation problem

Hi,

sorry for late reply,

> It is also necessary to change CFG_MAX_FLASH_BANKS to 2 (from 1).
> Otherwise the CFI driver will only detect a single 16MB bank, rather=20
> than the full 16MBx2 =3D 32MB.

Umm, that's right. Also if you change to 2, you also need to set
CFG_FLASH_BANKS_LIST too?


Best Regards,

(Hiroki Kaminaga)
t
--
