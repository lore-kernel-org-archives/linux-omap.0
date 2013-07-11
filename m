From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] ARM: OMAP2+: omap_device: add pinctrl handling
Date: Wed, 10 Jul 2013 23:17:58 -0700
Message-ID: <20130711061757.GX5523@atomide.com>
References: <1371826990-25820-1-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdY=m1b9Lh27+wHP8FQ4SbVZKmAOCGhxe59aP+TcuR9QaA@mail.gmail.com>
 <20130625065811.GZ5523@atomide.com>
 <51CAEA90.90200@ti.com>
 <CACRpkdbKgEcfF67oO9HrczvDp4Po3Xt1hFajJ1vO8kEvsZH4jA@mail.gmail.com>
 <51CC45D3.2000305@ti.com>
 <CACRpkdYU13bhPaL2ZG9CT9JRv9sKQ+1N3zCUPizk571+LQqB4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYU13bhPaL2ZG9CT9JRv9sKQ+1N3zCUPizk571+LQqB4A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@linaro.org>, Hebbar Gururaja <gururaja.hebbar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [130710 13:42]:
> On Thu, Jun 27, 2013 at 4:01 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
> 
> > I think, In the future the OMAP pinctrl configurations would be manged in
> > more flexible way then now (thanks to "pinctrl PM helpers" and you;))
> > - "Idle" state will be splitted to "Idle"/"sleep"
> > - "default" state will be splitted to "default"/"active"
> 
> OK so the first ones we already have so the discussion is now down
> to adding the "active" state (and pinctrl_pm* helper function).

I think I have a patchset ready for pinctrl to allow multiple simulaneous
states as discussed, need to test it first though. Should be able to
post it on Friday hopefully.
 
> I guess we need a patch set prepared which adds the "active" state
> and helper function as the first patch, i.e. this:
> http://marc.info/?l=linux-kernel&m=137094012703340&w=2
> Can I have your ACK on this patch?

Hmm I have gone a bit further with the drivers/base/pinctrl.c in my
set where if active state is defined then sleep and idle states must
match active state for the pingroups to avoid constantly checking
those sets during runtime.

Then the pinctrl_pm_select_active_state() does not actually have
anything to do with PM in the rx/tx case, so we should rename that.

It's pretty close, but before we can apply that we need the changes
I have to allow multiple simultaneous states. I suggest wait just
few days on that patch.
 
> I do not want to add the state unless there is a clear consumer,
> so it needs to go in with the first patch to a device driver that uses
> pinctrl_pm_select_active_state() which will be a good demonstration
> on its use and utility. (And a point to object and suggest other ways
> to do the same thing...)

Right, we have quite a few consumers with omaps for that as am33xx
requires remuxing wake-up events for all drivers AFAIK. The MMC SDIO
pin remuxing is probably closest one ready.

Regards,

Tony
