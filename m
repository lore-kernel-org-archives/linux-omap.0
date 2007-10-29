From: "Felipe Balbi" <felipebalbi@users.sourceforge.net>
Subject: Re: [PATCH] ARM: OMAP: Fix usb gadget related compile errors and
	typo
Date: Tue, 30 Oct 2007 00:52:04 +0200
Message-ID: <31e679430710291552n4e5a26ffx9706962106d2c72b@mail.gmail.com>
References: <47263ACA.8010001@googlemail.com>
	<20071029213303.257D523C3E9@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<31e679430710291445m72bbff1btc79308599af157ff@mail.gmail.com>
	<200710291542.45173.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200710291542.45173.david-b@pacbell.net>
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 10/30/07, David Brownell <david-b@pacbell.net> wrote:
<snip>

> > do Jean have a gittree in kernel.org, couldn't find search the name...
>
> He's got a quilt patch tree.  I have it bookmarked as:
>
>   http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/?M=A

tks

>
> Seems not to have the isp1301 driver stuff ... that should be in
> the i2c list archives.

yeah... i'll track down

>
>
> > it would be easier just git-pull from there.. but if there isn't I'll
> > do it manually and test with omap h2 and omap h3 boards once I'm back
> > in brazil (next week).
>
> ... And it'd be nice if someone could update the H3 support to
> include the IRQ used to hook up the tps65013 chip.  ;)

hmm... k... I'll check that tomorrow morning.

>
>
> > well, in any case, I'll try to get these in sync between i2c/mainline
> > and linux-omap tree.
>
> Not straightforward, as I recall.  Or it'd be working already.
> The issue is that the OTG state machine changed, so that various
> transitions (I forget which ones!) behave incompatibly.

yeah... maybe running opt tests with omap h[23] boards running gadget
zero will help tracking down which issues are we talking about and
hopefully will help fixing it.

<snip>

> > ok.. that'll help, could you please cc me so I can get those as soon
> > as you publish them to apply on linux and test/validate with omap
> > boards ?
>
> What I'll do is forward the OMAP patches to this list ... both the
> generic stuff (affecting the plat-omap/gpio.c code), and board-specific
> stuff (affecting debug boards, tps6501x, etc).  The board-specific
> stuff will need more work, it's not all that current.

that's even better so everybody can comment/work on them


-- 
Best Regards,

Felipe Balbi
felipebalbi@users.sourceforge.net
