From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] ARM: OMAP: Change MMU to use sysdev_class?
Date: Mon, 3 Dec 2007 14:56:47 -0800
Message-ID: <20071203225647.GH4105@atomide.com>
References: <20071203222651.GE4105@atomide.com>
	<20071203224029.GF4105@atomide.com>
	<20071203225043.13E3723C959@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071203225043.13E3723C959@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
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
Cc: linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org, Hiroshi.DOYU@nokia.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [071203 14:50]:
> > What do you guys think? Should we change it, or keep using class device?
> 
> "struct class_device" is going to vanish ... but what I saw
> here was "struct class", which won't ...

Yes sorry, "struct class", not "class_device". The "struct
class_device" conversion to "struct device" was done a while back.

The reason why I'm thinking "struct class" may be still the way to go
for general MMU stuff is that eventually some parts could be arch
independent.

Regards,

Tony
