From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] SD working on OMAP platforms
Date: Tue, 3 Apr 2007 10:50:51 -0400
Message-ID: <20070403145048.GE10528@atomide.com>
References: <460D72E0.7050206@indt.org.br> <460DFCB9.4070102@drzeus.cx>
	<460EDBAC.9050301@indt.org.br> <4611DA08.7020102@drzeus.cx>
	<20070403135804.GA10528@atomide.com> <461252A9.1030402@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <461252A9.1030402@drzeus.cx>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>, ext Philip Langdale <philipl@overt.org>
List-Id: linux-omap@vger.kernel.org

* Pierre Ossman <drzeus-list@drzeus.cx> [070403 09:10]:
> tony@atomide.com wrote:
> > Always ignoring CERR seems totally unsafe to me. Also, it would be
> > best to use the existing #define OMAP_MMC_STAT_CARD_ERR.
> >
> > To recap, CERR needs to be ignored only with SD cards, and only
> > with CMD3.
> >   
> 
> No, CERR needs to be ignored whenever we do not want the controller to
> parse response bits for us (i.e. always). It parses them incorrectly
> when the reponse type isn't a standard/classic R1 and we might even
> _want_ to see some bits indicating error there. As such, respecting CERR
> is broken and the should be ignored at every turn.

OK, thanks for clarifying. In that case it sounds like the right
solution would be to totally disable CERR interrupt. This should be
doable by not writing OMAP_MMC_STAT_CARD_ERR bit to IE register.

Hmm, that might allow us to get rid of the other OMAP_MMC_STAT_CARD_ERR
quirk there too :) The one with MMC_STOP_TRANSMISSION one.

And then there would be only one opcode quirk in mmc_omap_irq() for
OMAP_MMC_STAT_CMD_TOUT.

> > Pierre, what do you have as an alternative for working around hardware
> > bugs without using opcodes? AFAIK opcodes are needed to work around
> > some hardware issues, such as this.
> >
> >   
> 
> Looking at protocol stuff is always the last resort. In this case it
> isn't necessary, but it might be in some cases. Really, the only time we
> need to look at the opcode is when the controller does too and we know
> it does something stupid when it sees some values. The wbsd driver has a
> fix based on this principle. It isn't pretty and it means that
> controller cannot use some cards, but it was the only way to solve the
> issue (and believe me, I tried long and hard to come up with another way).

Yeah, OK. The omap controller has problems with some cards, so
hopefully this will help with that.

Regards,

Tony
