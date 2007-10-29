From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] ARM: OMAP: Fix usb gadget related compile errors and
	typo
Date: Mon, 29 Oct 2007 15:42:44 -0700
Message-ID: <200710291542.45173.david-b@pacbell.net>
References: <47263ACA.8010001@googlemail.com>
	<20071029213303.257D523C3E9@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<31e679430710291445m72bbff1btc79308599af157ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <31e679430710291445m72bbff1btc79308599af157ff@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Felipe Balbi <felipebalbi@users.sourceforge.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Monday 29 October 2007, Felipe Balbi wrote:
> On 10/29/07, David Brownell <david-b@pacbell.net> wrote:
> > > is there any plans on upgrading isp1301 driver to the new style i2c
> > > driver also?? how could i help you with that?
> >
> > ISTR sending some code like that to the I2C list a while back, but
> > it's not yet been merged.
> 
> I see...
> 
> >
> > You could finish that, if it's not already sitting in Jean's I2C queue.
> > And if it is, you could maybe get it into the OMAP tree before 2.6.25
> > merges begin.  :)
> 
> do Jean have a gittree in kernel.org, couldn't find search the name...

He's got a quilt patch tree.  I have it bookmarked as:

  http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/?M=A

Seems not to have the isp1301 driver stuff ... that should be in
the i2c list archives.


> it would be easier just git-pull from there.. but if there isn't I'll
> do it manually and test with omap h2 and omap h3 boards once I'm back
> in brazil (next week).

... And it'd be nice if someone could update the H3 support to
include the IRQ used to hook up the tps65013 chip.  ;)


> well, in any case, I'll try to get these in sync between i2c/mainline
> and linux-omap tree.

Not straightforward, as I recall.  Or it'd be working already.
The issue is that the OTG state machine changed, so that various
transitions (I forget which ones!) behave incompatibly.

> >
> > > tps65010 driver is really better with that i2c_board_info structure in
> > > board files and there's a note to make isp1301 driver work the same
> > > way.
> >
> > Yep.  In fact, all the I2C code that OMAP uses should switch
> > over to new-style drivers ...
> >
> > That includes the pcf875x i/o expanders found on many TI devel
> > boards.  Making that change involves some updates to the GPIO
> > framework.  I've got some code to address all that, which I'll
> > be posting in a few days.
> 
> ok.. that'll help, could you please cc me so I can get those as soon
> as you publish them to apply on linux and test/validate with omap
> boards ?

What I'll do is forward the OMAP patches to this list ... both the
generic stuff (affecting the plat-omap/gpio.c code), and board-specific
stuff (affecting debug boards, tps6501x, etc).  The board-specific
stuff will need more work, it's not all that current.

- Dave
