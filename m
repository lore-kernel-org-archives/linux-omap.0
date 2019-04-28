From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 4/4] net: davinci_emac: Drop nvmem_get_mac_address
 usage
Date: Sun, 28 Apr 2019 18:58:15 +0200
Message-ID: <20190428165815.GK23059@lunn.ch>
References: <1556456002-13430-1-git-send-email-ynezz@true.cz>
 <1556456002-13430-5-git-send-email-ynezz@true.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556456002-13430-5-git-send-email-ynezz@true.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Alban Bedel <albeu@free.fr>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sun, Apr 28, 2019 at 02:53:22PM +0200, Petr Štetiar wrote:
> of_get_mac_address now uses NVMEM under the hood, so it's not necessary
> to call it manually anymore.
> 
> Signed-off-by: Petr Štetiar <ynezz@true.cz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
