From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Re-add a lost TSC2102 touchscreen Kconfig entry
Date: Wed, 23 May 2007 08:41:00 -0700
Message-ID: <20070523154059.GE26513@atomide.com>
References: <fb249edb0705221022s5bec31d4r77bfc16373262b4e@mail.gmail.com>
	<200705221640.51098.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200705221640.51098.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070522 16:42]:
> On Tuesday 22 May 2007, andrzej zaborowski wrote:
> > The TSC2102 option in drivers/input/touchscreen/Kconfig got lost
> > somewhere in January (although the commit is not visible in git-web),
> > so adding it back. 
> 
> I noticed that ...

The git automerge has been causing issues... And I may have missed
something with manual merges.

The manual merge issues are  mostly solved now in git 1.5, as
git-mergetool is able to use kdiff3 to resolve conflicts.
To use it, just git-mergetool on that file while merging,
thanks again Paul for the tip!

Regards,

Tony
