From: Brian Swetland <swetland@google.com>
Subject: Re: [PATCH] ARM: OMAP: Add core fsample support
Date: Mon, 15 May 2006 06:36:06 -0700
Message-ID: <20060515133606.GA31834@localhost.localdomain>
References: <20060515095624.GJ8368@atomide.com>
	<20060515131338.88891.qmail@web37910.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060515131338.88891.qmail@web37910.mail.mud.yahoo.com>
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

[Komal Shah <komal_shah802003@yahoo.com>]
> --- Tony Lindgren <tony@atomide.com> wrote:
> 
> > * Kevin Hilman <khilman@mvista.com> [060428 11:56]:
> > > Brian Swetland wrote:
> > > >This patch adds core support for the TI F-Sample Board (OMAP 850).
> > 
> > Pushing this today.
> 
> Please check the board-fsample.c in gitweb now :)
> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blob;h=6a9b75776bc781c713b9905a058b8193fc4eaf0b;hb=bb236d9666442f98d955000abbb1b88d59ae42d4;f=arch/arm/mach-omap1/board-fsample.c

Looks like it happened to board-fsample.h as well:
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=blob;h=c0399906636ea5ffaa71b06440dd4c8085a6fe76;hb=bb236d9666442f98d955000abbb1b88d59ae42d4;f=include/asm-arm/arch-omap/board-fsample.h

The other files in the patch look okay.

Brian
