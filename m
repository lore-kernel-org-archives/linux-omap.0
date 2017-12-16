From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: opp: Introduce ti-opp-supply bindings
Date: Sat, 16 Dec 2017 12:01:53 -0600
Message-ID: <20171216180136.sn4fmf26vcbb56u6@rob-hp-laptop>
References: <20171215042528.28715-1-d-gerlach@ti.com>
 <20171215042528.28715-4-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171215042528.28715-4-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 14, 2017 at 10:25:27PM -0600, Dave Gerlach wrote:
> Document the devicetree bindings that describe Texas Instruments
> opp-supply which allow a platform to describe multiple regulators and
> additional information, such as registers containing data needed to
> program aforementioned regulators.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  .../bindings/opp/ti-omap5-opp-supply.txt           | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/opp/ti-omap5-opp-supply.txt

Acked-by: Rob Herring <robh@kernel.org>
