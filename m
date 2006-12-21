From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: RE: nand booting - sdp 2430
Date: Thu, 21 Dec 2006 09:20:28 -0600
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4708E5B8@dlee13.ent.ti.com>
References: <8bf247760612200639h2bb7045etfc78bdc1a3e51bb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <8bf247760612200639h2bb7045etfc78bdc1a3e51bb3@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ram <vshrirama@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Ram,

Where did you get this u-boot from, the one on (u-boot 1.1.4) on
linux-omap.com doesn't support NAND. It only supports One-nand.

Please pass your u-boot info, I will check this out here.

Regards,
Khasim

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Ram
Sent: Wednesday, December 20, 2006 8:39 AM
To: linux-omap-open-source@linux.omap.com
Subject: nand booting - sdp 2430

Hi,
  Sir, im trying to boot kernel from Nand using xloader.

 Im using CCST tool to burn the xloader. Im using Omap 2430 SDP Board.

Xloader download, compiled and Signed by IFT Setup tool.


I followed the following steps to do that
1)  I downloaded the xloader and burnt it to the nand at  0x0C000000.

2) I downloaded and burnt the u-boot (OS Loader) at (0x0010000 +
0xC00000)

    I got this address from the include/configs/omap2430sdp.h

/* NAND is partitioned:
 * 0x0000000 - 0x0010000        Booting Image
 * 0x0010000 - 0x0050000        U-Boot Image
 * 0x0050000 - 0x0080000        U-Boot Env Data (X-loader doesn't care)
 * 0x0080000 - 0x00B0000        Kernel Image
 * 0x00B0000 - 0x4000000        depends on application
 */

3) I changed the Dip Switch setting S8-3 (CS0_0) to OFF so that
Onboard Nand is CS0.


When i restart the board, It just hangs. Im not sure if im doing
something wrong?.


Please Advice.


Regards,
sriram
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
