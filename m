From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 07/10] ASoC: OMAP: ams-delta: Drive modem/codec pins
 over GPIO API
Date: Wed, 21 Dec 2011 18:33:44 +0000
Message-ID: <1324492424.8478.5.camel@odin>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
	 <1323634328-856-8-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323634328-856-8-git-send-email-jkrzyszt@tis.icnet.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-omap@vger.kernel.org

On Sun, 2011-12-11 at 21:12 +0100, Janusz Krzysztofik wrote:
> Don't use Amstrad Delta custom I/O functions any longer, replace them
> with GPIO. Old pin definitions, no longer used by the modem bits either,
> can be dropped.
> 
> Depends on patch 2/10 "ARM: OMAP1: Convert Amstrad E3 latches to
> basic_mmio_gpio".
> 
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Applied.

Thanks

Liam
