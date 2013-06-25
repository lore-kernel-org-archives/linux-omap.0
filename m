From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] ARM: OMAP2+: omap_device: add pinctrl handling
Date: Mon, 24 Jun 2013 23:58:11 -0700
Message-ID: <20130625065811.GZ5523@atomide.com>
References: <1371826990-25820-1-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdY=m1b9Lh27+wHP8FQ4SbVZKmAOCGhxe59aP+TcuR9QaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdY=m1b9Lh27+wHP8FQ4SbVZKmAOCGhxe59aP+TcuR9QaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@linaro.org>, Hebbar Gururaja <gururaja.hebbar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [130624 05:13]:
> On Fri, Jun 21, 2013 at 5:03 PM, Grygorii Strashko
> <grygorii.strashko@ti.com> wrote:
> 
> > Hence, add pinctrl handling in omap_device core:
> > 1) on PM runtime resume
> > - switch pinctrl state to "default" (todo: "active")
> > 2) on PM runtime suspend
> > - switch pinctrl state to "idle"
> > 3) during system wide suspend
> > - switch pinctrl state to "sleep" or "idle" if omap_device core disables device
> > - switch pinctrl state to "sleep" if device is disabled already

Do you need a separate setting for "idle" and "sleep", or are
they the same?

> > 4) during system wide resume
> > - switch pinctrl state to "default" (todo: "active") if omap_device core has
> >   disabled  device during suspend
> > - switch pinctrl state to "idle" if device was already disabled before suspend
> 
> I don't understand step 4.
> 
> I get the creeps about whether the system is runtime suspended
> or runtime resumed when we come to resume proper, so I need
> Kevin to have a look at this.
> 
> Apart from that it looks good.
> 
> Stephen and Tony are trying to figure out the details of whether "active"
> is necessary or not in a related thread I think.

Yes we should have that sorted out over next few weeks, so let's
just wait a little while on all these dynamic remuxing patches
to avoid churn.

Regards,

Tony
