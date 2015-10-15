From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/3] ARM: catch pending imprecise abort on unmask
Date: Thu, 15 Oct 2015 09:23:07 -0700
Message-ID: <20151015162307.GP10113@atomide.com>
References: <1444905142-21500-1-git-send-email-l.stach@pengutronix.de>
 <1444905142-21500-2-git-send-email-l.stach@pengutronix.de>
 <20151015153246.GH32536@n2100.arm.linux.org.uk>
 <20151015153915.GO10113@atomide.com>
 <20151015160631.GI32536@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151015160631.GI32536@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, linux-omap@vger.kernel.org, patchwork-lst@pengutronix.de, linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [151015 09:11]:
> On Thu, Oct 15, 2015 at 08:39:15AM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [151015 08:37]:
> > > On Thu, Oct 15, 2015 at 12:32:20PM +0200, Lucas Stach wrote:
> > > > Install a non-faulting handler just before unmasking imprecise aborts
> > > > and switch back to the regular one after unmasking is done.
> > > > 
> > > > This catches any pending imprecise abort that the firmware/bootloader
> > > > may have left behind that would normally crash the kernel at that point.
> > > > As there are apparently a lot of bootlaoders out there that do such a
> > > > thing it makes sense to handle it in the common startup code.
> > > > 
> > > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > 
> > > Much better.  Please feel free to add it to the patch system, thanks.
> > > 
> > > I think, given that the original seems to be breaking platforms, this
> > > patch needs to go into -rc kernels, right?
> > 
> > Hmm do we still see a trace where the issue happened though with this
> > one?
> 
> That's not the intention of this specific patch.
> 
> This is solely to detect the bootloader induced imprecise exception,
> nothing more.  A backtrace for that won't be useful in any shape or
> form - in fact, the backtrace will be well known (it'll be from the
> site where the imprecise exceptions are unmasked.)
> 
> Any imprecise exception which happens after this will be handled in
> the normal way: it'll raise a kernel oops, and that will have all the
> details that a kernel oops normally has.

OK makes sense.

> The difference is, rather than the boot loader provoking the kernel to
> oops at this point, we're able to report the event and continue on.

OK

Tony
