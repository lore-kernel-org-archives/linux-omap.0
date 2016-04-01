From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH] ARM: dts: DRA74X: Move common pinctrl definitions to
 common header
Date: Fri, 1 Apr 2016 08:17:30 -0500
Message-ID: <56FE74EA.3000703@ti.com>
References: <1459514690.11664.1.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459514690.11664.1.camel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 04/01/2016 07:44 AM, Ben Hutchings wrote:
> The I2C{1,2}, MCSPI{1,2}, UART{1,2}, QSPI1, USB{1,2}, RGMII
> and ATL functions can each be wired in only one way.  Reduce
> duplication by defining that in dra74x.dtsi.

> 
> Signed-off-by: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts |  50 +---------
>  arch/arm/boot/dts/dra7-evm.dts          | 142 +-------------------------
>  arch/arm/boot/dts/dra74x.dtsi           | 171 ++++++++++++++++++++++++++++++++
>  3 files changed, 174 insertions(+), 189 deletions(-)


NAK. Couple of reasons:

A) Based on AM57xx/DRA7 SoC definitions these pin configuration should
actually be deleted since the pinmuxing is only supposed to be done in
u-boot (thanks to IODelay and other glitch constraints documented in TRM).
B) newer packaging plans do take place that will make reuse of
dra74x.dtsi harder by consolidating the pinmux in a central location.


-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
