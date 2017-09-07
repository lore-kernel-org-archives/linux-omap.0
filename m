From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2] usb: musb: musb_cppi41: Fix the address of teardown
 and autoreq registers
Date: Thu, 7 Sep 2017 12:16:02 -0500
Message-ID: <20170907171602.GB21905@LTA0271908.dhcp.ti.com>
References: <20170813120423.16371-1-abailon@baylibre.com>
 <20170813120423.16371-2-abailon@baylibre.com>
 <7ee74cb1-19aa-5323-5325-ef9cc3410762@ti.com>
 <abce1d79-bc75-2018-2112-d701a8ca69d5@ti.com>
 <868405c0-0731-7546-509c-8270eb20f30e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <868405c0-0731-7546-509c-8270eb20f30e-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 04, 2017 at 06:32:11PM +0530, Sekhar Nori wrote:
> On Monday 14 August 2017 07:06 PM, Sekhar Nori wrote:
> > On Monday 14 August 2017 07:01 PM, Sekhar Nori wrote:
> >> Hi,
> >>
> >> On Sunday 13 August 2017 05:34 PM, Alexandre Bailon wrote:
> >>> The DA8xx and DSPS platforms don't use the same address for few registers.
> >>> On Da8xx, this is causing some issues (e.g. teardown that doesn't work).
> >>> Configure the address of the register during the init and use them instead
> >>> of constants.
> >>>
> >>> Reported-by: nsekhar-l0cyMroinI0@public.gmane.org
> > 
> > Reported-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> 
> Tested-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> 
> Hi Bin,
> 
> Do you have any additional comments on this series or are you waiting
> for v2 to be posted?

I don't have other comments, just am waiting for v2.

Regards,
-Bin.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
