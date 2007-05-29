From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/3] ARM: OMAP: menelaus chip info for H4 board.
Date: Tue, 29 May 2007 06:09:48 -0700
Message-ID: <200705290609.48235.david-b@pacbell.net>
References: <5d5443650705260128vc6f79a0rdaa220dc0527e79d@mail.gmail.com>
	<200705261944.26659.david-b@pacbell.net>
	<5d5443650705290533x7883a94bv50ce4e10a209d4b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650705290533x7883a94bv50ce4e10a209d4b3@mail.gmail.com>
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
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Tuesday 29 May 2007, Trilok Soni wrote:
> > --- h4.orig/arch/arm/mach-omap2/board-h4.c      2007-05-26 19:35:17.000000000 -0700
> > +++ h4/arch/arm/mach-omap2/board-h4.c   2007-05-26 19:35:24.000000000 -0700
> > @@ -493,12 +493,15 @@ static void __init tusb_evm_setup(void)
> >  #endif
> >
> >  static struct i2c_board_info __initdata h4_i2c_board_info[] = {
> > -#ifdef CONFIG_MENELAUS
> > +       {
> > +               I2C_BOARD_INFO("rtc-rs5c372", 0x32),
> > +               .type = "rv5c387a",
> 
> Where you have used driver_name "rtc-rs5c372" in the menelaus.c
> driver?

There's an rv5c387a chip on the board too.  See

  http://groups.google.com/group/rtc-linux/msg/fa462b52470149d8


> while registering rtc device you have used same "menelaus" as 
> DRIVER_NAME.

Sure, but that's for a different chip.  Both need i2c_board_info.


> Actually I am trying to use new I2C style to TWL4030 core driver, as
> it has four slaves which I want to register with i2c_board_info
> structure along with main driver name "twl4030" and slaves being
> "twl4030:0", "twl4030:1" and so on. But ->probe will be called for
> only main driver "twl4030" not for each slaves as per the i2c core
> correct?

I have no idea what you're talking about here.  Menelaus is
twl92330, yes?  H4 doesn't have a twl4030...

- Dave
