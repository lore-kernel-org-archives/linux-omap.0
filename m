From: "Raghunandan Dhongadi" <dk.raghu@gmail.com>
Subject: OMAP2430 NAND Boot
Date: Thu, 4 Jan 2007 12:14:50 +0530
Message-ID: <7d8fdf6f0701032244h43e68e3fva88745b793d97697@mail.gmail.com>
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

Hello All,

I am trying to do a NAND boot on OMAP2430 SDP Board. The steps are as follows...

1. I have built the X-Loader and appended the .ift header.
2. Dip switch settings for NAND boot
3. The internal ROM code shadows X-Loader to SRAM 0x4020.0000 and
transfers control
4. The X-Loader begins to execute and tries to copy the U-Boot from
the NAND flash.
5. I get a bad block error.

Question:
1. Is there a specific way that I need to format the U-Boot.bin image
file before programming it into the NAND ( I use CSST tool )

2. For NAND boot mode,  the NAND is addressed at 0x0000.0000 and the
U-boot offset is 0x40000, is this correct  ?

Warm Regards,
Raghu.
