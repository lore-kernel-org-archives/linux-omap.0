From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix checking for multiple boot tags in board config.
Date: Mon, 15 May 2006 02:44:11 -0700
Message-ID: <20060515094410.GH8368@atomide.com>
References: <20060407150028.GT22929@earth.li>
	<1144425015.19066.20.camel@bitbox.mine.nu>
	<20060407155818.GV22929@earth.li>
	<1144483132.19066.29.camel@bitbox.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1144483132.19066.29.camel@bitbox.mine.nu>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Imre Deak <imre.deak@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Imre Deak <imre.deak@nokia.com> [060408 01:04]:
> On Fri, 2006-04-07 at 16:58 +0100, ext Jonathan McDowell wrote:
> > On Fri, Apr 07, 2006 at 06:50:15PM +0300, Imre Deak wrote:
> > > On Fri, 2006-04-07 at 16:00 +0100, ext Jonathan McDowell wrote:
> > > > Currently if we look for more than one instance of a boot tag and it's
> > > > defined in the board config rather than passed by the boot loader we can
> > > > get stuck in a loop where the same tag is processed many times. This can
> > > > be seen with the gpio-switch driver, for example. The patch below fixes
> > > > this by respecting the skip parameter to get_config when we're scanning
> > > > the board config structure.
> > > > 
> > > > Signed-Off-By: Jonathan McDowell <noodles@earth.li>
> > > > 
> > > > diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
> > > > index 0625df5..39ab667 100644
> > > > --- a/arch/arm/plat-omap/common.c
> > > > +++ b/arch/arm/plat-omap/common.c
> > > > @@ -114,8 +114,12 @@ static const void *get_config(u16 tag, s
> > > >  	 * in the kernel. */
> > > >  	for (i = 0; i < omap_board_config_size; i++) {
> > > >  		if (omap_board_config[i].tag == tag) {
> > > > -			kinfo = &omap_board_config[i];
> > > > -			break;
> > > > +			if (skip == 0) {
> > > > +				kinfo = &omap_board_config[i];
> > > > +				break;
> > > > +			} else {
> > > > +				skip--;
> > > > +			}
> > > >  		}
> > > >  	}
> > > >  	if (kinfo == NULL)
> > > 
> > > Should the case be handled when a configuration is present in both the
> > > boot tag and the board config? If so, we should stop parsing after the
> > > boot tags whenever the requested tag is found, even if there are less
> > > then 'skip' instances of it, and return NULL.
> > 
> > If a config option that can appear multiple times (ie when the skip
> > option would apply) is present in both the boot tag and board config I'd
> > expect both to have effect. You might have some instances of a device
> > that exist on all variants of the board (that would be in the board
> > config) and then some additional instances that would be controlled by
> > the boot tags passed by the boot loader. Though equally I can see the
> > argument for the other way when you'd want to override the defaults. :)
> > 
> 
> Ok, I didn't consider the semantic where we merge the two
> configurations. And since it was the implied behavior so far, fixing it
> with your patch seems to be the right thing.

Pushing this today.

Tony
