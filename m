From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 03/20] ARM: OMAP4: PM: add support for device off
Date: Thu, 14 Jun 2012 12:18:42 +0300
Message-ID: <1339665522.2091.164.camel@sokoban>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
	 <1339515095-9908-4-git-send-email-t-kristo@ti.com>
	 <CAORVsuUJOpQu1qE7qmK9PS79JZJ065egqcpfgmsWNHwnhLUdvw@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38579 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab2FNJSv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 05:18:51 -0400
In-Reply-To: <CAORVsuUJOpQu1qE7qmK9PS79JZJ065egqcpfgmsWNHwnhLUdvw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Wed, 2012-06-13 at 17:21 +0200, Jean Pihet wrote:
> Hi Tero,
> 
> I have a few remarks regarding the genericity of this code. I think it
> is better if the code in powerdomain.c stays generic and that the
> platform specific checks and operations be moved in the specific
> functions (via the pwrdm_ops struct).

Well, I was thinking about this, however it looks like I need to copy
over most of the implementation of omap_set_pwrdm_state and
get_next_achievable_state if I want to do that, or alternatively
overload the underlying omap4 pwrdm code which does not seem that good
solution either.

> 
> On Tue, Jun 12, 2012 at 5:31 PM, Tero Kristo <t-kristo@ti.com> wrote:
> > On OMAP4+, device wide off-mode has its own enable mechanism in addition
> > to powerdomain target states. This patch adds support for this on top
> > of functional power states by overloading the OFF state for core pwrdm.
> > On pwrdm level, the deepest power state supported by core pwrdm is OSWR.
> > When user (e.g. suspend) programs core pwrdm target as OFF, the functional
> > power state for the domain will be OSWR with the additional device off
> > enabled. Previous power state information will reflect this also.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/powerdomain.c           |   17 +++++++++
> >  arch/arm/mach-omap2/powerdomain.h           |   13 +++++++-
> >  arch/arm/mach-omap2/powerdomain44xx.c       |   48 +++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/powerdomains44xx_data.c |    3 +-
> >  4 files changed, 79 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> > index ac63f86..78a9308 100644
> > --- a/arch/arm/mach-omap2/powerdomain.c
> > +++ b/arch/arm/mach-omap2/powerdomain.c
> > @@ -677,6 +677,8 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 func_pwrst)
> >        int sleep_switch = -1, ret = 0, hwsup = 0;
> >        int new_func_pwrst, next_func_pwrst, pwrst, logic;
> >        u8 curr_pwrst;
> > +       bool extra_off_enable = false;
> > +       bool has_extra_off = false;
> >
> >        if (!pwrdm || IS_ERR(pwrdm)) {
> >                pr_debug("%s: invalid params: pwrdm=%p\n", __func__, pwrdm);
> > @@ -687,6 +689,13 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 func_pwrst)
> >
> >        mutex_lock(&pwrdm->lock);
> >
> > +       /* Check if powerdomain has extra off mode handling */
> > +       if (pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE) {
> > +               has_extra_off = true;
> > +               if (func_pwrst == PWRDM_FUNC_PWRST_OFF)
> > +                       extra_off_enable = true;
> > +       }
> Could those checks be moved in the OMAP4 specific functions, so that
> the power domain code stays generic?

I'll try to do that and see what happens. The problem I tried to tackle
with this implementation is that even when core next state is programmed
to func OFF, we must program the powerdomain itself to OSWR, which the
current functional pwrst framework does not support too well.... or as
you say, I need to re-write the omap4 pwrdm state handling code itself
which kind of eats the benefit of the functional power states away.

> 
> > +
> >        new_func_pwrst = pwrdm_get_achievable_func_pwrst(pwrdm, func_pwrst);
> >        pwrst = pwrdm_func_to_pwrst(pwrdm, new_func_pwrst);
> >        logic = pwrdm_func_to_logic_pwrst(pwrdm, new_func_pwrst);
> > @@ -741,6 +750,9 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 func_pwrst)
> >                break;
> >        }
> >
> > +       if (has_extra_off && arch_pwrdm->pwrdm_enable_off)
> > +               arch_pwrdm->pwrdm_enable_off(pwrdm, extra_off_enable);
> > +
> >  out:
> >        mutex_unlock(&pwrdm->lock);
> >        return ret;
> > @@ -810,6 +822,11 @@ int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm)
> >        int next_pwrst = pwrdm_read_next_pwrst(pwrdm);
> >        int next_logic = pwrdm_read_logic_retst(pwrdm);
> >
> > +       if (pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE &&
> > +           arch_pwrdm->pwrdm_read_next_off &&
> > +           arch_pwrdm->pwrdm_read_next_off(pwrdm))
> > +               return PWRDM_FUNC_PWRST_OFF;
> > +
> Same comment here. The OMAP4 specific function for
> pwrdm_read_next_pwrst could return PWRDM_FUNC_PWRST_OFF.

Same issue.

Anyway, I'll try to fiddle with the code bit more and see what happens.

-Tero


