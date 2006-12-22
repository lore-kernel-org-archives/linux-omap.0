From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Fix ADS7846 dependencies
Date: Thu, 21 Dec 2006 22:55:55 -0800
Message-ID: <200612212255.56224.david-b@pacbell.net>
References: <85psbv77ox.fsf@orfeo.duckcorp.org>
	<20061111003740.GS26185@atomide.com>
	<20061221233115.GN10399@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20061221233115.GN10399@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thursday 21 December 2006 3:31 pm, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [061110 16:44]:
> > 
> > This looks OK to me, Dave any comments?

Actually I'm trying to sync up the mainline code with what's
in the OMA tree; they've diverged a bit too much for it to
be straightforward.

The hwmon related parts of that sync-up, against mainline, are at:

http://lists.lm-sensors.org/pipermail/lm-sensors/2006-December/018484.html

and the behavioral summary is that the hwmon functionality won't
exist without someone separately configuring hwmon.  :)


What this is going to mean is that at some point all the updates
specific to the OMAP tree should just be wiped out by pulling down
the version from the main tree.  After that, I hope there won't be
divergence again ...

(The original reason for divergence was that the OMAP version had
workarounds for byteswap bugs in the omap_uwire driver.  Now that
those are gone, there's no longer a reason to diverge...)

- Dave
