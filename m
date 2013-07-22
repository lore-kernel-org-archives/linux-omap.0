From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] pinctrl: Remove duplicate code in pinctrl_pm_select_state
 functions
Date: Tue, 23 Jul 2013 00:43:35 +0200
Message-ID: <CACRpkdYbXEPmHwzGMwJ9e-VEJsOumYboGdQcPHqbq87FNL3fBw@mail.gmail.com>
References: <20130718151213.30990.45828.stgit@localhost>
	<20130718151504.30990.96819.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130718151504.30990.96819.stgit@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 18, 2013 at 5:15 PM, Tony Lindgren <tony@atomide.com> wrote:

> There's no need to duplicate essentially the same functions. Let's
> introduce static int pinctrl_pm_select_state() and make the other
> related functions call that.
>
> This allows us to add support later on for multiple active states,
> and more optimized dynamic remuxing.
>
> Note that we still need to export the various pinctrl_pm_select
> functions as we want to keep struct pinctrl_state private to the
> pinctrl code, and cannot replace those with inline functions.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Aha that is how to do it. Stephen complained about it earlier
but I couldn't come up with a good enough refactoring.

Patch applied.

Yours,
Linus Walleij
