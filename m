From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] initial musb urb fixes to make it work again
Date: Tue, 27 Nov 2007 18:21:57 -0800
Message-ID: <20071128022157.GG11825@atomide.com>
References: <20071030155304.GA30658@atomide.com>
	<20071031102616.GA31081@atomide.com>
	<31e679430710310340s543c9541p96bd564699cccbc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <31e679430710310340s543c9541p96bd564699cccbc2@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <felipebalbi@users.sourceforge.net> [071031 03:40]:
> Hi,
> 
> On 10/31/07, Tony Lindgren <tony@atomide.com> wrote:
> > * Tony Lindgren <tony@atomide.com> [071030 08:53]:
> > > Hi all,
> > >
> > > Attached is an initial patch to make musb driver work again.
> > > I've only done minimal testing, and still need to check at least
> > > the urb dequeue stuff tomorrow. Anyways, in case somebody else
> > > is also looking into this, maybe this helps a bit.
> >
> > I've pushed the trivial peripheral compile fixes, here's an
> > updated version of the host side fixes.
> 
> updated your patch to remove an unused variable warning. I'll take a
> closer look in this driver now.

I've pushed this with the tmp variable removed.

Tony
