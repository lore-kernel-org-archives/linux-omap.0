From: "sandeep prabhu" <sandeep.mitian@gmail.com>
Subject: MTD NAND support in 2.6.19-omap1 kernel for OMAP2430 SDP
Date: Thu, 25 Jan 2007 03:37:08 +0530
Message-ID: <c04186510701241407r22200b50u9dc5dd1c0439a508@mail.gmail.com>
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
To: Linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
I am using 2.6.19 kernel ( from linux-omap.com site ) for OMAP2430 SDP
board. I have applied the patch-2.6.19-omap1 from the same site and using it
for booting the OMAP2430 SDP board.

I am not able to use  MTD Nand partitions on the on-board Nand  Flash ( k9k1216
). I can access only NOR flash partitions using this version of kernel.

1. Are there any patches for the MTD nand support  for OMAP2430 sdp for
2.6.19 kernel ?

2. Can I port the driver from older kernel version like 2.6.14 ? The design
of MTD Nand subsystem seems to differ between kernel versions 2.6.14 and
2.6.19

could anyone help me how to get the MTD Nand support with 2.6.19, on omap
2430 sdp ?

-- 
Warm Regards,
Sandeep
