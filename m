From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Fri, 26 Dec 2014 20:38:10 +0100
Message-ID: <CABxcv==hu46RXsOb8B0z-iduwpj0K3hcwj_YQ260ucTFYDmC8w@mail.gmail.com>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
	<54991A25.2030804@compulab.co.il>
	<20141223161936.GA9147@saruman>
	<549AA94A.8030209@compulab.co.il>
	<20141224154948.GA423@saruman>
	<20141224190401.GN23854@atomide.com>
	<549BE333.9060709@compulab.co.il>
	<20141226044246.GB7661@saruman>
	<549D4CEA.6090009@compulab.co.il>
	<CABxcv=n+FSuZemxQb2=wFM8m6xmWUKACnrCWFG-LevToU_UVHg@mail.gmail.com>
	<20141226151907.GD17430@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:58142 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbaLZTiL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Dec 2014 14:38:11 -0500
Received: by mail-wg0-f53.google.com with SMTP id l18so14712460wgh.26
        for <linux-omap@vger.kernel.org>; Fri, 26 Dec 2014 11:38:10 -0800 (PST)
In-Reply-To: <20141226151907.GD17430@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hello Felipe,

On Fri, Dec 26, 2014 at 4:19 PM, Felipe Balbi <balbi@ti.com> wrote:
>
> I wonder the same thing, but look at multi_v7_defconfig today. Almost
> everything is built-in, which makes the kernel image enormous (5.5MiB).
>
>> to get rid of the SoC specific configs then and just use the single
>> ARMv7 defconfig for all SoCs with most of the options enabled as a
>> module?
>
> if people accept switching some of those as modules, sure. I don't mind
> that at all. I'll still continue to maintain my out-of-tree defconfigs
> for my boards anyway. It's also very good to have a generic defconfig
> which will just work with everything I have.
>
>> FYI, some time ago I posted a patch to enable SBS-compliant batteries
>> support as a module for Exynos defconfig and was told to re-spin the
>> patch and enabling it as built-in instead since the most popular use
>> case for exynos_defconfig was development and people usually just copy
>> the kernel binary and not the modules [0].
>
> lol, that's the reason why I don't use multi_v7_defconfig.
>

Agreed, on its current form I wonder what's the use case for
multi_v7_defconfig. I guess most options will slowly be changed to be
built as a module though to be similar to what distros do.

>> can use omap2plus_defconfig as a base. So, is or is not expected that
>> people will use omap2plus_defconfig as a base for their own config?
>
> I never claimed that people should not use it as a *base*, rather it
> should not be used to build a product's kernel/modules. Imagine you
> shipping an embedded product based off of OMAP5 and you add CPSW, QSPI,
> MUSB, a ton of touchscreen drivers you don't use, several PMIC drivers
> built-in, etc. It's a waste of space and just bloats that product's
> zImage.
>

Got it, thanks for the clarification. I agree that omap2plus_defconfig
is very bloated to be used for products as-is. I also have custom
defconfig to test the OMAP boards I maintain which is basically
omap2plus_defconfig + a merged config fragment (using merge_config.sh)
that disables and enables needed options.

>> I think the problem is that there isn't an agreement about what is the
>> purpose of the per SoC (e.g: oma2plus_defconfig) and the multi_v7
>> defconfigs (or at least is not well documented since I could not find
>> it). So, IMHO this concern should be raised to the ARM SoC maintainers
>> and there should be an agreement in the ARM community as a whole about
>> how things should be configured on each defconfig, and all SoCs should
>> follow the agreed rule.
>
> OTOH, the OMAP defconfig is part of the OMAP port and Tony will have the
> final saying about it, right ?
>

Sorry, I didn't mean that Tony doesn't have the last word for omap
defconfig. My point was that it should be nice to get a consensus
about this and specially document it to make life easier for everyone.
People posting defconfig changes will know what the rule is and we can
avoid having these kind of discussions which I have had many times in
the past when posting defconfig changes and I'm sure I will have more
in the future again.

But I don't really mind tbh, I will keep maintaining my custom
defconfigs anyways and post wnen I think that enabling a config option
in a mainline defconfig makes sense and will do as a module or
built-in depending of what the SoC maintainer tells me to use.

Best regards,
Javier
