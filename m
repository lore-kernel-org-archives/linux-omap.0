From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 0/4] OMAP4: Add modulemode support to hwmod framework
	(part 2)
Date: Fri, 8 Jul 2011 01:45:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107080142090.24181@utopia.booyaka.com>
References: <1309557267-27165-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1309557267-27165-1-git-send-email-b-cousson@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> Here is the second part of the modulemode series. 
> The goal here is to do the cleanup on the clock nodes and PRCM macros
> that are not needed anymore by the hwmod data.
> Some macros are still needed because of clock data. It should be removed
> once the clock data will be cleaned.
> 
> Since the MMC pm_runtime is done, we can drop the TEMP hacks.
> 
> The series is based on for_3.1/6_hwmod_clkdm_fixes and tested
> on OMAP4430 ES2.1 + SDP. It should not affect OMAP2 & 3, but some testing
> are definitively needed.
> 
> The patches are available here:
> git://gitorious.org/omap-pm/linux.git for_3.1/7_hwmod_modulemode

At this point, these don't seem like 3.1 material, mostly because this 
series removes main_clk entries.  This is going to cause problems 
retrieving the main_clk clockdomain, since the patch to retrieve it from 
the hwmod clkdm was dropped due to OMAP2/3 breakage.  Also, we should 
probably discuss whether there are additional implications to removing a 
module's main_clk, as opposed to setting it to a clock tree node closer to 
the root.


- Paul
