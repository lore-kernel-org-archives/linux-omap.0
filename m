From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] dt-bindings: power: Introduce suspend states supported
 properties
Date: Wed, 12 Sep 2018 06:32:28 -0700
Message-ID: <20180912133228.GI5662@atomide.com>
References: <1536725372-29174-1-git-send-email-j-keerthy@ti.com>
 <781b2eb2-1568-b4e5-46f2-c4612862d728@arm.com>
 <5c49cb0c-a436-c957-e6b3-5f3aa7af92f9@ti.com>
 <2c08c85f-a3e0-c1ce-3f87-0866868bd7e4@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2c08c85f-a3e0-c1ce-3f87-0866868bd7e4@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Keerthy <j-keerthy@ti.com>, mark.rutland@arm.com, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

* Sudeep Holla <sudeep.holla@arm.com> [180912 11:41]:
> On 12/09/18 12:19, Keerthy wrote:
> > suspend to mem and suspend to disk are pretty generic states and i agree
> > implementation is platform dependent so why not have properties that
> > convey if they are supported?
> > 
> 
> We already have power domains and idle states for that. If you need to
> restrict few states on some platform for whatever reasons, just disable
> those states. I don't see the need to add any more bindings for the same.

Oh do you mean the "domain-idle-states" property as mentioned in the
Documentation/devicetree/bindings/power/power_domain.txt?

Yeah that should do and the DOMAIN_PWR_DN and DOMAIN_RET can be SoC
specific and then the board can select which ones to use depending on
how things are wired for GPIOs, memory, PMIC and so on.

Hmm I don't see any users for this binding though?

Regards,

Tony
