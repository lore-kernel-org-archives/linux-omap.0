From: tony@atomide.com
Subject: Re: [PATCH] ARM: OMAP: timer32k: fix tick count calculation when
	reprogramming
Date: Wed, 5 Jul 2006 01:51:04 -0700
Message-ID: <20060705085059.GC4546@atomide.com>
References: <20060703155155.GA29815@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060703155155.GA29815@localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: imre.deak@solidboot.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* imre.deak@solidboot.com <imre.deak@solidboot.com> [060703 08:51]:
> Reprogramming takes places before putting the CPU into idle mode if
> the dynamic tick option is enabled. The timer is then set to expire
> at the next pending timer event. Because some time has already passed
> since the last reported jiffy we have to wait less than the time
> specified in jiffies.

Looks good to me. This patch seems to need an update though.

Did you do this to fix some specific problem, or just to improve timer
accuracy?

> Also make sure we don't set a load value of 0 whose outcome is
> unspecified according to the TRM.

OK

Tony
