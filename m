From: David Brownell <david-b@pacbell.net>
Subject: Re: Invalid Storage Class BUG
Date: Wed, 1 Nov 2006 14:48:59 -0800
Message-ID: <200611011449.02172.david-b@pacbell.net>
References: <4549087F.5070701@nokia.com>
	<200611011426.28869.david-b@pacbell.net>
	<20061101144106.d6d464a6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20061101144106.d6d464a6.akpm@osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-omap-open-source@linux.omap.com, linux-usb-devel@lists.sourceforge.net, "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>
List-Id: linux-omap@vger.kernel.org


> > (Andrew, ISTR that a topological sort won't work in this file.)
> 
> I did one just then.  It worked for allmodconfig, but it was too big so I
> deleted it.

OK.  It was a few releases ago, then, that a topsort couldn't work;
Alan's various updates have improved that aspect too.

I always like to see forward declarations removed, myself, and I'm
glad not to be alone in that.  ;)

- Dave


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
