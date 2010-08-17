From: srinidhi <srinidhi.kasagar@stericsson.com>
Subject: Re: [PATCH 4/4] omap: Fix SMP on UP interrupt handling for multi-omap
Date: Tue, 17 Aug 2010 16:37:49 +0530
Message-ID: <1282043269.32205.13.camel@bnru01>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	<20100817105332.19061.44765.stgit@baageli.muru.com>
Reply-To: srinidhi.kasagar@stericsson.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100817105332.19061.44765.stgit@baageli.muru.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>
List-Id: linux-omap@vger.kernel.org

On Tue, 2010-08-17 at 12:53 +0200, Tony Lindgren wrote:
> Fix SMP on UP interrupt handling for multi-omap
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/include/mach/entry-macro.S |   22 ++++++++++++++++++++++
>  arch/arm/mach-omap2/omap-smp.c                 |   16 ++++++++++++----
>  arch/arm/mach-omap2/timer-gp.c                 |    7 +++++--
>  3 files changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
> index 06e64e1..75c67aa 100644
> --- a/arch/arm/mach-omap2/include/mach/entry-macro.S
> +++ b/arch/arm/mach-omap2/include/mach/entry-macro.S

There is one patch lying in Russell's tracker (6284/1) which attempts to
use the common IRQ helper macros instead of platforms duplicating this
file. Perhaps you may need to re-base to that if Russell is ok with that
patch, of course.

srinidhi
