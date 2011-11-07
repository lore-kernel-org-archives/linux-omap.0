From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] arm: omap2+: hwmod: fix breakage introduced by d6504acd
Date: Mon, 7 Nov 2011 15:27:13 -0800
Message-ID: <20111107232713.GD31337@atomide.com>
References: <1320688617-4543-1-git-send-email-balbi@ti.com>
 <20111107183208.GG15294@n2100.arm.linux.org.uk>
 <20111107193908.GA5059@legolas.emea.dhcp.ti.com>
 <20111107212707.GH15294@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1111071428001.12394@utopia.booyaka.com>
 <20111107224129.GJ15294@n2100.arm.linux.org.uk>
 <20111107225157.GB31337@atomide.com>
 <20111107225529.GK15294@n2100.arm.linux.org.uk>
 <20111107230728.GC31337@atomide.com>
 <20111107231632.GL15294@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111107231632.GL15294@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111107 14:41]:
> On Mon, Nov 07, 2011 at 03:07:28PM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [111107 14:20]:
> > > On Mon, Nov 07, 2011 at 02:51:57PM -0800, Tony Lindgren wrote:
> > > > Here's what I got. Looks like the removal of the sr[12]_hwmod
> > > > part is no longer needed, so only the r value check part is needed.
> > > 
> > > Err.  So do you have anything in your git tree which you're pushing out
> > > this evening which removes the sr[12]_hwmod from the omap_3xxx_hwmod
> > > list?
> > > 
> > > If not, how does that bug get fixed in mainline?
> > 
> > Ah sorry, there's also the following commit there that deals
> > with other related issues:
> 
> Great, so it looks like everything that I've found over the last two days
> should be solved completely by what you have queued for Arnd.

OK good to hear.

> One last issue though...
> 
> We had this patch:
> 
> http://lists.arm.linux.org.uk/lurker/message/20111006.232441.227dfcf6.en.html
> 
> which is from Paul, post my complaint about IS_ERR_VALUE being used.
> This removed sr1_hwmod and sr2_hwmod, and the commit message explicitly
> talks about doing this.
> 
> There's also the patch below.  Somehow, this resulted in that bit of
> Paul's patch being removed (possibly automatically by git) but the commit
> comments are retained, which are now stale and no longer reflect what the
> patch is doing...  That's rather unfortunate, but at this point its
> probably too late to do something about it.

Yeah that's a bit unfortunate. At least the commit message mentions
what it fixes, and then mentions the secondary bug related to the
sr[12]_hwmod entries. Anyways, I'd rather not start messing with commit
unless people think it's worth rebasing about half of the patches
in fixes.

Regards,

Tony
