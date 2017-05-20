From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/2] ARM: dts: am335x-sl50: Fix card detect pin for mmc1
Date: Sat, 20 May 2017 10:45:23 +0200
Message-ID: <20170520084523.GA4284@kroah.com>
References: <20170519165144.11508-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170519165144.11508-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Tony Lindgren <tony@atomide.com>, stable@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 19, 2017 at 06:51:43PM +0200, Enric Balletbo i Serra wrote:
> The second version of the hardware moved the card detect pin from gpio0_6
> to gpio1_9, as we won't support the first hardware version fix the pinmux
> configuration of this pin.
> 
> Fixes: 8584d4fc ("ARM: dts: am335x-sl50: Add Toby-Churchill SL50 board support.")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  arch/arm/boot/dts/am335x-sl50.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
