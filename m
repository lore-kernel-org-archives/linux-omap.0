From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] dmaengine: edma: Remove dynamic TPTC power management
 feature
Date: Thu, 28 Jan 2016 09:11:46 -0800
Message-ID: <20160128171146.GC19432@atomide.com>
References: <1453885906-17652-1-git-send-email-peter.ujfalusi@ti.com>
 <20160127155422.GH19432@atomide.com> <56A9D8C2.7000401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <56A9D8C2.7000401@ti.com>
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
Cc: vinod.koul@intel.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, t-kristo@ti.com, dmaengine@vger.kernel.org, dan.j.williams@intel.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160128 01:01]:
> On 01/27/2016 05:54 PM, Tony Lindgren wrote:
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [160127 01:12]:
> >> The dynamic or on demand pm_runtime does not work correctly on am335x and
> >> am437x due to interference with hwmod.
> > 
> > Hmm care expand a bit what is the problem with this "interference"?
> 
> The idea was to enable/power on only the TPTCs which is actually in use and
> leave the unused ones off. Which is is nice and all, but...
> The original implementation did the pm_runtime calls for the tptcs from the
> edma tpcc driver instance and the main issue was that I did the pm_runtime
> calls in the edma-tpcc pm callbacks as well.
> Since omap hwmod/device also handles pm_runtime on behalf of the drivers we
> got nasty issues, kernel crash, warnings on suspend/resume.
> 
> Then I did implemented the on demand power management in a totally different
> way, still keeping only tptcs enabled which is in use.
> In this way all the omap hwmod/device incoherency was gone and things looked
> fine, but it turned out that on second suspend we are not able to wake up the
> board.
> I and Tero debugged this a bit and it turns out that we need to kepp all tptcs
> enabled and powered, otherwise the HW will not going to be able to complete
> the transition, breaking suspend/resume.

Probably you only need to keep the tptcs being used enabled though? They
should be completely independent otherwise?

> With pm_runtime_enable() + get_sync() on all tptcs we can suspend and resume
> w/o problems and they will be disabled/enabled by omap hwmod/device code,
> following nicely the power state of the system.
> 
> As a note: I did tried the suspend/resume with the old code with dra7, but it
> turned out that on dra7 SW has no control over the tptc power state, it
> follows the system in HW.
> 
> In short: The implementation was flawed and even if the implementation is
> correct the HW will lock up if we do on demand tptc power management.

OK interesting.

Regards,

Tony
