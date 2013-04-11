From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Thu, 11 Apr 2013 14:30:51 -0600
Message-ID: <51671D7B.5060303@wwwdotorg.org>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <4F452484.5080503@gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com>
 <4F47AD08.4030504@ti.com>
 <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
 <512D39DA.7020306@ti.com> <512D3AB1.1080202@wwwdotorg.org>
 <512D3EC2.6050408@ti.com> <20130302200524.D230F3E1571@localhost>
 <51391F41.5000303@ti.com>
 <CAAwP0s1CFRO-rf==p5sYs1n0gigMif7wuT8Yv0N_iLUDMrtcOg@mail.gmail.com>
 <CACRpkdYHj-rEF3Rk_CWnmmMw_Amr7m8SgQ=-2zsDYuLeuu3azw@mail.gmail.com>
 <514C79E1.4090106@wwwdotorg.org> <514CE0AB.6060207@ti.com>
 <CACRpkdZmv-rAoKSQYpkHHSMzKJOn5TixVW_P3=m7ZNagBYCUPw@mail.gmail.com>
 <515319D5.20105@wwwdotorg.org>
 <CACRpkdYXVLgCz1Tyu-Ls2V2OTc4R3cGNJhfQJB6Hiz_K9dkZYQ@mail.gmail.com>
 <5155C902.7080207@wwwdotorg.org>
 <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
 <5165CB9D.1090202@wwwdotorg.org>
 <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Jon Hunter <jon-hunter@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 04/10/2013 03:28 PM, Linus Walleij wrote:
> On Wed, Apr 10, 2013 at 10:29 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 04/10/2013 12:12 PM, Linus Walleij wrote:
> 
>>> If the information is there, whether to convert from IRQ to GPIO
>>> or from GPIO to IRQ is a technicality and any order should be
>>> feasible in some way?
>>
>> There isn't always a unique 1:1 mapping between GPIOs and IRQs. Put
>> another way, a single GPIO would likely only ever trigger a single IRQ,
>> but a single IRQ might easily be triggered by any number of GPIOs. This
>> is exactly why the function irq_to_gpio() isn't something one should use
>> any more. I think there was an effort to outright remove the API,
>> although it doesn't look like that's entirely complete yet. I guess you
>> know this given your mentions of problem with gpio_to_irq() later on, so
>> I'm not quite sure what your paragraph above was supposed to mean.
> 
> So the only reason I'm rambing on about this is that it breaks the

I'm not sure I understand this paragraph; what is "it" in the line above.

If "it" is this patch, then should "breaks" be re-establishes?

> connection between GPIOs and their IRQs and at one point
> I percieved it as there was going to be some IRQ -> GPIO lookup,
> and it would sneak back in. But now I realize that may have been
> supposed to be something local to the driver, in it's irqchip portions
> and then it's actually no problem for the kernel at large.

Yes, I believe the intention was for their to be a correlation between
GPIOs and IRQs only with the individual gpio_chip/irq_chip drivers for
those GPIOs/IRQs, and not exposed anywhere outside it.

> Let's restate: I'm also after something fragile here.

I assume you mean the opposite of that?

> IIUC, it will be possible for a GPIO to be set up as input and used
> as an IRQ without the GPIO subsystem knowing it. And it will be
> possible for the GPIO subsystem to go in and request the same pin
> and set it as output and e.g. bit-bang it. I wonder what happens then.

Yes, I think that's possible now.

If I recall the patch I'm replying to correctly, the idea was to add an
"IRQ request" operation that would (internally to the GPIO/IRQ driver
itself) map IRQ->GPIO, and call gpio_request(). That would then prevent
exactly the situation you mention above.
