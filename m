From: tony@atomide.com
Subject: Re: [PATCH] SD working on OMAP platforms
Date: Tue, 3 Apr 2007 09:58:08 -0400
Message-ID: <20070403135804.GA10528@atomide.com>
References: <460D72E0.7050206@indt.org.br> <460DFCB9.4070102@drzeus.cx>
	<460EDBAC.9050301@indt.org.br> <4611DA08.7020102@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <4611DA08.7020102@drzeus.cx>
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

* Pierre Ossman <drzeus-list@drzeus.cx> [070403 00:35]:
> Carlos Aguiar wrote:
> > On CMD3, response type is R6 to SD cards and R1 to MMC cards.
> > This fix ignores the buggy SD handling on CMD3.
> >
> >   
> 
> This is misleading. The problem is the OMAP controller trying to be
> smart with the end result of it doing something completely wrong. The
> controller parses data when it has no idea what we want parsed.
> 
> > +		if (status == 0x4000) {
> > +			dev_dbg(mmc_dev(host->mmc),
> > +				"buggy SD handling, ignoring it\n");
> > +			status = 0x0001;
> > +		}
> > +
> >   
> 
> Some defines for those constants would be nice. And the debug message
> should be more general

Always ignoring CERR seems totally unsafe to me. Also, it would be
best to use the existing #define OMAP_MMC_STAT_CARD_ERR.

To recap, CERR needs to be ignored only with SD cards, and only
with CMD3.

Pierre, what do you have as an alternative for working around hardware
bugs without using opcodes? AFAIK opcodes are needed to work around
some hardware issues, such as this.

Regards,

Tony
