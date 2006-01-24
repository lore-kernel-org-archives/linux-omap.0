From: Juha =?iso-8859-1?B?WXJq9mzk?= <juha.yrjola@nokia.com>
Subject: Re: [PATCH] keypad refresh2
Date: Tue, 24 Jan 2006 23:26:36 +0200
Message-ID: <20060124212636.GA7275@two.research.nokia.com>
References: <20060122221251.GA1068@two.research.nokia.com>
	<20060123144319.89522.qmail@web32910.mail.mud.yahoo.com>
	<20060123170347.GB6263@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060123170347.GB6263@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 23, 2006 at 09:03:47AM -0800, ext Tony Lindgren wrote:

> > The first H4 board came out from TI was not having Menelaus chip. And
> > gpio signals were changed in the H4 EVM came out with Menelaus for
> > keypad. So only way to differentiate between the two was Menelaus chip
> > on the new board.
> 
> How about just adding && machine_is_omap_h4() there too?

This check should be performed in the board-specific code, i.e. in
board-h4.c.  The data passed to the keyboard driver should be modified
there.

Cheers,
Juha
