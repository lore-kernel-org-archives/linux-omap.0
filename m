Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDBB4078D2
	for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166808; cv=none; b=suDiapZ/i/qpRfibez623BPaW5V2RmUFlmLRWO7Hk9AKJWI82I1NRv7HjZg+9If2Mq5IPh9l67xAE+xOF7X1XuOg8U/CVkOO9MCU4D9+TNXxli4KhK3Wz7wCPGALbbx/5iXFGbTZ+mt6HHFgb+pYxnnR7ZupfAvwh4NQ1jhPQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166808; c=relaxed/simple;
	bh=GSvf9tiJTgNAYDBIQVpJtLQwvRj2IRYKk6mKKCQJXkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1vtGVeTdnXSmvHPACCWaNeylcJPl+rqL7ChyPKdrT8mmQDvAIHSAHC2lxuHM3o7dwsLAtEd0s8wJ2uoiL0d1KIIt69LWA9DF3viU8sCl/K2JTJNds/ZpifWp9L6+rtcN85EVfc6j5b3FBg/jtiUtKVUjiiOAz129R7PR9q1Ulg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso622960e0c.1
        for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 12:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787166802; x=1787771602;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2hrEOT6/riKwFJGpTfOre0kcDNbj58vo1NWhzAcptM0=;
        b=NqY3ZfM71VzR+IYd8wgQmNxAtEoMXSuyRWRKfserLy3bN6vVuuRByvr+jpvihnccDB
         FjUhVjhieVSg39Hy1mV6F9v+zIIcar5jBSPCw3QgzQdA1u4EvcPjX16XWdQacGOjlPYO
         sbntMFc9U4907kLFiPEWJd4QaooAswsxp9lEMjD/tQdcO5arDxSJDwSK/T12/4SOvSMP
         oDxF00EYio2M7MvqeJPUFuYtn4k/6ziiLo/FjPuaX34mDI018XJbgQuXTVWPqjvWA1+9
         tGPaP8SH38NX0YzAaLUO/7SyD9WG9bXpu2ZCYla9lSAweVadtaOl00ljEElmzGSxKReK
         jE1g==
X-Forwarded-Encrypted: i=1; AHgh+Rp3reTi3NXP6EyvoNK2QfRiI19SDr4CEPgVJL6GpPncdTHraV1t7GjmHOyXz4tvpYBqJsTKg5OzqaFa@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1MAg5ovc7bFVCdF15AUbD/CIHmGSiWnVPco0Zs3kjQHDIngOe
	IhPy62mTulTh6yE4Dw6lrZcTa3l0DPDqTHplg+kk1jKznsWDSJ2SsH96xWQ6keIl
X-Gm-Gg: AR+sD136M6u7Wv01nhXtXtfw9NlAshamAUqR/1HWH2jZOV6t4wYWZgf+U9lLZPYHz4f
	1WzyfcG/hDEuSED3SWAdSDAmJ4OVHaRy4Zb74vzGz0C1TeBFHqQTv0dNECRsMpWUZgy+5CoSk4P
	WoByAFsAj05ZKDH5clVkeooee0bMRViELAzFRNnR85a9EhfKl6To3nzNLYt8q7pzdVIJ1WzL+nk
	1E540GjwRUXAw6iHgbV9sCtWHPZr8ue8qfhdEdE13pJXqeL7YG/EtJWqLF/IA9SFSu3dRiq9zJ8
	TTG3Qjzn50BZuylaAGh/Lh8KAObj3XD2iDhXA6QUU6h64v+5L4dBeRu7oHmRnvcHJild9S9Fsax
	BaYsKaj+ECOo/y0f8AVRb0s1vTlkMyZXp3mYeQndSLrGx487PqtdjzXMkbCe+yMOX3wbG42PDCU
	NjMNTtAKEOxNnAz1bvq2yLOGehbsdmvuvdYX02uZGZ1sYmb/51x1by3ieZcoXgenob8alo3hVjd
	8IkWUDDK6gmPRNZ2zFIpx+SghLdLb7L0eX+
X-Received: by 2002:a05:6102:c10:b0:726:cd42:d023 with SMTP id ada2fe7eead31-777faba59c7mr2164029137.11.1787166802255;
        Wed, 19 Aug 2026 12:13:22 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-777daea8e4bsm3353983137.2.2026.08.19.12.13.21
        for <linux-omap@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 12:13:21 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-754ac74c495so602418137.0
        for <linux-omap@vger.kernel.org>; Wed, 19 Aug 2026 12:13:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpToKOA1ZyPYYiZtXCHWfND+bjoFv3hiniANCciLHzMf+CoSQq7PFLV/81+5J0u+zSnxyEtsoTdUMLU@vger.kernel.org
X-Received: by 2002:a05:6102:e0c:b0:778:5369:763d with SMTP id
 ada2fe7eead31-778536977cfmr1785402137.1.1787166800995; Wed, 19 Aug 2026
 12:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727-mathieu-wdt-clock-theo-v2-0-c048a6394436@bootlin.com>
 <20260727-mathieu-wdt-clock-theo-v2-1-c048a6394436@bootlin.com>
 <CAMuHMdU3yVqoyHC4eNF2NuYo8wy+6ODLoYat4R71X99Mxc_=kw@mail.gmail.com>
 <DKSOGEFQ4RJA.3LEW2Y8991H17@bootlin.com> <CAMuHMdVfFZ0P9Na-yD9EzBaUqkyiwjo8byxA2MouBt1DM8xQtA@mail.gmail.com>
 <DKT0MN8YMIAT.2ZI006JRL0OJ@bootlin.com>
In-Reply-To: <DKT0MN8YMIAT.2ZI006JRL0OJ@bootlin.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Aug 2026 21:13:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUsupXQb7Y59ri8wtrjixPpWoLRk5SsuieZLjKG4Y+gwA@mail.gmail.com>
X-Gm-Features: AcwNN1Xiw6RIMxHvPKUqNZp5ReyoCIje1jZT2LSNhpvxk-1rbWAWtnl6RZSRLC8
Message-ID: <CAMuHMdUsupXQb7Y59ri8wtrjixPpWoLRk5SsuieZLjKG4Y+gwA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: ti: mux: resolve parent clocks by DT index,
 not by name
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Tero Kristo <kristo@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, Tony Lindgren <tony@atomide.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	=?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matti Vaittinen <mazziesaccount@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mathieu,

On Wed, 19 Aug 2026 at 17:12, Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:
> On Wed Aug 19, 2026 at 2:32 PM CEST, Geert Uytterhoeven wrote:
> > On Wed, 19 Aug 2026 at 07:39, Mathieu Dubois-Briand
> > <mathieu.dubois-briand@bootlin.com> wrote:
> >> On Tue Aug 18, 2026 at 6:02 PM CEST, Geert Uytterhoeven wrote:
> >> > On Mon, 27 Jul 2026 at 09:44, Mathieu Dubois-Briand
> >> > <mathieu.dubois-briand@bootlin.com> wrote:
> >> >> Resolve parent clocks by their index into the device tree "clocks"
> >> >> property rather than matching names as strings. Name-based matching is
> >> >> fragile because a clock's "clock-output-names" value in its provider
> >> >> node can differ from the name used to reference it in a consumer node,
> >> >> and because names must be globally unique across all clock providers.
> >> >>
> >> >> On AM335x, this caused broken clock trees where some clocks failed to
> >> >> enable because their parents could not be found.
> >> >>
> >> >> Replace of_clk_parent_fill() with a clk_parent_data array that sets
> >> >> .index to the array position.
> >> >>
> >> >> Fixes: ec7aa25fa483 ("ARM: dts: Use clock-output-names for am3")
> >> >> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> >> >
> >> > Thanks for your patch, which is now commit 667f420c09f1417c ("clk: ti:
> >> > mux: resolve parent clocks by DT index, not by name") in clk/clk-next.
> >> >
> >> > This breaks booting BeagleBone Black for me: I don't get any output
> >> > on the serial console, even with "earlycon keep_bootcon".  When the
> >> > watchdog kicks in (or on kernel panic?), the system reboots.

> > With omap2plus_defconfig and multi_v7_defconfig, it does boot.  However,
> > this commit does have an impact on /sys/kernel/debug/clk/clk_summary:
> >
> > --- summary-7.2.0-rc2-00106-g0d4d262c1664       2026-08-19
> > 10:56:51.622275674 +0200
> > +++ summary-7.2.0-rc2-00107-g667f420c09f1       2026-08-19
> > 10:58:13.929823890 +0200
> > ...
> >
> > I.e. wdt1_fck changed its parent from clk_rc32k_ck to
> > clk-24mhz-clkctrl:0000:0, which is probably not intended?
> >
>
> This was definitely not intended, but I believe this is a valid
> configuration.
>
> wdt1_fck has two potential parents. In the device tree
> (am33xx-clocks.dtsi), we have:
>
>         wdt1_fck: clock-wdt1-fck@538 {
>                 ...
>                 clocks = <&clk_rc32k_ck>, <&clk_24mhz_clkctrl AM3_CLK_24MHZ_CLKDIV32K_CLKCTRL 0>;
>                 ...
>         };
>
> As I understand it, the kernel is free to select any of the parents
> here. Is that correct?
>
> Previously, the link with the second parent was broken, and only the
> first parent was known. That was my initial issue that triggered my
> changes. Now, both parents can be selected. I assume the second one is
> seen as a better option for some reason, and so now it is selected.
>
> But maybe my assumption are wrongs, so feel free correct me here.

Thanks, that sounds like a good explanation!

> > However, that is not the cause of the crash.  My .config has
> > CONFIG_INIT_STACK_ALL_PATTERN enabled, so any uninitialized local
> > variables contain garbage.
> >
> >> @@ -136,7 +136,7 @@ static struct clk *_register_mux(struct device_node *node, const char *name,
> >>         init.name = name;
> >>         init.ops = &ti_clk_mux_ops;
> >>         init.flags = flags;
> >> -       init.parent_names = parent_names;
> >> +       init.parent_data = parent_data;
> >>         init.num_parents = num_parents;
> >>
> >>         /* struct clk_mux assignments
> >
> > Init is not fully initialized, hence init.parent_names contains garbage
> > (before, .parent_data contained garbage).
> > As clk_core_populate_parent_map() prioritizes .parent_names over
> > .parent_data, the uninitialized .parent_data didn't cause any harm before.
>
> Nice catch. I didn't realise that while doing my changes.
>
> Thanks for taking the time to track this issue.

You're welcome!

I submitted a first set of fixes, incl. "[PATCH treewide 1/5] clk:
ti: Make sure clk_init_data is fully initialized"
https://lore.kernel.org/e6f52b34163c8e708c1100107b437af0b3b049a6.1787165329.git.geert+renesas@glider.be/
I will submit the remainder (way too many) later...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
