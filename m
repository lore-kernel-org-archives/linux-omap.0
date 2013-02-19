From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH, RFC 1/8] ARM: localtimer: return percpu clkevt on register
Date: Tue, 19 Feb 2013 15:52:02 +0530
Message-ID: <5123524A.9080300@ti.com>
References: <cover.1361186097.git.afzal@ti.com> <e7cbb10903841ba23a93f71e7a06ae34a43adc70.1361186097.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <e7cbb10903841ba23a93f71e7a06ae34a43adc70.1361186097.git.afzal@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Marc Zyngier <marc.zyngier@arm.com>, Nicolas Pitre <nico@linaro.org>, Will Deacon <will.deacon@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Sekhar Nori <nsekhar@ti.com>, Syed Mohammed Khasim <khasim@ti.com>
List-Id: linux-omap@vger.kernel.org

On Monday 18 February 2013 05:06 PM, Afzal Mohammed wrote:
> Return percpu clock event on local timer register. It is the boot cpu
> that calls this and it can use the returned percpu clock event to
> register a clock event in the case of SMP configuration with one core.
SMP configuration with 1 core is UP :-)
Jokes apart as said already, lets see whether we really need it.

Regards,
Santosh
