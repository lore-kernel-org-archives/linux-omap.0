From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 05/16] ARM: omap: fix vc.c PMIC error message
Date: Thu, 9 Feb 2012 16:49:13 +0000
Message-ID: <20120209164913.GB19159@n2100.arm.linux.org.uk>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAWP-0006H3-1A@rmk-PC.arm.linux.org.uk>
 <20120208184539.GE29796@atomide.com> <87ty312ae0.fsf@ti.com>
 <20120208235358.GD16877@atomide.com>
 <20120208235620.GE25414@n2100.arm.linux.org.uk> <87sjikx3xv.fsf@ti.com>
 <20120209001135.GF25414@n2100.arm.linux.org.uk> <87ipjgx3g3.fsf@ti.com>
 <20120209004027.GF16877@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20120209004027.GF16877@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 08, 2012 at 04:40:27PM -0800, Tony Lindgren wrote:
> * Kevin Hilman <khilman@ti.com> [120208 15:49]:
> > Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > 
> > > On Wed, Feb 08, 2012 at 04:09:48PM -0800, Kevin Hilman wrote:
> > >> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> > >> > Does it fix the other issues I mention in the commit log as well?
> > >> 
> > >> Like your patches 1 & 5, my series fixes the oops and also makes the
> > >> error strings simple, non-wrapping ones.
> > >> 
> > >> The one thing it doesn't fix is the spelling typo you fixed in the
> > >> comment, but IMO we can leave that out for -rc.
> > >
> > > OK, but it would be much better for that simple fix to go with another
> > > simple patch.  On its own it doesn't make sense as a commit.
> > 
> > Agreed.  We'll have some other VC/VP cleanup for v3.4, and I'll add this
> > into that cleanup.
> 
> Eek, looking at it, I'd rather stay away from this formatting patch
> for -rc series because the flaming potential causes me rash!
> 
> Russell's patch 5 has way better description for the -rc series.
> 
> So I now suggest that Russell drops patch 1 and updates patch 5 to
> cover both vp.c and vc.c.

I'm not sure what you want me to update in patch 5.  vp.c already
contains:

        if (!voltdm->pmic) {
                pr_err("%s: No PMIC info for vdd_%s\n", __func__, voltdm->name);
                return;
        }

which is where I got the idea for the message I put into vc.c.

> d269914ece0498f31603ecd85ed3d7a586b3cbcd ARM: OMAP2+: PM: only register TWL with voltage layer when device is present
> af9a2ed9667b49e7e125eac526d8f655183ce53e ARM: OMAP2+: voltage: add check for missing PMIC info in VP init

I'd like at least the first in my tree too, otherwise my stuff becomes
untestable without patch 1.  What's the second doing?
