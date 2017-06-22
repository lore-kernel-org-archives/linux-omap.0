From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] regulator: tps65910: wire up sleep control
 configuration
Date: Thu, 22 Jun 2017 16:29:12 -0500
Message-ID: <20170622212911.ciuihaishtryuwgb@rob-hp-laptop>
References: <48ab466a6832807a585012209f94855ff67ddc95.1497466956.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <48ab466a6832807a585012209f94855ff67ddc95.1497466956.git.mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 14, 2017 at 09:04:14PM +0200, Michał Mirosław wrote:
> This enables configuring the PMIC's sleep mode via device-tree.
> 
> A pointer indirection to sleep mode data is removed, as it simplifies
> the implementation slightly. In current kernel tree, platform data
> structure is not used outside MFD cell drivers.
> 
> Signed-off-by: Michał Mirosław <mirq-linux-CoA6ZxLDdyEEUmgCuDUIdw@public.gmane.org>
> ---
> v2:
>   - updated commit message
> 
>  Documentation/devicetree/bindings/mfd/tps65910.txt |  4 ++++
>  drivers/mfd/tps65910.c                             | 22 +++++++++++++++-------
>  include/linux/mfd/tps65910.h                       |  2 +-
>  3 files changed, 20 insertions(+), 8 deletions(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
