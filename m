From: Nagesh.Sonone@lntinfotech.com
Subject: OMAP2430 NAND x-loader + U-Boot
Date: Tue, 29 May 2007 16:04:15 +0530
Message-ID: <OFFB78E0C0.A61B419E-ON652572EA.003A069E-652572EA.00399691@lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hi All,
   I have compiled NAND x-loader for OMAP2430 and is running successfully 
( showing the message "x-loader hangs" eventually, and also showing Bad 
Blocks sometimes). I have also compiled NAND U-Boot for the same.
       I had assumed that it will work well if I put my NAND U-Boot at 
NAND offset 0x40000 ( as x-loader looks for this address for U-boot 
image,I believe), but its not working.
  Please can anybody tell me how to make it work for NAND? 
( I am also not much cleared with NAND booting , It will be great help to 
me if somebody can elobarate some more on this with regard to ROM Code , 
Internal RAM)

Thanks & Regards,
Nagesh R. Sonone,
Software Engineer,
L&T Infotech Ltd. 


______________________________________________________________________
