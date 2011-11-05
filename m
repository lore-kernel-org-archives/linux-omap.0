From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ARM: OMAP3: Fix dependencies for OMAP3_EMU
Date: Sat, 5 Nov 2011 18:51:04 +0100
Message-ID: <201111051851.04879.arnd@arndb.de>
References: <1320512279-9032-1-git-send-email-weber@corscience.de>
	<20111105160020.GA15294@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111105160020.GA15294@n2100.arm.linux.org.uk>
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
Cc: tony@atomide.com, Thomas Weber <weber@corscience.de>, "open list:OMAP SUPPORT" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:ARM PORT" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Saturday 05 November 2011, Russell King - ARM Linux wrote:
> On Sat, Nov 05, 2011 at 05:57:59PM +0100, Thomas Weber wrote:
> > This patch fixes the dependencies for OMAP3_EMU after
> > commit 53eebb0df85e4005
> > ARM: OC_ETM should not select ARM_AMBA
> > 
> > When "OMAP3 debugging peripherals" is selected the warning:
> > (OMAP3_EMU) selects OC_ETM which
> > has unmet direct dependencies (ARM_AMBA)
> 
> There is a patch from Arnd addressing this which was sent in October.
> It was acked by Santosh and Tony.  What happened to it?

I haven't gotten around to put the omap patches I sent earlier into
a branch yet, with too much travelling over the last weeks.

Right now, I'm mostly worried about regression fixes for stuff that
broke in the merge window, but the patches are not lost yet and
I'll get to that next, possibly only after I return from my vacation
in a week.

	Arnd
