From: "Kipisz, Steven" <s-kipisz2@ti.com>
Subject: RE: X-loader and Micron Nand
Date: Mon, 2 Apr 2007 10:38:07 -0500
Message-ID: <B62D67BD8EC3324C8A3DACEEA1A0D6C6010B6A84@dlee12.ent.ti.com>
References: <8bf247760704020833p73b0b709pa45e2ae61639d2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <8bf247760704020833p73b0b709pa45e2ae61639d2e@mail.gmail.com>
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

You cannot use u-boot to flash the x-loader to NAND.  The location where
the ECC is saved is different between u-boot and where the boot ROM
expects it.

CSST is the supported flashing tool for flashing the x-loader.
Unfortunately you must get the source and write your own flash writer
for large page NAND.

Steve Kipisz

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Ram
Sent: Monday, April 02, 2007 10:33 AM
To: linux-omap-open-source@linux.omap.com
Subject: X-loader and Micron Nand

Hi,
   Im using a custom board of OMAP 2430 which has a micron nand flash
(large page size - 2K)

   I trying to boot out of nand. Im running u-boot from RAM and trying
to write X-loader and u-boot from u-boot.

   Im able to write x-loader and when i read it back using nand read -
im able to read the contents back.

   However, when i reset the board, the board doesnt boot.

  Im trying to debug using ROM code using CCS. the ROM code doesnt
load the x-loader
 in the location specified by x-loader.ift.

  I suspect it is a formatting issue - the way x-loader should be
written onto the nand flash.

 The spare area and the format of the spare area.

  I have tried the following schemes:
Scheme 1:
   Page 0: <2048 bytes of x-loader> <12 bytes of CRC>
   Page 1:<2048 bytes of x-loader> <12 bytes of CRC>
   page 2: <2048 bytes of x-loader> <12 bytes of CRC>
   page 4:<2048 bytes of x-loader> <12 bytes of CRC>

Scheme 2:
   Page 0: <2048 bytes of x-loader> <64 bytes of CRC>
   Page 1: <2048 bytes of x-loader> <64 bytes of CRC>
   Page 2: <2048 bytes of x-loader> <64 bytes of CRC>
   Page 3: <2048 bytes of x-loader> <64 bytes of CRC>

 Am i missing something?.

 Has anyone successfully written x-loader on a nand flash with 2K page
sizes. if so, what is the structure of the spare area?

please Advice,


Regards,
sriram
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
