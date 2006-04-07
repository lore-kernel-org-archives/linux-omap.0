From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap defconfigs in mainline tree
Date: Fri, 7 Apr 2006 06:14:32 -0700
Message-ID: <20060407131430.GD21950@atomide.com>
References: <20060407093134.25516.qmail@web32902.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060407093134.25516.qmail@web32902.mail.mud.yahoo.com>
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

* Komal Shah <komal_shah802003@yahoo.com> [060407 02:31]:
> Tony,
> 
> I want to understand why we don't push defconfigs (minus drivers
> options, which are not yet in mainline) to mainline tree? If we do that
> we can cover all variants as part of kautobuild, _or_ if someone gives
> me idea on setting up such autobuilds (kautobuild source?) I can set it
> up offline here.

We should send them, but let's get the omap i2c driver integrated first.
Then the mainline tree will be usable too.

Tony
