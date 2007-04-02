From: Ram <vshrirama@gmail.com>
Subject: X-loader and Micron Nand
Date: Mon, 2 Apr 2007 21:03:23 +0530
Message-ID: <8bf247760704020833p73b0b709pa45e2ae61639d2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
