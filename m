From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta-fiq: Use
 <linux/platform_data/gpio-omap.h>
Date: Thu, 20 Sep 2018 14:23:54 -0700
Message-ID: <20180920212354.GT5662@atomide.com>
References: <20180910174722.15679-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180910174722.15679-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180910 10:50]:
> Instead of defining symbols already defined in
> linux/platform_data/gpio-omap.h, use that header file.
> 
> Since we include the header into an assembler code, prevent C only bits
> from being read in.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Thanks applying into omap-for-v4.20/omap1.

Regards,

Tony
