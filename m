From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: RE: [PATCH] omap: 4430sdp board support for the the GPIO keys
Date: Wed, 1 Sep 2010 11:49:08 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003C1CA4D7B@dbde02.ent.ti.com>
References: <1283269578-3962-1-git-send-email-shubhrajyoti@ti.com>
 <87vd6qsrd0.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44961 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269Ab0IAGTP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Sep 2010 02:19:15 -0400
In-Reply-To: <87vd6qsrd0.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, August 31, 2010 9:32 PM
> To: Datta, Shubhrajyoti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap: 4430sdp board support for the the GPIO keys
> 
> Shubhrajyoti D <shubhrajyoti@ti.com> writes:
> 
> > omap 4430sdp board support for the GPIO keys.
> > The proximity sensor is connected to GPIO and is registered as a
> > GPIO key.
> > - Making the default state of the sensor off at bootup
> > - The init is called before platform_add_devices
> >
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> 
> I still think the subject is wrong:  You're adding support for the
> proximity sensor *using* GPIO keys, not adding support for GPIO keys:
> 
>     OMAP: 4430SDP: add proximity sensor via GPIO keys
> 
> or something like that.
Yes agree just sent a patch attempting to correct it.
Thanks,
> 
> Kevin

