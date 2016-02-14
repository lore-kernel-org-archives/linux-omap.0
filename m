From: "Kim, Milo" <milo.kim@ti.com>
Subject: Re: [PATCH v2 2/4] regulator: lp872x: Add enable GPIO pin support
Date: Mon, 15 Feb 2016 08:37:47 +0900
Message-ID: <56C10FCB.5070803@ti.com>
References: <1454697741-8687-1-git-send-email-contact@paulk.fr>
 <1454697741-8687-3-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454697741-8687-3-git-send-email-contact@paulk.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 2/6/2016 3:42 AM, Paul Kocialkowski wrote:
> LP872x regulators are made active via the EN pin, which might be hooked to a
> GPIO. This adds support for driving the GPIO high when the driver is in use.
>
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>   .../devicetree/bindings/regulator/lp872x.txt       |  1 +
>   drivers/regulator/lp872x.c                         | 34 ++++++++++++++++++++++
>   include/linux/regulator/lp872x.h                   |  5 ++++
>   3 files changed, 40 insertions(+)

Acked-by: Milo Kim <milo.kim@ti.com>

Best regards,
Milo
