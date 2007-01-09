From: Tony Lindgren <tony@atomide.com>
Subject: Re: innovator_ps2 broken
Date: Tue, 9 Jan 2007 15:28:27 -0800
Message-ID: <20070109232826.GM7384@atomide.com>
References: <459D34C9.8060405@googlemail.com> <1167938428.19325.5.camel@balbi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <1167938428.19325.5.camel@balbi>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipe.lima@indt.org.br>
Cc: linux-omap-open-source@linux.omap.com, Ilias Biris <ilias.biris@indt.org.br>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.lima@indt.org.br> [070104 11:29]:
> Hello all, 
> >    CC [M]  drivers/input/keyboard/innovator_ps2.o
> > drivers/input/keyboard/innovator_ps2.c: In function 
> > 'innovator_kbd_init':
> > drivers/input/keyboard/innovator_ps2.c:1225: warning: 
> > implicit declaration of function 'init_input_dev'
> > WARNING: "init_input_dev" 
> > [drivers/input/keyboard/innovator_ps2.ko] undefined!
> 
> This patch makes this module compile again.
> 
> Make drivers/input/keyboard/innovator_ps2.c work again.
> 
> init_input_dev() is not used anymore, use input_allocate_dev() instead.

Pushing today.

Tony
