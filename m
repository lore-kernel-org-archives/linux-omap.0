From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 00/11] Continuing the work on coupled regulators
Date: Mon, 8 Oct 2018 10:58:35 -0700
Message-ID: <20181008175835.GJ5662@atomide.com>
References: <20181005153638.1886-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Maciej Purski <m.purski@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Dmitry Osipenko <digetx@gmail.com> [181005 15:43]:
> 1. Re-worked the original "Add voltage balancing mechanism" patch from
>    Maciej by:
>         1) Fixing infinite loop within regulator_balance_voltage().
>         2) Handling suspend_state_t properly.
>         3) Fixing broken compilation of the patch.

Thanks for fixing these, this series no longer hangs for me
on beagle-x15.

Regards,

Tony
