From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V5 2/7] ARM: TI: Use - instead of @ for DT OPP entries
Date: Tue, 16 May 2017 08:19:14 -0700
Message-ID: <20170516151913.GE31418@atomide.com>
References: <cover.1492685450.git.viresh.kumar@linaro.org>
 <5f0656140309d53a45058c048ca059c4ba294756.1492685450.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5f0656140309d53a45058c048ca059c4ba294756.1492685450.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: arm@kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Viresh Kumar <viresh.kumar@linaro.org> [170420 03:58]:
> Compiling the DT file with W=1, DTC warns like follows:
> 
> Warning (unit_address_vs_reg): Node /opp_table0/opp@1000000000 has a
> unit name, but no reg property
> 
> Fix this by replacing '@' with '-' as the OPP nodes will never have a
> "reg" property.

Applying into omap-for-v4.13/dt thanks.

Tony
