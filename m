From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: ams-delta: Don't request unused GPIOs
Date: Thu, 20 Sep 2018 14:24:59 -0700
Message-ID: <20180920212459.GU5662@atomide.com>
References: <20180910195008.24127-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180910195008.24127-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180910 12:53]:
> GPIOs with no kernel drivers can still be used from user space, don't
> request them from the board file.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Thanks applying into omap-for-v4.20/omap1.

Regards,

Tony
