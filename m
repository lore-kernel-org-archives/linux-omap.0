From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] i2c-omap: Fix i2c_xfer for 1 msg
Date: Mon, 6 Feb 2006 21:32:10 -0800
Message-ID: <20060207053210.GL4190@atomide.com>
References: <20060124124654.GA21123@orphique> <20060202183135.GA12788@orphique>
	<20060202192653.GL15939@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20060202192653.GL15939@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [060202 11:33]:
> * Ladislav Michl <ladis@linux-mips.org> [060202 10:39]:
> > On Tue, Jan 24, 2006 at 01:46:54PM +0100, Ladislav Michl wrote:
> > > omap_i2c_xfer is supposed to return number of messages successfuly
> > > transfered. Remove bogus condition which causes it to fail when
> > > transfering one message.
> > 
> > Ping? Everyone happy with current state of art? :-)
> 
> Everybody's just busy I'd assume...
> 
> > Also could anyone with 15xx test second patch (2/2)? If there are no
> > objectios I'd like to see both applied :-)
> 
> I'll push them on Friday unless somebody somebody files a complaint.

Just pushed them finally.

Tony
