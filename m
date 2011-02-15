From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv5 0/3] Introduce the /proc/socinfo and use it to export
 OMAP data
Date: Tue, 15 Feb 2011 13:58:00 +0100
Message-ID: <AANLkTin7vRMreG3hOAk95MYZUCV-Kr6ac7gD7jgvX6Gf@mail.gmail.com>
References: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1273587331-24604-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Linux-OMAP <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, ext Tony Lindgren <tony@atomide.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, Peter De-Schrijver <Peter.De-Schrijver@nokia.com>, santosh.shilimkar@ti.com, Ambresh <a0393775@ti.com>, felipe.balbi@nokia.com, Jouni Hogander <jouni.hogander@nokia.com>, Paul Mundt <lethal@linux-sh.org>, Lee Jones <Lee.Jones@linaro.org>, maxime.coquelin-nonst@stericsson.com, =?ISO-8859-1?Q?Jonas_=C5berg?= <jonas.aberg@stericsson.com>
List-Id: linux-omap@vger.kernel.org

2010/5/11 Eduardo Valentin <eduardo.valentin@nokia.com>:

> Here is the version 5 of the change to export OMAP data to userspace
> (name, revision, id code, production id and die id).
>
> Basically, this version is still attempting to create a new file under /proc.
> It is the /proc/socinfo, which should be used to export bits which are SoC specific
> (not CPU related, nor machine related).
>
> So, differences between previous version are:
> - merged patch 02/04 with 03/04 to avoid compilation breakages.
> - simplified the seq_file usage by using the single_open and single_release functions
> - exported a function to register a seq_operation .show callback
> - adapted the changes accordingly
>
> As usual, comments are welcome.

Eduardo, what has happened to this patchset?

Now we need something similar for arch/arm/mach-ux500 and I was sort of
hoping that this infrastructure would be in place already... wrong I was.

Do you want help in picking it up and try to polish it up?

Yours,
Linus Walleij
