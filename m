From: "Nemakal, Vijaya" <xnemakal@ti.com>
Subject: RE: MTD NAND support in 2.6.19-omap1 kernel for OMAP2430 SDP
Date: Thu, 25 Jan 2007 07:54:54 -0600
Message-ID: <A17BD4D22DD44F4C8DAFFD5871A94E2B07E2FB@dlee13.ent.ti.com>
References: <c04186510701241407r22200b50u9dc5dd1c0439a508@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <c04186510701241407r22200b50u9dc5dd1c0439a508@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: sandeep prabhu <sandeep.mitian@gmail.com>, Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Sandeep,

> 1. Are there any patches for the MTD nand support  for OMAP2430 sdp
for
> 2.6.19 kernel ?

We do not have support for NAND for 2.6.19 kernel as of yet, but that
will get in soon.

> 2. Can I port the driver from older kernel version like 2.6.14 ? The=20
> design of MTD Nand subsystem seems to differ between kernel versions=20
> 2.6.14 and 2.6.19

The mtd subsystem should not be of any concern and they will work
seamlessly=20
between 2.6.14 and 2.6.19 kernel. All you would require is to write a
mapping driver for NAND part where you will be registering with mtd
subsystem. And add the partition information either into your board
specific file or into this mapping file.
Pls look at drivers/mtd/onenad/omap-onenand.c. Your nand mapping driver
looks almost similar to the one written for onenand.

Regards
Vijaya

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
sandeep prabhu
Sent: Thursday, January 25, 2007 3:37 AM
To: Linux-omap-open-source@linux.omap.com
Subject: MTD NAND support in 2.6.19-omap1 kernel for OMAP2430 SDP

Hi,
I am using 2.6.19 kernel ( from linux-omap.com site ) for OMAP2430 SDP
board. I have applied the patch-2.6.19-omap1 from the same site and
using it
for booting the OMAP2430 SDP board.

I am not able to use  MTD Nand partitions on the on-board Nand  Flash (
k9k1216
). I can access only NOR flash partitions using this version of kernel.

1. Are there any patches for the MTD nand support  for OMAP2430 sdp for
2.6.19 kernel ?

2. Can I port the driver from older kernel version like 2.6.14 ? The
design
of MTD Nand subsystem seems to differ between kernel versions 2.6.14 and
2.6.19

could anyone help me how to get the MTD Nand support with 2.6.19, on
omap
2430 sdp ?

--=20
Warm Regards,
Sandeep
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
