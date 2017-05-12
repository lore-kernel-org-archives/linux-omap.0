From: Bin Liu <b-liu@ti.com>
Subject: Re: [PATCH v2 05/10] usb: musb: tusb6010_omap: Do not reset the
 other direction's packet size
Date: Fri, 12 May 2017 07:07:52 -0500
Message-ID: <20170512120752.GJ7154@uda0271908>
References: <20170510084231.19302-1-peter.ujfalusi@ti.com>
 <20170510084231.19302-6-peter.ujfalusi@ti.com>
 <20170510170754.GA7154@uda0271908>
 <1494458188.2028.5.camel@perches.com>
 <2d693d53-ba32-1549-90bd-da92f061cbed@ti.com>
 <20170511141235.GD7154@uda0271908>
 <625d78c1-88bf-08ee-e13d-19cbc57fa78a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <625d78c1-88bf-08ee-e13d-19cbc57fa78a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Joe Perches <joe@perches.com>, tony@atomide.com, gregkh@linuxfoundation.org, vinod.koul@intel.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 12, 2017 at 09:53:55AM +0300, Peter Ujfalusi wrote:
> Bin,
> 
> On 2017-05-11 17:12, Bin Liu wrote:
> >>which is valid.
> >
> >So will you update the patch to move the declaration to the beginning of
> >the function to avoid this WARNING. I would just fix it locally if you
> >prefer.
> 
> I was waiting for Vinod or someone from the DMAengine guys to say
> something for the first patch to send the v3, but I guess I can do
> it right away.

Yeah, this patch can go to the -rc in next week, but the rest will go to
-next, so you can send this patch seperately.

Regards,
-Bin.
