From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [CFT 02/11] mmc: omap_hsmmc: add DMA engine support
Date: Fri, 8 Jun 2012 10:53:17 +0200
Message-ID: <CACRpkdaq5AYZapS-YSTXa4atJQESiqKvmpnXBYE_aOD4+PkigQ@mail.gmail.com>
References: <20120607110610.GB15973@n2100.arm.linux.org.uk>
	<E1ScaYH-0003tV-Bn@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <E1ScaYH-0003tV-Bn@rmk-PC.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 7, 2012 at 1:06 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> Add DMA engine support to the OMAP HSMMC driver. =A0This supplements =
the
> private DMA API implementation contained within this driver, and the
> driver can be switched at build time between using DMA engine and the
> private DMA API.
>
> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Looks good:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
