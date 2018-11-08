From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 10/11] regulator: core: Use ww_mutex for regulators
 locking
Date: Thu, 8 Nov 2018 19:53:47 +0300
Message-ID: <31841457-32c5-f28e-707e-a2eca012acc5@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
 <20181005153638.1886-11-digetx@gmail.com>
 <20181108130714.GE6675@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108130714.GE6675@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Maciej Purski <m.purski@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 08.11.2018 16:07, Mark Brown wrote:
> On Fri, Oct 05, 2018 at 06:36:37PM +0300, Dmitry Osipenko wrote:
> 
>> Wait/wound mutex shall be used in order to avoid lockups on locking of
>> coupled regulators.
> 
> This breaks the build due to a few of the drivers (wm8350 and da9210 at
> least) taking rdev locks in their interrupt handlers.  I'd suggest
> adding a function for those drivers to use - exposing the ww context
> seems like the wrong thing to do there.

I totally missed those drivers, will fix them in v2.

> Otherwise the series looks good, I've applied everything up to here.
> Thanks for taking the time to pick this up, and especially for figuring
> out the ww_mutex conversion.
> 

Thank you.
