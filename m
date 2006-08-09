From: Tony Lindgren <tony@atomide.com>
Subject: Re: 2.6.18-rc4 / generic irq etc.
Date: Wed, 9 Aug 2006 10:26:31 +0300
Message-ID: <20060809072630.GA14977@atomide.com>
References: <20060803111721.GH8661@atomide.com>
	<20060803120858.53676.qmail@web37909.mail.mud.yahoo.com>
	<20060804110530.GC26416@atomide.com>
	<20060804132035.GG17406@earth.li>
	<20060807152201.GG10387@atomide.com>
	<20060808213319.GE27094@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060808213319.GE27094@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Jonathan McDowell <noodles@earth.li> [060809 00:33]:
> On Mon, Aug 07, 2006 at 06:22:02PM +0300, Tony Lindgren wrote:
>  
> > Also updating the tree to 2.6.18-rc4 so some things will probably break
> > a bit with the generic irq framework :)
> 
> As a data point latest git seems to work fine on the E3 for at least
> the serial console and USB host.

Good to hear. GPIO is the most likely candidate to have some issues..

Tony
