From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix warning in plat_uds.c
Date: Tue, 21 Aug 2007 00:24:04 -0700
Message-ID: <20070821072403.GH31816@atomide.com>
References: <46C5C233.5090405@googlemail.com>
	<200708200141.48452.david-b@pacbell.net>
	<46C965EF.7050508@googlemail.com>
	<200708201110.06262.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200708201110.06262.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070820 11:11]:
> On Monday 20 August 2007, Dirk Behme wrote:
> > this conflicts with Kevins patch Tony applied some 
> > minutes ago:
> 
> Update appended.  Too much of the current #ifdeffery
> is trivially replaced by using the already-defined
> predicates to test e.g. the available modes.
> 
> - Dave
> 
> ======	SNIP!
> (Updated) Fix various build warnings for peripheral-only builds,
> and some linewrap bugs.  Remove some inappropriate #ifdefs.

Thanks, pushing today.

Tony
