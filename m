From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Rearm wake-up interrupts for DT when
 MUSB is idled
Date: Wed, 27 Aug 2014 16:38:31 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1408271632550.21249@utopia.booyaka.com>
References: <20140825171446.GL17254@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46221 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932275AbaH0Qid (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Aug 2014 12:38:33 -0400
In-Reply-To: <20140825171446.GL17254@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 25 Aug 2014, Tony Lindgren wrote:

> Looks like MUSB cable removal can cause wake-up interrupts to
> stop working for device tree based booting at least for UART3
> even as nothing is dynamically remuxed. This can be fixed by
> calling reconfigure_io_chain() for device tree based booting
> in hwmod code. 

Weird, nice find.  Do you know if this applies to all OMAPs, or just 
OMAP3?

> Note that we already do that for legacy booting
> if the legacy mux is configured.
> 
> My guess is that this is related to UART3 and MUSB ULPI
> hsusb0_data0 and hsusb0_data1 support for Carkit mode that
> somehow affect the configured IO chain for UART3 and require
> rearming the wake-up interrupts.
> 
> In general, for device tree based booting, pinctrl-single
> calls the rearm hook that in turn calls reconfigure_io_chain
> so calling reconfigure_io_chain should not be needed from the
> hwmod code for other events.
> 
> So let's limit the hwmod rearming of iochain only to
> HWMOD_FORCE_MSTANDBY where MUSB is currently the only user
> of it. If we see other devices needing similar changes we can
> add more checks for it.

Could you please add a new hwmod flag for this case?  Maybe something like 
HWMOD_RECONFIG_IO_CHAIN?  I think that would make the code easier to read 
and more maintainable, since the workaround would then be explicitly 
connected with that particular workaround's flag.  Looks like we have 
several flag bits left.  Plus if we wind up having to set 
HWMOD_FORCE_MSTANDBY for other devices that might not need the I/O chain 
reconfiguration, we won't have to reimplement this flag workaround.


regards


- Paul


> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -2185,6 +2185,8 @@ static int _enable(struct omap_hwmod *oh)
>  			 oh->mux->pads_dynamic))) {
>  		omap_hwmod_mux(oh->mux, _HWMOD_STATE_ENABLED);
>  		_reconfigure_io_chain();
> +	} else if (oh->flags & HWMOD_FORCE_MSTANDBY) {
> +		_reconfigure_io_chain();
>  	}
>  
>  	_add_initiator_dep(oh, mpu_oh);
> @@ -2291,6 +2293,8 @@ static int _idle(struct omap_hwmod *oh)
>  	if (oh->mux && oh->mux->pads_dynamic) {
>  		omap_hwmod_mux(oh->mux, _HWMOD_STATE_IDLE);
>  		_reconfigure_io_chain();
> +	} else if (oh->flags & HWMOD_FORCE_MSTANDBY) {
> +		_reconfigure_io_chain();
>  	}
>  
>  	oh->_state = _HWMOD_STATE_IDLE;
> 


- Paul
