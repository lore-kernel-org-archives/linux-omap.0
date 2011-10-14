From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/5 v14] omap: usb: host: Replace usbhs core driver APIs
 by Runtime pm APIs
Date: Thu, 13 Oct 2011 18:12:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110131812010.24155@utopia.booyaka.com>
References: <1318319531-20476-1-git-send-email-keshava_mgowda@ti.com> <20111013175921.GN28290@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111013175921.GN28290@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

Hi Felipe,

On Thu, 13 Oct 2011, Felipe Balbi wrote:

> On Tue, Oct 11, 2011 at 01:22:11PM +0530, Keshava Munegowda wrote:
> > From: Keshava Munegowda <Keshava_mgowda@ti.com>
> > 
> > The ehci and ohci drivers does not use the APIs of the usbhs
> > core driver; the runtime pm APIs are used for clock
> > enable/disable. Since usbhs is parent platform device of the
> > ehci and ohci devices, the runtime apis indirectly uses the
> > usb hs core device as input parameter to for clock functions.
> > 
> > Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> > Reviewed-by: Kevin Hilman <khilman@ti.com>
> > Reviewed-by: Partha Basak <parthab@india.ti.com>
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

Thanks, added your ack to the MFD patch and patch 5.

- Paul
