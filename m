From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/3] ARM: catch pending imprecise abort on unmask
Date: Thu, 15 Oct 2015 08:39:15 -0700
Message-ID: <20151015153915.GO10113@atomide.com>
References: <1444905142-21500-1-git-send-email-l.stach@pengutronix.de>
 <1444905142-21500-2-git-send-email-l.stach@pengutronix.de>
 <20151015153246.GH32536@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20151015153246.GH32536@n2100.arm.linux.org.uk>
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

* Russell King - ARM Linux <linux@arm.linux.org.uk> [151015 08:37]:
> On Thu, Oct 15, 2015 at 12:32:20PM +0200, Lucas Stach wrote:
> > Install a non-faulting handler just before unmasking imprecise aborts
> > and switch back to the regular one after unmasking is done.
> > 
> > This catches any pending imprecise abort that the firmware/bootloader
> > may have left behind that would normally crash the kernel at that point.
> > As there are apparently a lot of bootlaoders out there that do such a
> > thing it makes sense to handle it in the common startup code.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Much better.  Please feel free to add it to the patch system, thanks.
> 
> I think, given that the original seems to be breaking platforms, this
> patch needs to go into -rc kernels, right?

Hmm do we still see a trace where the issue happened though with this
one?

What I though wes something pending from the bootloader, turned out
to be a bogus SRAM init code that I was able to easily fix with the
trace.

Regards,

Tony
