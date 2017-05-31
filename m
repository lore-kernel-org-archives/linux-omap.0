From: Tony Lindgren <tony@atomide.com>
Subject: Re: [CFT] Always enable SMP mode on MP capable CPUs
Date: Wed, 31 May 2017 08:07:53 -0700
Message-ID: <20170531150752.GE3730@atomide.com>
References: <20170519171526.GW22219@n2100.armlinux.org.uk>
 <20170524153847.GY10472@atomide.com>
 <20170525144800.GV23750@n2100.armlinux.org.uk>
 <20170525151103.GC10472@atomide.com>
 <20170525180540.GW23750@n2100.armlinux.org.uk>
 <20170525221332.GE10472@atomide.com>
 <20170526112210.GA3354@afzalpc>
 <20170527132237.GX23750@n2100.armlinux.org.uk>
 <20170531143914.GD3730@atomide.com>
 <20170531145924.GY23750@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170531145924.GY23750@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Fabio Estevam <festevam@gmail.com>, linux-omap@vger.kernel.org, afzal mohammed <afzal.mohd.ma@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@armlinux.org.uk> [170531 08:03]:
> On Wed, May 31, 2017 at 07:39:15AM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@armlinux.org.uk> [170527 06:26]:
> > > On Fri, May 26, 2017 at 04:52:10PM +0530, afzal mohammed wrote:
> > > > Hi,
> > > > 
> > > > On Thu, May 25, 2017 at 03:13:33PM -0700, Tony Lindgren wrote:
> > > > 
> > > > > OK so got my am437x-idk back
> > > > > 
> > > > > And as suspected it won't boot with these changes.
> > > > 
> > > > Tested here too with your additional changes included & seeing same
> > > > behavior here as well on AM437x.
> > > > 
> > > > As an aside, when Russell posted this patch a week back itself was
> > > > suspecting this. i had a certain view on AM437x w.r.t SMP issue back
> > > > while officially working on it & since now not officially involved
> > > > with the issue at hand, i was uncomfortable dealing with this. But as
> > > > Russell's patch was not noticed by others w.r.t AM437x, upon being
> > > > able to confirm it yesterday, i at least wanted to bring it to notice
> > > > & runaway from the scene.
> > > 
> > > Right, so I think the summary is: the kernel can't set the SMP bit
> > > correctly - it doesn't have the information at this point in time
> > > to know definitively whether the bit needs to be set or not.
> > > 
> > > So, those who are suffering issues with their SMP cores in uniprocessor
> > > systems need to ensure that their boot loader correctly configures the
> > > CPU cores.
> > 
> > Russell, current Linux next still has commit e7cf836e9757 ("ARM:
> > always enable SMP mode on SMP cores"). You're planning to drop
> > it, right?
> 
> Please have some patience.
> 
> Correct, it should be gone from tonight's linux-next.
> 
> The UK has two holidays in May, one of them was this Monday.  I dropped
> the patch yesterday, which is the first opportunity since sending that
> mail, but due to other pressures yesterday, my tree was in no state to
> be pushed out for linux-next's grab last night.

OK thanks for confirming!

Tony
