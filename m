From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] arm: Fix build error with context tracking calls
Date: Fri, 27 Sep 2013 15:30:05 +0200
Message-ID: <20130927133003.GA7927@localhost.localdomain>
References: <alpine.LFD.2.03.1309091023440.20709@syhkavp.arg>
 <20130909160348.GB18975@roeck-us.net>
 <20130909203141.GM25647@n2100.arm.linux.org.uk>
 <20130909210203.GC28416@roeck-us.net>
 <alpine.LFD.2.03.1309091714420.20709@syhkavp.arg>
 <87y574g1fi.fsf@linaro.org> <20130913170331.GA8453@somewhere>
 <20130914143213.GN25647@n2100.arm.linux.org.uk>
 <CAFTL4hzccoaUinQ37bpbqXDv-bbNkuww8FURQMwD_zEb9RqSMA@mail.gmail.com>
 <874n986bt9.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <874n986bt9.fsf@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Guenter Roeck <linux@roeck-us.net>, Anil Kumar <anilk4.v@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 25, 2013 at 10:38:58AM -0700, Kevin Hilman wrote:
> Frederic Weisbecker <fweisbec@gmail.com> writes:
> 
> > 2013/9/14, Russell King - ARM Linux <linux@arm.linux.org.uk>:
> >> On Fri, Sep 13, 2013 at 07:03:34PM +0200, Frederic Weisbecker wrote:
> >>> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> >>> index 247091b..859c8df 100644
> >>> --- a/kernel/context_tracking.c
> >>> +++ b/kernel/context_tracking.c
> >>> @@ -51,6 +51,15 @@ void context_tracking_user_enter(void)
> >>>  	unsigned long flags;
> >>>
> >>>  	/*
> >>> +	 * Repeat the user_enter() check here because some archs may be calling
> >>> +	 * this from asm and if no CPU needs context tracking, they shouldn't
> >>> +	 * go further. We can remove that check here once these archs support
> >>> the static key
> >>> +	 * check.
> >>
> >> The only (minor) comment on this is that the above would fail checkpatch,
> >> but that's not a good enough reason to respin it if you've already applied
> >> it IMHO.
> >>
> >
> > Ah I haven't yet pushed that patch anywhere so I can definetly fix
> > that. Thanks for the review. BTW, I initially first thought this fix
> > could go through your tree but if you prefer I can push it through
> > Ingo to the context tracking bits.
> >
> > Just tell me either way.
> 
> Frederic, I suggest you queue it directly for v3.12-rc.  Thanks,

Ok, I'm doing that then, thanks you!
