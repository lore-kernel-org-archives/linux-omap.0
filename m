From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: linux-next: origin tree build failure
Date: Wed, 16 Dec 2009 10:30:54 +0100
Message-ID: <20091216093054.GB3788@sortiz.org>
References: <20091215164108.45c9d766.sfr@canb.auug.org.au>
 <20091215145344.GA30710@sirena.org.uk>
 <20091215172717.GF4575@atomide.com>
 <20091216094541.e59d36fa.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091216094541.e59d36fa.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Linus <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Stephen,

On Wed, Dec 16, 2009 at 09:45:41AM +1100, Stephen Rothwell wrote:
> Hi Tony,
> 
> On Tue, 15 Dec 2009 09:27:17 -0800 Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Mark Brown <broonie@opensource.wolfsonmicro.com> [091215 06:52]:
> > > On Tue, Dec 15, 2009 at 04:41:08PM +1100, Stephen Rothwell wrote:
> > > 
> > > > I have applied this patch for today (please check):
> > > 
> > > Looks good to me too, fwiw:
> > > 
> > > Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > 
> > Good thing we have for-next to catch things like this.
> 
> Except if the renaming patch had gone through linux-next (even for one
> day) we would have found the problem *before* it was in Linus' tree ...
Mea maxima culpa. I could come up with several reason why I rushed this patch
in, but none of them would be good. I apologize here.


> (/me is a little grumpy :-))
I understand, sorry again.

Cheers,
Samuel.


> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/



-- 
Intel Open Source Technology Centre
http://oss.intel.com/
