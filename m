From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] OMAP: Adding Support for 2K nand page support for
	omap2430
Date: Fri, 10 Aug 2007 03:43:27 -0700
Message-ID: <20070810104326.GX8658@atomide.com>
References: <809D758398CC1F49AA8E493528AD4A27014DF6AE@ntxsjombx02.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <809D758398CC1F49AA8E493528AD4A27014DF6AE@ntxsjombx02.micron.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: sshahrom@micron.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* sshahrom@micron.com <sshahrom@micron.com> [070727 10:18]:
> Hi,
> Continuing with rest of the patch series on linux.omap.com. 
> 
> 
> Signed-off-by: Shahrom Sharif-Kashani <sshahrom@micron.com>
> 
> 
> :000000 100644 0000000... 8ec2004... A	drivers/mtd/nand/omap2.c
> :000000 100644 0000000... 051d7d9... A	include/asm-arm/arch-omap/nand.h
> 
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> new file mode 100644
> index 0000000..8ec2004
> --- /dev/null
> +++ b/drivers/mtd/nand/omap2.c

<snip>

Could this be merged with omap-nand-flash.c?

Regards,

Tony
