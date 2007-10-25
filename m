From: "Sameer" <x0081444@ti.com>
Subject: Onenand sync burst mode - query
Date: Thu, 25 Oct 2007 17:52:49 +0530
Message-ID: <00b901c81701$c25844f0$ec8818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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

Hi,
I am working on onenand driver based on omap board.
Onenand is samsung onenand. I need to add the functionality for
Synchronous burst mode operation which is currently not present.
I am refering n800 board driver (arch/arm/mach-omap/board-n880-flash.c)
The function "omap2_onenand_set_sync_mode" contains the variable "fclk_offset_ns"

I am not able to relate this variable with the timing diagram of the onenand flash
Could any body specify the significance of this variable and how is it related to 
the timing variables?

Thanks,
-Sameer	
