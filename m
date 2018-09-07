From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: OMAP1: ams-delta: Clean up GPIO setup for MODEM
Date: Fri, 7 Sep 2018 09:56:22 -0700
Message-ID: <20180907165622.GI5662@atomide.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180820181333.2527-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Linus Walleij <linus.walleij@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180820 11:16]:
> 
> Convert modem related GPIO setup from integer space to GPIO descriptors.
> Also, restore original initialization order of the MODEM device and its
> related GPIO pins.
> 
> Cleanup of MODEM relaated regulator setup is postponed while waiting for
> upcoming conversion of fixed regulator API to GPIO descriptors.
> 
> 
> Janusz Krzysztofik (3):
>       ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
>       ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
>       ARM: OMAP1: ams-delta: register MODEM device earlier

Janusz, can you please repost this series based on v4.19-rc1
with Linus' acks?

At least the header file has moved around now.

And as this also conflicts with your earlier patch
"ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor"
please repost that too in the same series.

If you have other arch/arm/*omap*/* related patches then
please repost those too, these are the only ones I still had
tagged :)

Regards,

Tony
