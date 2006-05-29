From: Eduardo Gallofin <egallofin@yahoo.com>
Subject: Re: Kernel panics on OSK5912
Date: Sun, 28 May 2006 18:28:54 -0700 (PDT)
Message-ID: <20060529012854.28237.qmail@web52310.mail.yahoo.com>
References: <20060526220755.GG4132@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060526220755.GG4132@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, Stefan Roese <ml@roese.nl>
Cc: linux-omap-open-source@linux.omap.com, Eduardo Gallofin <egallofin@yahoo.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony, Stefan,

   I am already using the 1.1.4 version of u-boot and
the problem is still there. Is there a newer version
of the bootloader?

   Thing is everything was working fine, until I
forced a kernel panic to get a backtrace (my bad).
Then this problem started. Any idea where the problem
might be from?

  Thanks!


--- Tony Lindgren <tony@atomide.com> wrote:

> * Stefan Roese <ml@roese.nl> [060526 00:06]:
> > Hi Eduardo,
> > 
> > On Friday 26 May 2006 08:32, Eduardo Gallofin
> wrote:
> > >   I got a problem with the 2.6.16 kernel running
> on my
> > > OSK. It panics after (or when) running init. I'm
> not
> > > sure what the problem is and MontaVista's kernel
> works
> > > fine with my rootfs.
> > >
> > >   The same kernel and rootfs, however, works
> with our
> > > other OSK5912 board....
> > 
> > We experienced similar problems on our OSK5912.
> The problems are SDRAM setup 
> > related and can be solved by updating to the
> latest U-Boot version. Please 
> > download and install the top-of-git version and
> give it a try.
> 
> Anybody have a patch to check this in the
> board-osk.c? This bug seems to
> occur repeatedly so it would be nice to patch it
> away in the kernel
> also.
> 
> Regards,
> 
> Tony
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
