From: David Rivshin <drivshin@awxrd.com>
Subject: Re: [PATCH 1/2] gpio: omap: return error if requested debounce time
 is not possible
Date: Thu, 20 Apr 2017 10:44:37 -0400
Message-ID: <20170420104437.7cd68de6.drivshin@awxrd.com>
References: <20170317005704.11971-1-drivshin@awxrd.com>
        <20170317005704.11971-2-drivshin@awxrd.com>
        <d1200407-5efd-ca7b-f936-fa37b206e1ea@ti.com>
        <20170317135413.78118dc2.drivshin@awxrd.com>
        <dc614a7a-e0fa-c071-478b-2124724d95e9@ti.com>
        <20170317165032.5b891bc1.drivshin@awxrd.com>
        <73fd00d4-6649-90d6-dcb1-0cd186055a69@ti.com>
        <20170317194235.5a883df8.drivshin@awxrd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170317194235.5a883df8.drivshin@awxrd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Grygorii,

Not sure if you saw the question at the bottom asking for clarification 
on what you'd prefer as far as any dev_xxx() message for this case. If 
there is still concern on the other patch, I could just resubmit this
standalone (perhaps aiming for 4.12 at this point).

On Fri, 17 Mar 2017 19:42:35 -0400
David Rivshin <drivshin@awxrd.com> wrote:

> On Fri, 17 Mar 2017 16:43:56 -0500
> Grygorii Strashko <grygorii.strashko@ti.com> wrote:
> 
> > On 03/17/2017 03:50 PM, David Rivshin wrote:  
> > > On Fri, 17 Mar 2017 13:54:28 -0500
> > > Grygorii Strashko <grygorii.strashko@ti.com> wrote:
> > >    
> > >> On 03/17/2017 12:54 PM, David Rivshin wrote:    
> > >>> Hi Grygorii,
> > >>>
> > >>> On Fri, 17 Mar 2017 11:45:56 -0500
> > >>> Grygorii Strashko <grygorii.strashko@ti.com> wrote:
> > >>>    
> > >>>> On 03/16/2017 07:57 PM, David Rivshin wrote:    
> > >>>>> From: David Rivshin <DRivshin@allworx.com>
> > >>>>>
> > >>>>> omap_gpio_debounce() does not validate that the requested debounce
> > >>>>> is within a range it can handle. Instead it lets the register value
> > >>>>> wrap silently, and always returns success.
> > >>>>>
> > >>>>> This can lead to all sorts of unexpected behavior, such as gpio_keys
> > >>>>> asking for a too-long debounce, but getting a very short debounce in
> > >>>>> practice.
> > >>>>>
> > >>>>> Fix this by returning -EINVAL if the requested value does not fit into
> > >>>>> the register field. If there is no debounce clock available at all,
> > >>>>> return -ENOTSUPP.    
> > >>>>
> > >>>> In general this patch looks good, but there is one thing I'm worry about..
> > >>>>    
> > >>>>>
> > >>>>> Fixes: e85ec6c3047b ("gpio: omap: fix omap2_set_gpio_debounce")
> > >>>>> Cc: <stable@vger.kernel.org> # 4.3+
> > >>>>> Signed-off-by: David Rivshin <drivshin@allworx.com>
> > >>>>> ---
> > >>>>>  drivers/gpio/gpio-omap.c | 16 +++++++++++-----
> > >>>>>  1 file changed, 11 insertions(+), 5 deletions(-)
> > >>>>>
> > >>>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > >>>>> index efc85a2..33ec02d 100644
> > >>>>> --- a/drivers/gpio/gpio-omap.c
> > >>>>> +++ b/drivers/gpio/gpio-omap.c
> > >>>>> @@ -208,8 +208,10 @@ static inline void omap_gpio_dbck_disable(struct gpio_bank *bank)
> > >>>>>   * OMAP's debounce time is in 31us steps
> > >>>>>   *   <debounce time> = (GPIO_DEBOUNCINGTIME[7:0].DEBOUNCETIME + 1) x 31
> > >>>>>   * so we need to convert and round up to the closest unit.
> > >>>>> + *
> > >>>>> + * Return: 0 on success, negative error otherwise.
> > >>>>>   */
> > >>>>> -static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
> > >>>>> +static int omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
> > >>>>>  				    unsigned debounce)
> > >>>>>  {
> > >>>>>  	void __iomem		*reg;
> > >>>>> @@ -218,11 +220,12 @@ static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
> > >>>>>  	bool			enable = !!debounce;
> > >>>>>
> > >>>>>  	if (!bank->dbck_flag)
> > >>>>> -		return;
> > >>>>> +		return -ENOTSUPP;
> > >>>>>
> > >>>>>  	if (enable) {
> > >>>>>  		debounce = DIV_ROUND_UP(debounce, 31) - 1;
> > >>>>> -		debounce &= OMAP4_GPIO_DEBOUNCINGTIME_MASK;
> > >>>>> +		if ((debounce & OMAP4_GPIO_DEBOUNCINGTIME_MASK) != debounce)
> > >>>>> +			return -EINVAL;    
> > >>>>
> > >>>> This might cause boot issues as current drivers may expect this op to succeed even if
> > >>>> configured value is wrong - just think, may be we can do warn here and use max value as
> > >>>> fallback?    
> > >>>
> > >>> I have not looked through all drivers to be sure, but at least the gpio-keys
> > >>> driver requires set_debounce to return an error if it can't satisfy the request.
> > >>> In that case gpio-keys will use a software timer instead.
> > >>>
> > >>>                 if (button->debounce_interval) {
> > >>>                         error = gpiod_set_debounce(bdata->gpiod,
> > >>>                                         button->debounce_interval * 1000);
> > >>>                         /* use timer if gpiolib doesn't provide debounce */
> > >>>                         if (error < 0)
> > >>>                                 bdata->software_debounce =
> > >>>                                                 button->debounce_interval;
> > >>>                 }
> > >>>
> > >>> Also, at least some other GPIO drivers (e.g. gpio-max7760) return -EINVAL in
> > >>> such a case. And gpiolib will return -ENOTSUPP if there is no debounce
> > >>> callback at all. So I expect all drivers which use gpiod_set_debounce() to
> > >>> handle error returns gracefully.
> > >>>
> > >>> So I certainly understand the concern about backwards compatibility, but I
> > >>> think clipping to max is the greater of the evils in this case. Even a
> > >>> warning may be too much, because it's not necessarily anything wrong.
> > >>> Perhaps an info or debug message would be helpful, though?
> > >>>
> > >>> If you prefer, I can try to go through all callers of gpiod_set_debounce()
> > >>> and see how they'd handle an error return. The handful I've looked through so
> > >>> far all behave like gpio-keys. The only ones I'd be particularly concerned
> > >>> about are platform-specific drivers which were perhaps never used with other
> > >>> gpio drivers. Do you know of that I should pay special attention to?    
> > >>
> > >> Yeh agree. But the problem here will be not only with drivers itself - it can be wrong data in DT :(
> > >> As result, even  gpio-keys driver will just silently switch to software_debounce
> > >> without any notification.    
> > >
> > > I think that switching to software_debounce silently is exactly the
> > > intended/desired behavior of gpio-keys (and other drivers). For example,
> > > if the DT requests a 20ms debounce on a gpio-key, the existing math
> > > resulted in a hardware debounce of just 2ms. With the error return,
> > > gpio-keys would silently switch to software_debounce of the requested
> > > 20ms (potentially longer if the CPU is busy, but I don't think that's
> > > a problem for correctness), exactly what the DT asked for.
> > >
[...snip...]
> > >>
> > >> But agree - max might not be a good choose, so can you add dev_err() below, pls.    
> > >
> > > Given the above, I personally feel that a dev_err() is undesirable in most
> > > cases. If I have a system and matching DT that just happens to need a longer
> > > debounce than the GPIO HW is capable of, gpio-keys (etc) does the best it can automatically. I don't consider that there is any error in that case, or
> > > anything to be fixed.
> > > I can understanding wanting to draw attention to a change in behavior (just
> > > in case the DT is incorrect), but I'd personally lean towards dev_info() if
> > > anything.
> > >
> > > That said: if you still prefer dev_err(), I will certainly do so.    
> > 
> > Fair enough :) thanks.
> > 
> > Acked-by: Grygorii Strashko <grygorii.strashko@ti.com>  
> 
> Just to make sure I don't misunderstand, would you like me to:
> A) put in a dev_err() 
> B) put in a dev_info() 
> C) leave it as-is without any message 
> ?
> 
[...snip...]

FYI, I have searched for all uses of gpio{,d}_set_debounce (in v4.11-rc1), 
and found nothing concerning. Most drivers fall back to software debounce.
 
The only exception I found was mmc_spi (via mmc_gpio_request_cd), but the 
only time that has a non-zero debounce requested is for vision_ep9307 which 
is hardcoded to ask for a 1us debounce via platform data. I don't believe
ep93xx would use the gpio-omap driver anyways. The mmc-spi-slot devicetree
binding doesn't support setting a debounce on any of the GPIOs.
