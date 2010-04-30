From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 02/14] omap: Make uncompress code and DEBUG_LL code generic
Date: Fri, 30 Apr 2010 08:07:02 -0700
Message-ID: <1272640022.3051.1534.camel@localhost>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
	<20100126201239.15382.34792.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20100126201239.15382.34792.stgit-XB442sTQ5VIxQTnqJstS8Q@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Cc: DaVinci list <Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

[resend to include RMK]

On Tue, 2010-01-26 at 12:12 -0800, Tony Lindgren wrote:
> Define arch_decomp_setup() the same way as some other
> architectures do. Use arch_id to configure the debug uart
> based on the machine_is by storing it into the uart
> scratchpad register for DEBUG_LL code to use.
> 
> Note that to avoid merge conflicts, this patch is using
> hardcoded register r1 until tmp register is being passed
> for all addruart macros.

This patch (now in mainline[1]) has been working well, but has a couple
serious limitations:

1. assumes bootloader has enabled UART1 clocks
2. assumes all OMAPs supported have the same UART1 base

With more platforms using USB-based UARTs, assumption (1) may not be
safe for very long, as bootloaders for these platforms don't really
*need* to enable UART1.  Currently, they happen to mainly because of
copied init code from other platforms. 

But more importantly, there are more OMAP derivative parts coming soon,
and one in particular coming soon[2] breaks assumption 2 by having a
different UART1 base (yes, it's branded as a DaVinci, but it's an OMAP
core as far as linux is concerned.  Don't get me started on TI
branding.)

To fix both problems, maybe we should just use a fixed memory location
to pass this temporary data from uncompress to the kernel.  We've had a
similar problem on DaVinci recently and a proposal has been made (and
tested) to use memory just below the page tables[3].)

Any comments on this proposal?  or alternative suggestions?

Kevin

[1] commit 0c8219f0302d0d27fda52c790d38406801e547ec
[1] http://www.ti.com/ww/en/dsp/davinci-netra/index.shtml
[2] https://patchwork.kernel.org/patch/94724/
