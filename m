From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/3] Some omap_device/hwmod/pwrdomain patches
Date: Fri, 27 May 2011 08:31:06 +0300
Message-ID: <1306474266.1905.8.camel@deskari>
References: <1306428307-1360-1-git-send-email-tomi.valkeinen@ti.com>
	<87ipsxfjyd.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87ipsxfjyd.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2011-05-26 at 10:30 -0700, Kevin Hilman wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> 
> > I came up with these patches while implementing pm runtime adaptation for DSS
> > driver. I'm not quite sure on who's turf they belong, or do they even belong
> > together, but here they are anyway.
> >
> > get_context_loss_count patch was discussed on l-o with Kevin.
> >
> > The omap_device_reset patch I made as some parts of DSS currently presume that
> > the HW module is reset when it is enabled, and the reset is better handled in
> > hwmod code.
> >
> > can_ever_lose_context code I didn't strictly need, but as there's such a
> > function I added that to the context save code in DSS while rewriting the code.
> 
> Are any of the DSS blocks in power domains that can't lose context
> (WKUP?)

Probably not. I have to say I don't know when can_ever_lose_context
returns false.

I had some old code in DSS's context save functions which disabled
context saving for OMAP2. I don't remember why that was put there, but
probably either 1) OMAP2's DSS can't ever lose context 2) OMAP2's DSS
couldn't lose context at the time the code was written.

I guess 2) is more likely, but nevertheless when I noticed
can_ever_lose_context I thought it'd be good to have that in the context
save code.

> This isn't something in general that drivers should be aware of, so I'd
> rather not see this exposed to drivers (unless there's a real need.)

Ok, I'll drop the patch. I don't think there's any need for this in DSS.

> As soon as I finish the move to device power domains (hopefully for
> 2.6.41), the driver's callbacks will only be called if the device has
> lost context, so checking for context loss will not be needed at all at
> the driver level.

This sounds good. Runtime PM's suspend & resume callbacks or something
else? 

 Tomi
