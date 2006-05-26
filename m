From: Tony Lindgren <tony@atomide.com>
Subject: Re: Kernel panics on OSK5912
Date: Fri, 26 May 2006 15:07:55 -0700
Message-ID: <20060526220755.GG4132@atomide.com>
References: <20060526063240.84781.qmail@web52306.mail.yahoo.com>
	<200605260908.03332.ml@roese.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200605260908.03332.ml@roese.nl>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Stefan Roese <ml@roese.nl>
Cc: linux-omap-open-source@linux.omap.com, Eduardo Gallofin <egallofin@yahoo.com>
List-Id: linux-omap@vger.kernel.org

* Stefan Roese <ml@roese.nl> [060526 00:06]:
> Hi Eduardo,
> 
> On Friday 26 May 2006 08:32, Eduardo Gallofin wrote:
> >   I got a problem with the 2.6.16 kernel running on my
> > OSK. It panics after (or when) running init. I'm not
> > sure what the problem is and MontaVista's kernel works
> > fine with my rootfs.
> >
> >   The same kernel and rootfs, however, works with our
> > other OSK5912 board....
> 
> We experienced similar problems on our OSK5912. The problems are SDRAM setup 
> related and can be solved by updating to the latest U-Boot version. Please 
> download and install the top-of-git version and give it a try.

Anybody have a patch to check this in the board-osk.c? This bug seems to
occur repeatedly so it would be nice to patch it away in the kernel
also.

Regards,

Tony
