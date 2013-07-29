From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] pinctrl: Add support for additional dynamic states
Date: Mon, 29 Jul 2013 02:31:25 -0700
Message-ID: <20130729093125.GB7656@atomide.com>
References: <20130716090310.5541.36777.stgit@localhost>
 <20130716090536.5541.36289.stgit@localhost>
 <CACRpkdY6-f1DKfPDfCpYAX9weXMtB7koJ3VwkRgHGm_MzgFawQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdY6-f1DKfPDfCpYAX9weXMtB7koJ3VwkRgHGm_MzgFawQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [130722 16:14]:
> On Tue, Jul 16, 2013 at 11:05 AM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > To toggle dynamic states, let's add the optional active state in
> > addition to the static default state. Then if the optional active
> > state is defined, we can require that idle and sleep states cover
> > the same pingroups as the active state.
> 
> OK...
> 
> > Then let's add pinctrl_check_dynamic() and pinctrl_select_dynamic()
> > to use instead of pinctrl_select() to avoid breaking existing users.
> >
> > With pinctrl_check_dynamic() we can check that idle and sleep states
> > match the active state for pingroups during init, and don't need to
> > do it during runtime.
> 
> I do not understand why this complexity need to be exposed outside
> of the subsystem.

Unfortunately it's mostly to deal with supporting the current behaviour
of pinctrl_select_state() which is not quite suitable for runtime PM.
 
> pinctrl_select_state() and the PM accessors are enough IMO. Why
> should say a driver care about whether it is dynamic or not?

I think we can make this all transparent to the consumer drivers
for runtime PM. Basically drivers/base/pinctrl.c needs these for the
checks because of the current pinctrl_select_state().
 
> Surely the checking and different paths for static/dynamic configurations
> can be an intrinsic detail of the pinctrl subsystem, by adding flags and
> members to private structs like struct pinctrl itself in worst case.

I'll take a look if we can bury more things inside the pinctrl
subsystem.
 
> So I'm not buying into this, it looks like it is making things complicated
> for consumers outside the subsystem for no reason.

I don't think the consumer drivers eventually need to do much
anything ideally. We're missing runtime PM related set_irq_wake()
but that's a minor detail as we can initially keep the runtime
PM related wake-up events always enabled.

Regards,

Tony
