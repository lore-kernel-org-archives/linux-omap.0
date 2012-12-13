From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: add pwm driver using dmtimers.
Date: Thu, 13 Dec 2012 09:41:11 -0800
Message-ID: <20121213174110.GE4989@atomide.com>
References: <20121212192430.50cea126@notabene.brown>
 <50C8ABFC.3080309@ti.com>
 <20121213140635.4eda5858@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121213140635.4eda5858@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Jon Hunter <jon-hunter@ti.com>, Thierry Reding <thierry.reding@avionic-design.de>, Grant Erickson <marathon96@gmail.com>, linux-omap@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* NeilBrown <neilb@suse.de> [121212 19:09]:
> On Wed, 12 Dec 2012 10:08:28 -0600 Jon Hunter <jon-hunter@ti.com> wrote:
> > On 12/12/2012 02:24 AM, NeilBrown wrote:
> > > +
> > > +	/* Request the OMAP dual-mode timer that will be bound to and
> > > +	 * associated with this generic PWM.
> > > +	 */
> > > +
> > > +	omap->dm_timer = omap_dm_timer_request_specific(timer);
> > 
> > I would recommend that you use omap_dm_timer_request_by_cap() (new for
> > v3.8 so you should be able to use once v3.8-rc1 is out) here to request
> > a timer that supports the PWM output. The above function will not be
> > supported when booting with device-tree.
> 
> I wasn't planning on rushing into working on 3.8-rcX so I'd rather not do
> this now.
> Would you object to the patch being submitted with the current call, then an
> update when I do move on to 3.8?
> 
> However.... I may be misunderstanding something, but I want a timer to drive
> a particular output pin - GPIO-57.  And I thought that it could only be
> driver by GPT11.  So I need to explicitly request number 11 don't I?

Yes I believe it needs to tied to a specific GPT instance to have access
to the pin. We should not export omap_dm_timer_request_specific(), that
information should become from platform_data and device tree.

Regards,

Tony
