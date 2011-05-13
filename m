From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Updated mach-types update
Date: Fri, 13 May 2011 15:19:16 +0300
Message-ID: <20110513151916.77eba011.jhnikula@gmail.com>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
	<20110320114137.GD16646@n2100.arm.linux.org.uk>
	<20110324175945.GV2811@atomide.com>
	<20110513115406.GQ31483@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20110513115406.GQ31483@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Ghosh <subhasish@mistralsolutions.com>, Srinath <srinath@mistralsolutions.com>, alsa-devel@alsa-project.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Arun C <arunedarath@mistralsolutions.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Subhasish@alsa-project.org
List-Id: linux-omap@vger.kernel.org

On Fri, 13 May 2011 04:54:07 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Tony Lindgren <tony@atomide.com> [110324 10:57]:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110320 04:39]:
> > > On Sun, Mar 20, 2011 at 11:03:22AM +0000, Russell King - ARM Linux wrote:
> > > 
> > > Note that OMAP references machine_is_omap2evm() yet this has never been
> > > merged.
> > > 
> > > arch/arm/plat-omap/include/plat/uncompress.h:
> > > 
> > >                 DEBUG_LL_OMAP2(1, omap2evm);
> > > 
> > > so this entry needs to be removed.
> > 
> > Hmm looks like we have LCD support and ASoC support for it, but no
> > board :)
> > 
> > Anybody working with this board?
> > 
> > If so, please send patches for the related board-*.c support ASAP.
> > Otherwise let's plan on deleting the related support.
> 
> No patches, so let's remove it. Here's the patch to do that,
> I'm planning to add this to my devel-cleanup branch.
> 
Remove also from sound/soc/omap/Kconfig as well. You could put my
ack for sound/soc/omap part but remember cc also Mark and Liam.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
