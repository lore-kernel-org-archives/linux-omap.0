From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] Updated driver model and various fixes
Date: Tue, 29 Nov 2005 17:57:23 -0800
Message-ID: <20051130015722.GC7212@atomide.com>
References: <20051129030028.GJ8319@atomide.com>
	<20051129082222.71196.qmail@web32914.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20051129082222.71196.qmail@web32914.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Komal Shah <komal_shah802003@yahoo.com> [051129 00:22]:
> --- Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Ladislav Michl <ladis@linux-mips.org> [051128 14:14]:
> > > On Mon, Nov 28, 2005 at 08:54:13AM -0800, Komal Shah wrote:
> > 
> > > > o omap-nand-flash (adding driver model)
> > > Already done, but I'm still lacking feedback :-(
> > 
> > Sounds like it's time to push it to get some feedback!
> > Care to repost it?
> 
> Are you referring to these patches?
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-July/004687.html
> http://linux.omap.com/pipermail/linux-omap-open-source/2005-July/004692.html

Yes that thread, but a later post in August:

http://linux.omap.com/pipermail/linux-omap-open-source/2005-August/004847.html

That patch needs to be modified to use struct flash_platform_data in
include/asm-arm/mach/flash.h, and the smc91x.[ch] patches should not
be included...

Tony
