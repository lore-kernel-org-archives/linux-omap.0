From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH RESEND 0/4] Runtime constants: define (some) OMAP address
 bases at runtime rather than compile time for multiboot
Date: Wed, 21 Nov 2007 00:13:17 -0700 (MST)
Message-ID: <Pine.LNX.4.64.0711210009220.31116@utopia.booyaka.com>
References: <20071121001620.571082090@pwsan.com>
	<20071121090339.4f256297.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20071121090339.4f256297.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Jarkko,

On Wed, 21 Nov 2007, Jarkko Nikula wrote:

> On Tue, 20 Nov 2007 17:16:20 -0700
> "ext Paul Walmsley" <paul@pwsan.com> wrote:
> 
> > So, convert the users of these defines to use runtime-computed global
> > variables where possible.  Where not possible (e.g., in static
> > initializers), use chip-specific preprocessor macros.  The global
> > variables are set up early in the board-*.c files in the map_io()
> > code, before almost everything else.
> > 
> Hi
> 
> How about calling omap2_set_globals_242x() from
> arch/arm/mach-omap2/io.c: omap2_map_common_io() in order to avoid
> modifications to n board files?

We could do that, but we'd still need to modify the board files to pass in 
the OMAP type to omap2_map_common_io().  

In an ideal world, we could just use omap2_check_revision() to determine 
the CPU type at runtime, but the TAP base address is not the same across 
all OMAPs, and must therefore itself be modified for multiboot :-(


- Paul
