From: Tom Rini <trini@kernel.crashing.org>
Subject: Re: source.mvista.com/git not accessible
Date: Mon, 27 Mar 2006 08:15:04 -0700
Message-ID: <20060327151504.GD15423@smtp.west.cox.net>
References: <20060327142633.74416.qmail@web32911.mail.mud.yahoo.com>
	<20060327143715.GJ17219@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060327143715.GJ17219@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 27, 2006 at 06:37:16AM -0800, Tony Lindgren wrote:
> * Komal Shah <komal_shah802003@yahoo.com> [060327 06:28]:
> > Tony,
> > 
> > http://source.mvista.com/git trees are not accessible from yesterday.
> 
> I noticed that too. Tom, any ideas?

Apache died and has been restarted.  git-daemon and rsyncd were still
going fine.  I've restarted apache and asked someone to poke around and
see why it died.

-- 
Tom Rini
http://gate.crashing.org/~trini/
