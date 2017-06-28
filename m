From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/3] ARM: dts: omap: workarounds for Ethernet PHY strap on
 DRA71 and DRA72 EVMs
Date: Wed, 28 Jun 2017 10:39:08 +0530
Message-ID: <80147da4-a405-cdc2-7d2c-95c16dfb08e6@ti.com>
References: <cover.1498573382.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1498573382.git.nsekhar-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Tuesday 27 June 2017 08:36 PM, Sekhar Nori wrote:
> Hi Tony,
> 
> Here are some patches to overcome incorrect Ethernet PHY strap settings
> on DRA72x EVM Rev C and DRA71 EVM. Both of these boards use TI's DP83867
> PHY.
> 
> The incorrect PHY strap settings cause a voilation of PHY specification
> and need to be worked around in software as documented in the commit
> messages. But there is no known issue that these patches fix.
> 
> I did verify that there are no regressions with NFS boot on these boards
> after the patches are applied on v4.12-rc4.

Please ignore this series. It is prematurely posted. The DT property I
use is not upstream yet. I relied on some recollection of it being
upstream. I should have grepped instead. Since there was no regression
and no change in behavior could also be explained, I did not catch it in
my testing. Thanks Grygorii for pointing out.

Regards,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
