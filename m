From: Tony Lindgren <tony@atomide.com>
Subject: Re: git:// protocol
Date: Fri, 13 Jan 2006 15:15:54 -0800
Message-ID: <20060113231554.GE5499@atomide.com>
References: <43C82FEF.5030804@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <43C82FEF.5030804@cc.jyu.fi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* lamikr <lamikr@cc.jyu.fi> [060113 14:53]:
> Hi
> 
> I asked some git related questions in the git-newsgroup and used
> following command in my example:
> 
>     git-clone rsync://source.mvista.com/git/linux-omap-2.6.git 
> linux-omap-2.6
> 
> In one sidenote, Junia recommended avoiding rsynch protocol and using
> git:// protocol instead. (I do not know exact reasons for that)
> So, would it be possible to open also the git protocol port from the
> montavistas omap server?

You can use git protocol with kernel.org:

git://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git

But I believe it's still experimental. It should be possible to update
git on source.mvista.com, and run gitd.

Regards,

Tony
