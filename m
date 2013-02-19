From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH, RFC 2/8] ARM: twd: register clock event for 1 core SMP
Date: Tue, 19 Feb 2013 15:44:14 +0530
Message-ID: <51235076.8040200@ti.com>
References: <cover.1361186097.git.afzal@ti.com> <a7f62b8580aa4b33d5658f4f03371a453adaea9b.1361186097.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <a7f62b8580aa4b33d5658f4f03371a453adaea9b.1361186097.git.afzal@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Marc Zyngier <marc.zyngier@arm.com>, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Sekhar Nori <nsekhar@ti.com>, Syed Mohammed Khasim <khasim@ti.com>
List-Id: linux-omap@vger.kernel.org

On Monday 18 February 2013 05:07 PM, Afzal Mohammed wrote:
> Register percpu local timer for scheduler tick in the case of one core
> SMP configuration. In other cases - secondary cpu's as well as boot
> cpu's having more than one core, this is being registered as per
> existing boot flow, with a difference that they happens after delay
> calibration. Registering the clock for tick in case of one core should
> be done before Kernel calibrates delay (this is required to boot,
> unless local timer is the only one registered for tick). Registering
> twd local timer at init_time (which platforms are doing now) helps
> achieve that with the proposed change.
>
> This helps in an almost booting Kernel (minimal) by only relying on
> ARM parts for an A9 one core SMP.
>
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
As mentioned in cover-letter, I don't think we have good
reasoning to make TWD to work with UP configuration. Even
you fix the timer code, there are more cascaded dependencies
which is not worth the effort.

Regards,
Samtosh

