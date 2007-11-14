From: "Sameer" <x0081444@ti.com>
Subject: Onenand - sync burst read
Date: Wed, 14 Nov 2007 10:29:14 +0530
Message-ID: <004701c8267b$1adbe270$ec8818ac@ent.ti.com>
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
I am working on onenand driver based on omap board.I need to add the functionality for Synchronous burst read mode operation which
is currently not present.I am refering n800 board driver (arch/arm/mach-omap/board-n880-flash.c) The function
"omap2_onenand_set_sync_mode" contains the variable "fclk_offset_ns"

I am not able to relate this variable with the timing parameters of the onenand flash.Could any body specify the significance of
this variable and how is it related to the timing variables?

Thanks,
-Sameer	
