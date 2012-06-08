From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [CFT 04/11] mmc: omap: add DMA engine support
Date: Fri, 8 Jun 2012 10:52:11 +0200
Message-ID: <CACRpkdYVSuH_hFcwkqo-i6-aTZrmFx5GP80RC8b3xdu=SWHeEg@mail.gmail.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
	<E1ScaYw-0003th-6i@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <E1ScaYw-0003th-6i@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jarkko Lavinen <jarkko.lavinen@nokia.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 7, 2012 at 1:07 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Add DMA engine support to the OMAP driver. =A0This supplements the
> private DMA API implementation contained within this driver, and the
> driver can be switched at build time between using DMA engine and the
> private DMA API.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This looks good as well:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
