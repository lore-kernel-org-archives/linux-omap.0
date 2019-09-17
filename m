From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 5/8] cpufreq: ti-cpufreq: omap36xx use "cpu0","vbb" if
 run in multi_regulator mode
Date: Tue, 17 Sep 2019 14:22:47 -0500
Message-ID: <20190917192247.GA7233@bogus>
References: <cover.1568224032.git.hns@goldelico.com>
 <1c803be8060fb99b7d92e2f5cde3c0e1962fbe2b.1568224033.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1c803be8060fb99b7d92e2f5cde3c0e1962fbe2b.1568224033.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Adam Ford <aford173@gmail.com>, =?iso-8859-1?Q?Andr=E9?= Roth <neolynx@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Enric Balletbo i Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>, Teresa Remmet <t.remmet@phytec.de>, "H. Nikolaus Schaller" <hns@goldelico.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, 11 Sep 2019 19:47:11 +0200, "H. Nikolaus Schaller" wrote:
> In preparation for using the multi_regulator capability of
> this driver for handling the ABB LDO for OPP1G of the omap36xx
> we have to take care that the (legacy) vdd-supply name is
> cpu0-supply = <&vcc>;
> 
> To do this we add another field to the SoC description table which
> optionally can specify a list of regulator names.
> 
> For omap36xx we define "cpu0-supply" and "vbb-supply".
> 
> The default remains "vdd-supply" and "vbb-supply".
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../devicetree/bindings/cpufreq/ti-cpufreq.txt       |  6 +++++-
>  drivers/cpufreq/ti-cpufreq.c                         | 12 ++++++++++--
>  2 files changed, 15 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
