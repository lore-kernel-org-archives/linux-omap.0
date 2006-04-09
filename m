From: tony@atomide.com
Subject: Re: omap git tree inconsistency
Date: Sun, 9 Apr 2006 11:18:51 -0700
Message-ID: <20060409181849.GE5032@atomide.com>
References: <20060407204358.GL21950@atomide.com>
	<20060408153234.54204.qmail@web32901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060408153234.54204.qmail@web32901.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060408 08:32]:
> --- Tony Lindgren <tony@atomide.com> wrote:
> 
> > 
> > Thanks for noting it! I've synced it with the mainline tree.
> > 
> 
> Not complete yet !. Check drivers/i2c/chips in our tree and you will
> find x1205.c driver, which is not present in the linus tree, as it was
> moved to new rtc subsystem folder with new name rtc-x1205.c. So I
> believe there will more locations like this...:)

This seemed to be only on source.mvista.com tree for some reason.
Running git diff showed some unmerged changes. No idea how that has
happened, maybe an interrupted push or something.

In any case, I re-cloned the tree and that seems to have taken care
of it.

BTW, I may not have net access until Thursday.

Tony
