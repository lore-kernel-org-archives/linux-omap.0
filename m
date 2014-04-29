From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH V3 00/20] bus: omap_l3_noc: driver cleanups and support
 for DRA7/AM4372
Date: Tue, 29 Apr 2014 19:12:14 +0530
Message-ID: <535FAC36.10408@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com> <1398698101-25513-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398698101-25513-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 28 April 2014 08:44 PM, Nishanth Menon wrote:
> V3: has the following changes (w.r.t v2):
> 	- fixed relaxed commit message and usage.
> 	- AM437x internal documents showed that:
> 		- new master information updated into the data
> 		- masterid register definition is different from OMAP4-DRA7 - some
> 		  additional parsing is done in hardware to "avoid s/w parsing"
> 	- Additional testing information showed logic fail for masking "unclearable"
> 		new patch added to series - patch #15
> 	- Picked up previous acks and tested by - minor changes verified

Tested the series on AM437x ePOS EVM and works great.

Tested-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
