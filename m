From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: Re: [RFC/PATCH v2 08/13] dt: omap: i2c: add dt support for i2c1
 controller
Date: Fri, 2 Sep 2011 08:52:12 +0530
Message-ID: <20110902032212.GC6465@manju-desktop>
References: <1314074021-25186-1-git-send-email-manjugk@ti.com>
 <1314074021-25186-9-git-send-email-manjugk@ti.com>
 <20110823154649.GF32698@manju-desktop>
 <4E5FC213.3080407@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:43763 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758091Ab1IBDWX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 23:22:23 -0400
Received: by mail-pz0-f46.google.com with SMTP id 32so4226362pzk.5
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 20:22:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E5FC213.3080407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, grant.likely@secretlab.ca
Cc: "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Benoit,

On Thu, Sep 01, 2011 at 07:34:11PM +0200, Cousson, Benoit wrote:
> Hi Manju,
> 
> On 8/23/2011 5:46 PM, G, Manjunath Kondaiah wrote:
> >Hi Grant,
> 
> [...]
> 
> >This function calls of_i2c_register_devices which attaches all the required
> >parameters reg, irq, archdata etc into i2c adapter. But it will not attach
> >platform_data which results empty pdata pointer in i2c child devices.
> >
> >Is this done purposefully?
> 
> I think so, but anyway, we'd rather spend some time on doing a
> proper DT implementation than hacking more the AUXDATA temporary
> solution.
> 
> I've just sent a reworked version of that series with a pure
> dt-no-auxdata-hack approach.

Thanks for initiating aux data cleanup series. Let us syncup on further changes
and follow up so that we can have this feature with v3.2 merge window.

Grant, Can you have a look and provide feedback on all the patches which are
done for omap dt work.

-M

