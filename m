From: Tony Lindgren <tony@atomide.com>
Subject: Re: Updated mach-types update
Date: Thu, 24 Mar 2011 10:59:45 -0700
Message-ID: <20110324175945.GV2811@atomide.com>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
	<20110320114137.GD16646@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110320114137.GD16646@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arun C <arunedarath@mistralsolutions.com>, Subhasish Ghosh <subhasish@mistralsolutions.com>, linux-omap@vger.kernel.org, Srinath <srinath@mistralsolutions.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110320 04:39]:
> On Sun, Mar 20, 2011 at 11:03:22AM +0000, Russell King - ARM Linux wrote:
> 
> Note that OMAP references machine_is_omap2evm() yet this has never been
> merged.
> 
> arch/arm/plat-omap/include/plat/uncompress.h:
> 
>                 DEBUG_LL_OMAP2(1, omap2evm);
> 
> so this entry needs to be removed.

Hmm looks like we have LCD support and ASoC support for it, but no
board :)

Anybody working with this board?

If so, please send patches for the related board-*.c support ASAP.
Otherwise let's plan on deleting the related support.

Regards,

Tony
