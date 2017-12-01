From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: Re: [PATCH v5 1/5] dt-bindings: define vendor prefix for Wi2Wi, Inc.
Date: Fri, 1 Dec 2017 15:44:02 +0100
Message-ID: <85306aff-ecf0-02bb-601b-519a302f1c04@suse.de>
References: <cover.1512114576.git.hns@goldelico.com>
 <876647948fceb763a0b584b70c3805dec562072e.1512114576.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <876647948fceb763a0b584b70c3805dec562072e.1512114576.git.hns@goldelico.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@baylibre.com>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

Am 01.12.2017 um 08:49 schrieb H. Nikolaus Schaller:
> Introduce vendor prefix for Wi2Wi, Inc. for W2SG00x4 GPS modules
> and W2CBW003 Bluetooth/WiFi combo (CSR/Marvell).

If there's more iterations, maybe you could clarify what the company
does overall (just these 2?) vs. what specifically you add it for here?

> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Other than that,

Reviewed-by: Andreas Färber <afaerber@suse.de>

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
