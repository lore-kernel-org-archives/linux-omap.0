From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC] ARM: OMAP2+: omap_device: add pinctrl handling
Date: Mon, 22 Jul 2013 23:00:07 +0200
Message-ID: <CACRpkdYrXcYvXO=vJ1RxLkv4ou_08M3tS_gffDnwqEtod-68Ow@mail.gmail.com>
References: <1371826990-25820-1-git-send-email-grygorii.strashko@ti.com>
	<CACRpkdY=m1b9Lh27+wHP8FQ4SbVZKmAOCGhxe59aP+TcuR9QaA@mail.gmail.com>
	<20130625065811.GZ5523@atomide.com>
	<51CAEA90.90200@ti.com>
	<CACRpkdbKgEcfF67oO9HrczvDp4Po3Xt1hFajJ1vO8kEvsZH4jA@mail.gmail.com>
	<51CC45D3.2000305@ti.com>
	<CACRpkdYU13bhPaL2ZG9CT9JRv9sKQ+1N3zCUPizk571+LQqB4A@mail.gmail.com>
	<51E0227E.2000008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51E0227E.2000008@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@linaro.org>, Hebbar Gururaja <gururaja.hebbar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 12, 2013 at 5:36 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> On 07/10/2013 11:36 PM, Linus Walleij wrote:
>>
>> I guess we need a patch set prepared which adds the "active" state
>> and helper function as the first patch, i.e. this:
>> http://marc.info/?l=linux-kernel&m=137094012703340&w=2
>> Can I have your ACK on this patch?
>
> I've verified combination of
> [PATCH] drivers: pinctrl: add active state to core
> [RFC] ARM: OMAP2+: omap_device: add pinctrl handling
> on OMAP4 SDP board+UARTs and going to send patches on Monday.
>
> So, Acked/Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> (I can't reply directly to thread - not signed to those lists :))
>
> What is the best branch to base my patches on?

I suggest you coordinate that with Tony. He can take my patch
with your ACK if it helps, but it seems he's already up to
optimizing the pinctrl core :-)

Yours,
Linus Walleij
