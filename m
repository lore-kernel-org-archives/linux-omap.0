From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: board-omap3evm: add required smsc911x regulators
Date: Fri, 10 Feb 2012 14:53:41 -0800
Message-ID: <20120210225340.GB21865@atomide.com>
References: <1328738812-26755-1-git-send-email-mporter@ti.com>
 <20120210174046.GQ1426@atomide.com>
 <20120210185033.GC40045@h115-84.vpn.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20120210185033.GC40045@h115-84.vpn.ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Matt Porter <mporter@ti.com>
Cc: linux-omap@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Matt Porter <matt@ohporter.com>
List-Id: linux-omap@vger.kernel.org

* Matt Porter <mporter@ti.com> [120210 10:19]:
> On Fri, Feb 10, 2012 at 09:40:47AM -0800, Tony Lindgren wrote:
> > * Matt Porter <matt@ohporter.com> [120208 13:35]:
> > > This fixes smsc911x support on omap3evm that has been broken since
> > > the smsc911x driver was updated to require the existence of vdd33a
> > > and vddvario supplies.
> > 
> > Great. Few comments:
> > 
> > 1. Could you please include the smsc911x commit and subject here too
> >    so it clearly shows the regression?
> 
> Sure. Will do for v2.
> 
> > 2. Also, why don't you add this fixed regulator to gpmc-smsc911.c?
> > 
> > That way it gets fixed for other too, like zoom2/3.
> 
> Ok, so I considered that at first and had two concerns that made me just
> do it in the omap3evm specific way and see what the feedback was.
> 
> 1) If we do a generic implementation in gpmc-smsc911x.c, there needs to
> be a way to override it. Another board may have a variable supply that
> feeds this consumer.
> 
> 2) Technically, this omap3evm specific implementation matches the hardware
> in that the osk_3v3 rail is software controllable. Granted, I commented
> that we simply don't hook up the gpio at this time since this real
> hardware regulator has always been silently asserted on by the nature of
> the reset state of the TWL GPIOs and the board level pull downs as well.

OK
 
> So that said, I don't need #2 to make omap3evm work and I don't think
> anybody cares yet to actually turn that regulator off (as it will kill
> other things that appear to not have regulator support anyway). It looks
> like you talked me into respinning it as a generic implementation. Only
> question is whether I should bother consider not-yet-existing boards that
> may not want that generic regulator.

Well for future boards the regulator should come from device tree,
so for now it should be safe to add it to gpmc-smsc911.c.

Regards,

Tony
