From: Tony Lindgren <tony@atomide.com>
Subject: Re: 2.6.21-rc1 merge status
Date: Tue, 20 Feb 2007 01:20:10 -0800
Message-ID: <20070220092009.GD14954@atomide.com>
References: <45D892A1.9040006@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <45D892A1.9040006@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Dirk Behme <dirk.behme@googlemail.com> [070218 09:54]:
> 
> 2) Merging our OMAP patches via Russells patch system to 
> mainline failed [2]. There was some background discussion 
> between Tony, Russell and Andrew how to merge our patches in 
> last week. Tony sent some updated patches based on Russells 
> comments, but it was too much for Russell for a proper 
> review. Russell mentioned ~17klines of changes.

Yes, it's a big pile of patches :)
 
> Now, we have to find a proper way how to get our (at the 
> moment) large changes merged upstream. Looks like getting 
> everything merged in the usual two week merge window isn't 
> possible. First we should remove our patchset from Russells 
> incoming queue and then discuss how to go on.

Yeah, Andrew Morton suggested that we post the linux-omap patch series
to appropriate mailing lists for larger review. I will post the patch
series to LKML few weeks before 2.6.22 opens for review, and will also
notify the linux-arm-kernel list asking for people to comment on it.

There are some patches that can be already sent as fixes against
2.6.21-rxX, so that will cut down the size of the patch series a bit.

As we're trying to have all the core omap code in sync with mainline
kernel, I'd like to start using branches in our linux-omap tree to
make things easier.

Here's what I see working pretty nicely with branches in linux-omap tree:

Linus' mainline tree
\
 omap-fixes                            (Fixes for 2.6.21-rcX)
           \
            omap-upstream              (Queue for when 2.6.22 opens) 
                         \
                          omap-drivers (Patches to send to driver lists)
                                      \
                                       linux-omap (Non mergeable hacks)
 
So to checkout the current linux-omap tree, you would just use
"git-checkout linux-omap" instead of checking out the master branch as
we currently do.

This way we can easily rebase the branches against the mainline tree
using git-rebase command. Please also note that we can add other temporary
branches between the branches above if necessary.

I'll try to set this up this week to try it out, and then we can
change over to it next week assuming there are no problems.

Regards,

Tony
