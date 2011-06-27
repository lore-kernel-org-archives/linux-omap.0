From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 06/10] omap2+: Remove gptimer_wakeup for now
Date: Mon, 27 Jun 2011 01:08:05 -0700
Message-ID: <20110627080804.GG23145@atomide.com>
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092341.357.14183.stgit@kaulin> <4DFF1558.4020509@ti.com>
	<20110620094846.GG23145@atomide.com> <87oc1obnbw.fsf@ti.com>
	<4E035835.50405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4E035835.50405@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110623 08:09]:
> On 6/23/2011 8:35 PM, Kevin Hilman wrote:
> >Tony Lindgren<tony@atomide.com>  writes:
> >
> >So now, the only thing OMAP-specific is the debugfs file used to trigger
> >it.
> >
> >>Maybe Kevin can just carry it along in the PM branch for now?
> >
> >I'd prefer to keep it in mainline as this is a very important feature
> >for the PM functionality already in mainline.
> >
> I agree with Kevin and that's what have been saying from begining when
> we decided to drop this feature. The new patch from Kevin is already
> doing this in more generic way than that was before.

To me Kevin's later patch makes more sense, but still has few issues:

- It keeps the dependency between PM debug code and sys_timer code.
  That's yet another artificial blocker for making PM code a loadable
  module. We really don't want to export anything from the sys_timer code.

- The interface for programming a wake-up timer should be Linux generic,
  not omap specific.

Further, it's a CONFIG_PM_DEBUG patch. So that code should not be
in the mainline kernel.

Regards,

Tony
