From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 2/3] ARM: OMAP: menelaus chip info for H4 board.
Date: Tue, 29 May 2007 18:03:26 +0530
Message-ID: <5d5443650705290533x7883a94bv50ce4e10a209d4b3@mail.gmail.com>
References: <5d5443650705260128vc6f79a0rdaa220dc0527e79d@mail.gmail.com>
	<200705261944.26659.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <200705261944.26659.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 5/27/07, David Brownell <david-b@pacbell.net> wrote:
> See the appended patch ... the #ifdefs shouldn't exist, and
> if you're going to define the IRQ there (as you should) then
> the pinmux must move out of the driver (maybe the board uses
> a GPIO for some reason).
>
> I threw in another I2C device too.
>
> - Dave
>
> ==============  CUT HERE
> Tweak Trilok's h4 i2c boardinfo patch:
>
>   - Don't #ifdef
>   - Declare the rv5c387a RTC too
>   - Move irq pinmux out of the driver into board-specific init
>
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
>
> ---
> NOTE:  board-n800 may need a similar pinmux change... and yes,
> I prefer the "one board-X.c" style.
>
>  arch/arm/mach-omap2/board-h4.c |   10 ++++++++--
>  drivers/i2c/chips/menelaus.c   |    4 ----
>  2 files changed, 8 insertions(+), 6 deletions(-)
>
> --- h4.orig/arch/arm/mach-omap2/board-h4.c      2007-05-26 19:35:17.000000000 -0700
> +++ h4/arch/arm/mach-omap2/board-h4.c   2007-05-26 19:35:24.000000000 -0700
> @@ -493,12 +493,15 @@ static void __init tusb_evm_setup(void)
>  #endif
>
>  static struct i2c_board_info __initdata h4_i2c_board_info[] = {
> -#ifdef CONFIG_MENELAUS
> +       {
> +               I2C_BOARD_INFO("rtc-rs5c372", 0x32),
> +               .type = "rv5c387a",

Where you have used driver_name "rtc-rs5c372" in the menelaus.c
driver? while registering rtc device you have used same "menelaus" as
DRIVER_NAME.

Actually I am trying to use new I2C style to TWL4030 core driver, as
it has four slaves which I want to register with i2c_board_info
structure along with main driver name "twl4030" and slaves being
"twl4030:0", "twl4030:1" and so on. But ->probe will be called for
only main driver "twl4030" not for each slaves as per the i2c core
correct?

-- 
--Trilok Soni
