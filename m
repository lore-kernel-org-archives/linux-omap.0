From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC PATCH 04/11] asm-generic: fncpy: Add function copying macros
Date: Tue, 17 Sep 2013 16:23:51 +0200
Message-ID: <CAMuHMdVT-hhJnww64mFa6nubHrHk-ZHuoe9GwGgBCEA2G0B2Bg@mail.gmail.com>
References: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
	<1379421817-15759-5-git-send-email-Russ.Dill@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1379421817-15759-5-git-send-email-Russ.Dill@ti.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, mans@mansr.com, Shawn Guo <shawn.guo@linaro.org>, Dave Martin <Dave.Martin@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 17, 2013 at 2:43 PM, Russ Dill <Russ.Dill@ti.com> wrote:
> +++ b/arch/alpha/include/asm/fncpy.h
> @@ -0,0 +1 @@
> +#include <asm-generic/fncpy.h>

Please add

    generic-y += fncpy.h

to arch/<arch>/include/asm/Kbuild instead.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
