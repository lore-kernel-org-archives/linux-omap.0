From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 10/15] mfd: menelaus: Pass menelaus_chip argument to
 menelaus <-> time helpers
Date: Tue, 10 Dec 2013 09:02:29 +0000
Message-ID: <20131210090229.GS12675@lee--X1>
References: <20131209161422.GC24047@saruman.home>
 <1386606085-26838-1-git-send-email-balbi@ti.com>
 <1386606085-26838-10-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386606085-26838-10-git-send-email-balbi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, 09 Dec 2013, Felipe Balbi wrote:

> time_to_menelaus() and menelaus_to_time() are static and can easily
> receive a struct menelaus_chip pointer argument.
>=20
> After this patch, the_menelaus is only used on exported functions whi=
ch
> are currently being used by board-n8x0.c.
>=20
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/mfd/menelaus.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Same.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
