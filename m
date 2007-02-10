From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] - Fix MMC -- was  H4 boot with latest git kernel
Date: Sat, 10 Feb 2007 09:41:22 -0800
Message-ID: <20070210174121.GA5291@atomide.com>
References: <5d5443650702090324g6048af71u17f20a55f823edda@mail.gmail.com>
	<20070209165157.GB22121@atomide.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429509132@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429509132@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [070209 13:48]:
> Hi,
> 
> So took a quick look with the emulator and see its hanging in MMC.  I'm
> not an MMC expert but I don't see how you can send an init-stream
> command with no clocks running and if you did it looks like it should be
> 80clocks over 1ms.
> 
> The note in the upper layer in mmc.c says you power it first, then send
> clocks out.  mmc.c calls MMC_POWER_UP twice.  The first time with
> ios->clock = 0 and a second time with iso->clock=f_min.  To me that just
> says set the power bit in the first pass and set the initstream command
> in the second pass.
> 
> The below patch seems to work fine and would appear to be a long
> standing bug.
> 
> Signed-off-by: Richard Woodruff <r-woodruff2.com>
> 
> diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
> index 796172a..55075cc 100644
> --- a/drivers/mmc/omap.c
> +++ b/drivers/mmc/omap.c
> @@ -990,7 +990,7 @@ static void mmc_omap_set_ios(struct mmc_
>  	 * Writing to the CON register twice seems to do the trick. */
>  	for (i = 0; i < 2; i++)
>  		OMAP_MMC_WRITE(host, CON, dsor);
> -	if (ios->power_mode == MMC_POWER_UP) {
> +	if ((ios->power_mode == MMC_POWER_UP) && ios->clock) {
>  		/* Send clock cycles, poll completion */
>  		OMAP_MMC_WRITE(host, IE, 0);
>  		OMAP_MMC_WRITE(host, STAT, 0xffff);
> 

Thanks. Looks like we're still doing the MMC powerup wrong for omap
though. I made a patch for that a while back but it got forgotten
for some reason:

http://lkml.org/lkml/2006/5/4/44

I'll refresh that patch so we can make sure it works on all platforms.

Regards,

Tony
