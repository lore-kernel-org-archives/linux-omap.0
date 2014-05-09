From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: twl6040: Correct HPPLL configuration for 19.2 and
 38.4 MHz mclk
Date: Fri, 9 May 2014 11:00:53 +0100
Message-ID: <20140509100053.GQ5767@lee--X1>
References: <1399365970-19543-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399365970-19543-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, sameo@linux.intel.com
List-Id: linux-omap@vger.kernel.org

> When the MCLK is 19.2 or 38.4 MHz the HPPLL need to be enabled and ca=
n be
> put in bypass mode.
> This will fix HPPLL use on boards with 19.2MHz mclk.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/mfd/twl6040.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
