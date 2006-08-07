From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix lcd_ams_delta to use new PWL defines
Date: Mon, 7 Aug 2006 18:22:02 +0300
Message-ID: <20060807152201.GG10387@atomide.com>
References: <20060803111721.GH8661@atomide.com>
	<20060803120858.53676.qmail@web37909.mail.mud.yahoo.com>
	<20060804110530.GC26416@atomide.com>
	<20060804132035.GG17406@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060804132035.GG17406@earth.li>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Jonathan McDowell <noodles@earth.li> [060804 16:21]:
> On Fri, Aug 04, 2006 at 02:05:31PM +0300, Tony Lindgren wrote:
>  
> > I've pushed some patches. Does anybody else have patches that should go in
> > before I tag 2.6.17-omap2?
> 
> The attached is necessary to move the Amstrad Delta LCD driver over to
> the new PWL defines that have been pushed.

Pushed this one and tagged 2.6.17-omap2.

Also updating the tree to 2.6.18-rc4 so some things will probably break
a bit with the generic irq framework :)

Regards,

Tony
