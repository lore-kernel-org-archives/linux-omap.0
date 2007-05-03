From: Tony Lindgren <tony@atomide.com>
Subject: Re: Last call for bug fixes before 2.6.21-omap1 will be tagged
Date: Thu, 3 May 2007 16:47:36 +0000
Message-ID: <20070503164735.GG28985@atomide.com>
References: <20070502182859.GK3520@atomide.com>
	<5d5443650705030258q100df4e7g66dc07962431c036@mail.gmail.com>
	<1178199298.2017.22.camel@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1178199298.2017.22.camel@paris.hilman.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Kevin Hilman <khilman@mvista.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@mvista.com> [070503 13:35]:
> On Thu, 2007-05-03 at 15:28 +0530, Trilok Soni wrote:
> > On 5/2/07, Tony Lindgren <tony@atomide.com> wrote:
> > > Hi all,
> > >
> > > I'm planning to tag 2.6.21-omap1 on Friday so let's make sure most of
> > > the boards run fine. If you have any pending bug fixes for 2.6.21,
> > > now it's time to send them.
> > >
> > 
> > OMAP2430 defconfig build failure for USB.
> > 
> 
> MUSB should not be enabled in the .config.
> 
> MUSB support is not quite ready for the 2430 yet.  I have gadget working
> locally, but have some problems with host mode.  Will post patches when
> I have it working.

I just posted 7 musb/tusb6010 patches to this list that may help.
Patch "Avoid host babble by checking tx fifo" in the series should fix lots
of musb host side issues.

Regards,

Tony
