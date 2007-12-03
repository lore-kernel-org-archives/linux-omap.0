From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/3] ARM: OMAP: Change MMU to use sysdev_class?
Date: Mon, 03 Dec 2007 14:50:42 -0800
Message-ID: <20071203225043.13E3723C959@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20071203222651.GE4105@atomide.com>
	<20071203224029.GF4105@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071203224029.GF4105@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: toshihiro.kobayashi@nokia.com, tony@atomide.com, lethal@linux-sh.org, Hiroshi.DOYU@nokia.com
Cc: linux-omap@vger.kernel.org, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> What do you guys think? Should we change it, or keep using class device?

"struct class_device" is going to vanish ... but what I saw
here was "struct class", which won't ...
