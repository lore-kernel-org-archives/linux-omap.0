From: "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Sat, 25 Sep 2010 11:22:57 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030C8FBC14@dbde02.ent.ti.com>
References: <1285325785-6163-1-git-send-email-vishwanath.bs@ti.com>
	<1285325785-6163-2-git-send-email-vishwanath.bs@ti.com>
	<20100924190125.GG4211@atomide.com> <20100924190930.GH4211@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20100924190930.GH4211-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Sripathy, Vishwanath" <vishwanath.bs-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: linux-omap-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-omap-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Tony Lindgren
> Sent: Saturday, September 25, 2010 12:40 AM
> To: Sripathy, Vishwanath
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org; Kevin Hillman
> Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
> 
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [100924 11:53]:
> > * Vishwanath BS <vishwanath.bs-l0cyMroinI0@public.gmane.org> [100924 03:50]:
> > > There is no need to keep omap3 sleep code in SRAM. This code can be
> run very
> > > well on DDR. This would help us to instrument CPUIdle latencies.
> >
> > Uhh, are you sure about this? To me it sounds like you're then
> > relying on the code running from the cache for off-idle?
> 
> Actually the caches are off too for off-idle..
> 
The low power code can be executed from DDR and need not be from
cache. The only real implementation on OMAP3 is around DVFS code,
where you need to put DDR to self refresh and execute some
piece of code. That still needs to be executed from some other
memory like (SRAM).

Regards,
Santosh
