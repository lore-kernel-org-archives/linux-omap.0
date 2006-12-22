From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: fix workqueue changes
Date: Fri, 22 Dec 2006 12:21:23 -0800
Message-ID: <20061222202122.GG2449@atomide.com>
References: <33307024.396441166765952040.JavaMail.weblogic@ep_ml29>
	<200612221024.54833.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200612221024.54833.david-b@pacbell.net>
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

* David Brownell <david-b@pacbell.net> [061222 10:25]:
> On Thursday 21 December 2006 9:39 pm, Kyungmin Park wrote:
> > [PATCH] ARM: OMAP: fix workqueue changes
> 
> This kind of patch needs to get submitted upstream ASAP, since
> that's where the breakage is coming from ... as an MMC patch,
> I think that means it should goto Pierre Ossman.

Pushing today to linux-omap. Kyungmin, please send it to Pierre also.
BTW, the patch was missing the last linefeed at the end to apply.

Regards,

Tony
