From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: OMAP: Change MMU to use sysdev_class?
Date: Mon, 3 Dec 2007 15:03:16 -0800
Message-ID: <20071203230315.GI4105@atomide.com>
References: <20071203222651.GE4105@atomide.com>
	<20071203224029.GF4105@atomide.com>
	<20071203225043.13E3723C959@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20071203225710.GA15047@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071203225710.GA15047@linux-sh.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org, Hiroshi.DOYU@nokia.com
List-Id: linux-omap@vger.kernel.org

* Paul Mundt <lethal@linux-sh.org> [071203 14:57]:
> On Mon, Dec 03, 2007 at 02:50:42PM -0800, David Brownell wrote:
> > > What do you guys think? Should we change it, or keep using class device?
> > 
> > "struct class_device" is going to vanish ... but what I saw
> > here was "struct class", which won't ...
> 
> If struct class is going to hang around, then it's certainly preferable
> to keep using that. It's really the best match for this particular
> problem.

OK, let's scrap the sysdev_class patch then.

Tony
