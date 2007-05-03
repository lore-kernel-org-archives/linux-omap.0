From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Fix mis-reporting USB Mode on sysfs
Date: Thu, 3 May 2007 20:11:59 +0000
Message-ID: <20070503201158.GJ28985@atomide.com>
References: <31e679430705031244rc7018b8o5cf0025e63058b3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <31e679430705031244rc7018b8o5cf0025e63058b3b@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <felipebalbi@users.sourceforge.net> [070503 19:45]:
> 	This small patch fixes the mode reporting on sysfs.
> 	Whithout this, we will always see the device as in
> 	otg mode.

Hmmm, it should not be necessary to change the mode here as if the
mode changes, the interrupt should set it correctly.

Maybe should have some additional modes though:

host
peripheral
otg_host
otg_peripheral

I guess host and peripheral should be possible to compile in without
OTG eventually. And if just say otg, we don't know if it's currently
host or peripheral.

Tony
