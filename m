From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 05/11] dt-bindings: regulator: Change
 regulator-coupled-max-spread property
Date: Wed, 17 Oct 2018 08:27:03 -0500
Message-ID: <20181017132703.GA26895@bogus>
References: <20181005153638.1886-1-digetx@gmail.com>
 <20181005153638.1886-6-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005153638.1886-6-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Maciej Purski <m.purski@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri,  5 Oct 2018 18:36:32 +0300, Dmitry Osipenko wrote:
> Redefine binding for regulator-coupled-max-spread property in a way that
> max-spread values are defined per regulator couple instead of defining
> single max-spread for the whole group of coupled regulators.
> 
> With that change the following regulators coupling configuration will be
> possible:
> 
> regA: regulatorA {
> 	regulator-coupled-with = <&regB &regC>;
> 	regulator-coupled-max-spread = <100000 300000>;
> };
> 
> regB: regulatorB {
> 	regulator-coupled-with = <&regA &regC>;
> 	regulator-coupled-max-spread = <100000 200000>;
> };
> 
> regC: regulatorC {
> 	regulator-coupled-with = <&regA &regB>;
> 	regulator-coupled-max-spread = <300000 200000>;
> };
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
