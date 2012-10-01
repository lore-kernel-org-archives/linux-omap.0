From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] leds: leds-gpio: adopt pinctrl support
Date: Mon, 1 Oct 2012 08:44:52 -0700
Message-ID: <20121001154451.GI4840@atomide.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CACRpkdbSY-aH_Vf3Q4h-ufz35m6=vVXCEecGGS-WOsG7vmPZ0g@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA3E24E@DBDE01.ent.ti.com>
 <CACRpkdZ_NxST-oJ=MWC5L=r8uQD_71eHUVUR85v4jfsYpqz=UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZ_NxST-oJ=MWC5L=r8uQD_71eHUVUR85v4jfsYpqz=UQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "dong.aisheng@linaro.org" <dong.aisheng@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "AnilKumar, Chimata" <anilkumar@ti.com>, "bryan.wu@canonical.com" <bryan.wu@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [121001 01:25]:
> On Mon, Oct 1, 2012 at 9:03 AM, AnilKumar, Chimata <anilkumar@ti.com> wrote:
> 
> >    I have gone through the "Don Aisheng" patch series, which
> > adds "pinctrl_dt_add_gpio_ranges" support but not accepted
> > yet. With this patch series we can overcome the driver changes.
> 
> OK then this is the direction we need to go.
> 
> > 4. The current pinctrl driver has support for these APIs
> > pinctrl_request_gpio(), pinctrl_free_gpio(),
> > pinctrl_gpio_direction_input/output()
> > no API for slew rate control, pulled down/up control
> > how can we handle this?
> 
> You are not supposed to handle that from the GPIO level
> of the API. That is supposed to be handled by pinctrl.
> 
> These two subsystems are orthogonal, with the exception
> of the above calls. If you need to pass more information
> between the GPIO and pinctrl interfaces it usually means
> you're doing something wrong.
> 
> The reason why pinctrl was created in the first place
> was that Grant didn't like that we started to shoehorn all
> kind of pin control into the GPIO subsystem.

Agreed.
 
> > 5. pinctrl-single driver has to modify to provide separate handles
> > for pinmux and pinconfig. And we need separate pin configuration
> > bit masks and values/flags to take care of pull-up/down, slew rate,
> > receiver in/out and mux mode control.
> 
> OK that is typical pinctrl driver implementation work.
> I hope Tony can advice on this?

I think we're best off to just stick to alternative named modes
passed from device tree. For example, for GPIO wake-ups you can
have named modes such as "default", "enabled" and "idle" where
"idle" muxes things for GPIO wake-ups for the duration of idle.

It seems that should also work for leds-gpio. And you can
define more named modes as needed.

You really don't want the client driver or the GPIO driver doing
things like pull-up/down automatically as that is board specific and
can also depend on things like externall pull resistors.

> > 6. This is for my understanding, on which node do we have to add
> > pinctrl data i.e., pin mux-mode data. In leds-gpio node (mostly not)
> > and if it is in gpio node then how can we pass pinmux data with
> > the existing API pinctrl_request_gpio(gpio);? Here we are passing
> > only gpio number.
> 
> So with the pinctrl_request_gpio() call you are requesting a single
> pin to be used as GPIO, nothing else.
> 
> No additional data should be passed with that call.

Yeah I agree.
 
> Implementing it is up to the pinctrl driver, the pinctrl subsystem
> API does not say anything about how this should be done, but
> there are a few examples.
>
> The pinctrl maps of muxes and config from the pin control
> subsystem are for entire devices, and the single-pin GPIO
> reservation API is orthogonal to this, please consult
> Documentation/pinctrl.txt if you are uncertain about what
> I mean with this, I've really tried to explain it there.
> 
> The docs were recently amended to reflect some corner-case
> GPIO uses, see e.g.:
> http://marc.info/?l=linux-arm-kernel&m=134763067415678&w=2
> 
> > Few more driver patches are pending along with this (leds-gpio DT
> > data additions according to this patch, similarly other drivers
> > like matrix keypad and volume keys)
> 
> OK so the threshold is that we need to get it right for the first
> one and then the others will look good too.

It seems we want to keep leds-gpio, gpio framework and pinctrl
framework generic. It also seems you should be able to do
what you're describing using the pinctrl named modes.

Regards,

Tony
