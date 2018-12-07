From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Fix audio permanently muted
Date: Fri, 7 Dec 2018 08:53:36 -0800
Message-ID: <20181207165336.GP6707@atomide.com>
References: <20181123111945.6016-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181123111945.6016-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [181123 03:18]:
> Since commit 1137ceee76ba ("ARM: OMAP1: ams-delta: Don't request unused
> GPIOs"), on-board audio has appeared muted.  Believed to be unused GPIO
> pin "hookflash1", apparently set high regardless of the corresponding
> bit of "latch2" port attempted to be set low during .init_machine(),
> has been identified as the reason.
> 
> According to Amstrad E3 wiki, the purpose of the pin hasn't been
> clearly identified.  Original Amstrad software used to produce a high
> pulse on it when the phone was taken off hook or recall was pressed.
> With the current finding, we can assume the pin provides a kind of
> audio mute function.
> 
> Proper resolution of the issue should be done in two steps:
> - resolution of an issue with the pin state not reflecting the value
>   the corresponding bit of the port was attempted to be initialized
>   with,
> - extension of on-board audio driver with a new control.
> 
> For now, rename the pin to "audio_mute" to reflect its function and,
> as a quick fix, hogg it as output low so on-board audio can produce
> audible sound again.
> 
> Fixes: 1137ceee76ba ("ARM: OMAP1: ams-delta: Don't request unused GPIOs")
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Adding into omap-for-v4.20/fixes thanks.

Tony
