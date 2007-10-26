From: "Kyungmin Park" <kyungmin.park@samsung.com>
Subject: RE: Onenand sync burst mode - query
Date: Fri, 26 Oct 2007 09:03:23 +0900
Message-ID: <004401c81763$a511d6b0$e1ac580a@swcenter.sec.samsung.co.kr>
References: <00b901c81701$c25844f0$ec8818ac@ent.ti.com>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-reply-to: <00b901c81701$c25844f0$ec8818ac@ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Sameer' <x0081444@ti.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

Umm it's not easy to set the right values for OneNAND and GPMC.
It's dependent on Memory clock in GPMC and OneNAND chips
For instance, the Apollon & n800 has the same device, but the memory timing values are different.
So I recommend that you first use the n800 values and fix it for your targets
Maybe you need the logic analyzer to see the timing.

Thank you,
Kyungmin Park

 
> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-open-source-
> bounces@linux.omap.com] On Behalf Of Sameer
> Sent: Thursday, October 25, 2007 9:23 PM
> To: linux-omap-open-source@linux.omap.com
> Subject: Onenand sync burst mode - query
> 
> Hi,
> I am working on onenand driver based on omap board.
> Onenand is samsung onenand. I need to add the functionality for
> Synchronous burst mode operation which is currently not present.
> I am refering n800 board driver (arch/arm/mach-omap/board-n880-flash.c)
> The function "omap2_onenand_set_sync_mode" contains the variable "fclk_offset_ns"
> 
> I am not able to relate this variable with the timing diagram of the onenand flash
> Could any body specify the significance of this variable and how is it related to
> the timing variables?
> 
> Thanks,
> -Sameer
> 
> 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
