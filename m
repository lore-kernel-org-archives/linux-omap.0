From: Kevin Hilman <khilman@mvista.com>
Subject: Re: Last call for bug fixes before 2.6.21-omap1 will be tagged
Date: Thu, 03 May 2007 06:34:58 -0700
Message-ID: <1178199298.2017.22.camel@paris.hilman.org>
References: <20070502182859.GK3520@atomide.com>
	<5d5443650705030258q100df4e7g66dc07962431c036@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650705030258q100df4e7g66dc07962431c036@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thu, 2007-05-03 at 15:28 +0530, Trilok Soni wrote:
> On 5/2/07, Tony Lindgren <tony@atomide.com> wrote:
> > Hi all,
> >
> > I'm planning to tag 2.6.21-omap1 on Friday so let's make sure most of
> > the boards run fine. If you have any pending bug fixes for 2.6.21,
> > now it's time to send them.
> >
> 
> OMAP2430 defconfig build failure for USB.
> 

MUSB should not be enabled in the .config.

MUSB support is not quite ready for the 2430 yet.  I have gadget working
locally, but have some problems with host mode.  Will post patches when
I have it working.

Kevin
