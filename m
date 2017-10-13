From: Tony Lindgren <tony@atomide.com>
Subject: Re: [Patch 3/6] ARM: OMAP: DRA7xx: Make CAM clock domain SWSUP only
Date: Fri, 13 Oct 2017 10:01:13 -0700
Message-ID: <20171013170113.GL4394@atomide.com>
References: <20171012192719.15193-1-bparrot@ti.com>
 <20171012192719.15193-4-bparrot@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171012192719.15193-4-bparrot@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benoit Parrot <bparrot@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Benoit Parrot <bparrot@ti.com> [171012 12:29]:
> HWSUP on this domain is only working when VIP1 probes.
> If only VIP2 on DRA74x or CAL on DRA72x probes the domain does
> not get enabled. This might indicates an issue in the HW Auto
> state-machine for this domain.
>
> Work around is to set the CAM domain to use SWSUP only.

Hmm this you might get fixed automatically by configuring the
parent interconnect target module to use "ti,sysc-omap4" and
adding VIP1 and VIP2 as children to it.

The reason why I suspect it will fix the issue is because
with the parent being "ti,sysc-omap4" with "ti,hwmods" being
in that parent node too, you automatically get PM runtime
refcounting keep the parent active for either child.

Maybe give it a try against today's Linux next and see for
example how it was done for musb:

https://patchwork.kernel.org/patch/9978783/

Just use "ti,sysc-omap2" for type1 and "ti,sysc-omap4"
for type2.

Regards,

Tony
