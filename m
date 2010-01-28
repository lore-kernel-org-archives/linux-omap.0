From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 0/5] Arm Gic Changes
Date: Thu, 28 Jan 2010 00:39:14 +0000
Message-ID: <20100128003914.GM9153@trinity.fluff.org>
References: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: adharmap@codeaurora.org
Cc: Kalle Valo <kalle.valo@iki.fi>, Alessandro Rubini <rubini@unipv.it>, Russell King <linux@arm.linux.org.uk>, Linus Walleij <linus.walleij@stericsson.com>, Jean Pihet <jpihet@mvista.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Andrea Gallo <andrea.gallo@stericsson.com>, Colin Tuckley <colin.tuckley@arm.com>, Ingo Molnar <mingo@elte.hu>, linux-omap@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Philby John <pjohn@in.mvista.com>, linux-arm-kernel@lists.infradead.org, Abhijeet Dharmapurikar <adharmap@quicinc.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 27, 2010 at 11:32:24AM -0800, adharmap@codeaurora.org wrote:
> From: Abhijeet Dharmapurikar <adharmap@quicinc.com>
> 
> Few fixes and improvements to arch/arm/common/gic.c file.

both ARM and GIC in the title should be all in capitals, they are
abbreviations of something longer.

I think it would be nicer to make GIC in all the patch titles all capital
instead of all lower case.
 
> Abhijeet Dharmapurikar (5):
>   gic: prevent gic from crossing NR_IRQ
>   gic: add callback for mask_ack
>   gic: Add set_type callback
>   gic: dont disable INT in ack callback
>   gic: initialize interrupts as per argument
> 
>  arch/arm/common/gic.c                    |  114 ++++++++++++++++++++++++-----
>  arch/arm/include/asm/hardware/gic.h      |    3 +-
>  arch/arm/mach-omap2/board-4430sdp.c      |    3 +-
>  arch/arm/mach-realview/realview_eb.c     |   10 ++-
>  arch/arm/mach-realview/realview_pb1176.c |    7 ++-
>  arch/arm/mach-realview/realview_pb11mp.c |    7 ++-
>  arch/arm/mach-realview/realview_pba8.c   |    4 +-
>  arch/arm/mach-realview/realview_pbx.c    |    5 +-
>  arch/arm/mach-ux500/cpu-u8500.c          |    2 +-
>  9 files changed, 122 insertions(+), 33 deletions(-)
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
