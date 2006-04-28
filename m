From: "Jason Huang" <jason.huang@wescongroup.com>
Subject: RE: Anybody has MMC on Innovator 1510 working
Date: Fri, 28 Apr 2006 08:10:50 -0700
Message-ID: <000f01c66ad5$f1b07710$786fa8c0@smtp2>
References: <20060428073402.GC31797@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060428073402.GC31797@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Tony,

When or which version was that the MMC worked on Innovator 1510?
I need to pull the working version from the git tree.

Jason

-----Original Message-----
From: tony@atomide.com [mailto:tony@atomide.com] 
Sent: Friday, April 28, 2006 12:34 AM
To: Jason Huang
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: Anybody has MMC on Innovator 1510 working

Hi,

* Jason Huang <jason.huang@wescongroup.com> [060427 16:30]:
> Dear list members:
> 
> Is there anybody has MMC on Innovator working? Which version of Linux?
> 
> I tried 2.6.11-omap1, 2.6.16-omap1, 2.6.16-omap2 as well as current git
> tree.
> All I got: MMC1: Command timeout, CMD0 when I did 'modprobe omap'.
> 
> Any help is much appreciated.

It worked on Innovator 1510 last time I tried. In the current git tree
it is broken as we're in process of switching to use the mainline MMC code.

Regards,

Tony
