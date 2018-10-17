From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 07/11] dt-bindings: regulator: Document new
 regulator-max-step-microvolt property
Date: Wed, 17 Oct 2018 08:33:24 -0500
Message-ID: <20181017133324.GA5459@bogus>
References: <20181005153638.1886-1-digetx@gmail.com>
 <20181005153638.1886-8-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005153638.1886-8-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Maciej Purski <m.purski@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri,  5 Oct 2018 18:36:34 +0300, Dmitry Osipenko wrote:
> Certain hardware may require supply voltage to be changed in steps. Define
> new property that allow to describe such hardware.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/regulator/regulator.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
