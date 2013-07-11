From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: twl-common: Remove code for twl6030 and
 twl6040 setup for legacy boot
Date: Thu, 11 Jul 2013 09:59:16 -0500
Message-ID: <20130711145916.GA6138@kahuna>
References: <1373552638-13930-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1373552638-13930-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 16:23-20130711, Peter Ujfalusi wrote:
> OMAP4 no longer boots in legacy mode so the code here is no longer used.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  arch/arm/mach-omap2/twl-common.c | 332 ++-------------------------------------
>  arch/arm/mach-omap2/twl-common.h |   8 -
>  2 files changed, 12 insertions(+), 328 deletions(-)
Could we modify the Makefile and build twl-common.o only for
CONFIG_ARCH_OMAP3?

We could get rid of all the #ifdef from the code that way. OMAP3 is the
only platform that still depends on this - Further, with this change,

commit 34a38440689b06a515104d668494e0ff8a4e1537
(regulator: twl6030: add support for vdd1, vdd2 and vdd3 regulators)
will need a relook as well. currently part of the discussion with Mark
in [1]


[1] http://marc.info/?t=137185016300003&r=1&w=2


-- 
Regards,
Nishanth Menon
