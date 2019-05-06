From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Remove MODULE_ALIAS() calls that take undefined macro
Date: Mon, 6 May 2019 14:11:20 -0700
Message-ID: <20190506211120.GR8007@atomide.com>
References: <1557163697-17882-1-git-send-email-yamada.masahiro@socionext.com>
 <6d8e2880-0cc0-a7d8-1d42-4401e15e3ac9@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6d8e2880-0cc0-a7d8-1d42-4401e15e3ac9@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kbuild@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Alexey Gladkov <gladkov.alexey@gmail.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Lee Jones <lee.jones@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Daniel Lezcano <daniel.lezcano@linaro.org> [190506 17:40]:
> On 06/05/2019 19:28, Masahiro Yamada wrote:
> > These files do not define (USBHS_)DRIVER_NAME. Yet, they can be
> > successfully compiled because they are never built as a module by
> > anyone, i.e, the MODULE_ALIAS() calls are always no-op.
> > 
> > A problem showed up when a patch "moduleparam: Save information about
> > built-in modules in separate file" is applied. With this new feature,
> > MODULE_*() are populated even if the callers are built-in.
> > 
> > To avoid the build errors, the lines referencing to the undefined
> > macro must be removed.
> > 
> > The complete fix is to remove all MODULE_* and #include <linux/module.h>
> > like many "make ... explicitly non-modular" commits did.
> > 
> > For now, I am touching the offending lines.
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks, please feel free to merge together with your series:

Acked-by: Tony Lindgren <tony@atomide.com>

Or if you want me to queue it separately, please let me know.

Regards,

Tony
