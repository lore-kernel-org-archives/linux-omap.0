From: "Giron, Jeremy" <jwgiron@sandia.gov>
Subject: RE: U-boot 1.1.4 compilation problem
Date: Thu, 23 Mar 2006 10:52:01 -0700
Message-ID: <C4DF42131A1F374CA3675F7B2EF03ECB0223925E@ES22SNLNT.srn.sandia.gov>
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
To: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>, chief@verat.net
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,
It is also necessary to change CFG_MAX_FLASH_BANKS to 2 (from 1).
Otherwise the CFI driver will only detect a single 16MB bank, rather
than the full 16MBx2 =3D 32MB.
Best regards,
Jeremy

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
Hiroki Kaminaga
Sent: Wednesday, March 01, 2006 6:06 PM
To: chief@verat.net
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: U-boot 1.1.4 compilation problem

Hi,

> I have problem compiling U-boot 1.1.4.

I'm also using OMAP5912OSK and U-boot 1.1.4.

>From U-boot 1.1.3 to 1.1.4, flash implementation for OSK is moved from
board/omap5912osk/flash.c to drivers/cfi_flash.c but the header file
include/configs/omap5912osk.h is not taking this into account.

Attached is the patch I used to build u-boot-1.1.4 for osk.

Hope this helps.


Best Regards,

HK.
--
