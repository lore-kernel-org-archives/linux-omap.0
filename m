From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap git tree inconsistency
Date: Fri, 7 Apr 2006 13:43:59 -0700
Message-ID: <20060407204358.GL21950@atomide.com>
References: <20060407202321.12537.qmail@web32907.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060407202321.12537.qmail@web32907.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [060407 13:23]:
> Tony,
> 
> Our tree seems to not properly merged with the mainline. Simple example
> is drivers/mmc/Makefile where ATM91 and SDHCI driver is missing and
> same for drivers/mmc/KConfig. It happened to me, as my test topic
> branch gets synched regularly from linus tree and omap-git and again
> showed lot's of merge conflicts when I pulled from omap-git tree
> yesterday, which in theory should not show any conflicts which I had
> already resolved while merging from linus tree.

Thanks for noting it! I've synced it with the mainline tree.

Tony
