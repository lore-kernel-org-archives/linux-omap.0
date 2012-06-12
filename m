From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 5/5] Input: ads7846: set proper debounce time in driver
 level
Date: Tue, 12 Jun 2012 10:53:58 +0300
Message-ID: <4FD6F596.6050905@compulab.co.il>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
 <1339423216-1323-6-git-send-email-zumeng.chen@gmail.com>
 <4FD602AD.1060304@compulab.co.il>
 <CA+Y31weKZTY5RM+i_6c=DaY6WCdai7HcSzJkytWJO9cDeyKVcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CA+Y31weKZTY5RM+i_6c=DaY6WCdai7HcSzJkytWJO9cDeyKVcQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zumeng Chen <zumeng.chen@gmail.com>
Cc: khilman@ti.com, tony@atomide.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Vaibhav Hiremath <hvaibhav@ti.com>, ajay.gupta@ti.com, khasim@ti.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 06/12/12 05:49, Zumeng Chen wrote:
> 
> 
> 2012/6/11 Igor Grinberg <grinberg@compulab.co.il <mailto:grinberg@compulab.co.il>>
> 
>     Hi,
> 
>     This is input subsystem, add Dmitry and linux-input.
> 
>     On 06/11/12 17:00, Zumeng Chen wrote:
>     > If we don't set proper debouce time for ads7846, then there are
>     > flooded interrupt counters of ads7846 responding to one time
>     > touch on screen, so the driver couldn't work well.
>     >
>     > And since most OMAP3 series boards pass NULL pointer of board_pdata
>     > to omap_ads7846_init, so it's more proper to set it in driver level
>     > after having gpio_request done.
> 
>     What about other non-OMAP platforms?
> 
> Good point, I thought it should be the same situation, and I have no other boards
> to validate it :) Then I'll fall back on my original patch to bracket them with OMAP3EVM

This isn't a good solution either...

> 
> 
>     NULL pointer for board_pdata, only means that the default pdata is used.
>     Please, see the common-board-devices.c file more closely.
> 
> Yes,  I just went through again, two points:
> 
> 1 )  get_pendown_state is not set for OMAP3 boards, and the state

You can supply your own pdata and provide the get_pendown_state() callback.

>       will be get by gpio_get_value(gpio-omap.c)
>       The second path will be available in the ads7846_setup_pendown
>       if (pdata->get_pendown_state) {
>                 ts->get_pendown_state = pdata->get_pendown_state;
>       } else if (gpio_is_valid(pdata->gpio_pendown)) {
> 
> 2 )  All omap3 boards set gpio_pendown for pdata.
>       So it had better we set_debounce in driver level after gpio_request_one
>       having done
>       I'll remove DEBOUNCE_TIME in V2 and change into like following:
> 
> +#ifdef CONFIG_MACH_OMAP3EVM
> +               /* 310 means 10 microsecond for omap3 */
> +               gpio_set_debounce(pdata->gpio_pendown, 310);
> +#endif

I don't think this kind of fix is acceptable...

> 
> 
>     >
>     > This patch has been validated on 3530evm.
>     >
>     > Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com <mailto:zumeng.chen@gmail.com>>
>     > Signed-off-by: Syed Mohammed Khasim <khasim@ti.com <mailto:khasim@ti.com>>
>     > Signed-off-by: Tony Lindgren <tony@atomide.com <mailto:tony@atomide.com>>
>     > ---
>     >  drivers/input/touchscreen/ads7846.c |    2 ++
>     >  1 files changed, 2 insertions(+), 0 deletions(-)
>     >
>     > diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
>     > index f02028e..a82a5fb 100644
>     > --- a/drivers/input/touchscreen/ads7846.c
>     > +++ b/drivers/input/touchscreen/ads7846.c
>     > @@ -61,6 +61,7 @@
>     >
>     >  /* this driver doesn't aim at the peak continuous sample rate */
>     >  #define      SAMPLE_BITS     (8 /*cmd*/ + 16 /*sample*/ + 2 /* before, after */)
>     > +#define      DEBOUNCE_TIME   310 /* About 10 ms */
> 
>     I think hard coding this value is wrong.
> 
> Yes, me too.
> 
>     Can't it be derived from the pdata->debounce_* fields?
> 
> Yes, I agreed this way, and to be honest, my first choice
> is to find if there is a member for debounce, but no. And
> there is no more sense to derive it from debounce_max,
> although which is the right value for us.

It makes sense to me... Why do you think there is no sense?


-- 
Regards,
Igor.
