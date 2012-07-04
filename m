From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCHv2 02/12] ARM: OMAP2+: hwmod code/data: fix 32K sync timer
Date: Wed, 4 Jul 2012 18:57:10 +0200
Message-ID: <4FF475E6.3060308@ti.com>
References: <20120611004502.20034.8840.stgit@dusk> <20120611004555.20034.87035.stgit@dusk> <4FDA15AA.6090704@ti.com> <alpine.DEB.2.00.1206141136080.30212@utopia.booyaka.com> <4FDA45F5.9090300@ti.com> <alpine.DEB.2.00.1206141706420.25628@utopia.booyaka.com> <4FDB387C.7030003@ti.com> <alpine.DEB.2.00.1207040625090.6760@utopia.booyaka.com> <alpine.DEB.2.00.1207040652240.6760@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49753 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab2GDQ5S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 12:57:18 -0400
In-Reply-To: <alpine.DEB.2.00.1207040652240.6760@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Hi Paul,

On 07/04/2012 02:53 PM, Paul Walmsley wrote:
> On Wed, 4 Jul 2012, Paul Walmsley wrote:
> 
>> So the updated patch below uses a clockdomain data flag for this 
>> instead.
> 
> Here's a version that's a little cleaner.  No functional changes.

[...]

> @@ -1141,8 +1144,16 @@ static void _enable_sysc(struct omap_hwmod *oh)
>  	sf = oh->class->sysc->sysc_flags;
>  
>  	if (sf & SYSC_HAS_SIDLEMODE) {
> -		idlemode = (oh->flags & HWMOD_SWSUP_SIDLE) ?
> -			HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
> +		clkdm_act = ((oh->clkdm &&
> +			      oh->clkdm->flags & CLKDM_ACTIVE_WITH_MPU) ||
> +			     (oh->_clk->clkdm &&

This is crashing on OMAP4 due to a NULL oh->_clk that can happen on some
hwmod.

+			     (oh->_clk && oh->_clk->clkdm &&

Is fixing the issue.


Regards,
Benoit


> +			      oh->_clk->clkdm->flags & CLKDM_ACTIVE_WITH_MPU));
> +		if (clkdm_act && !(oh->class->sysc->idlemodes &
> +				   (SIDLE_SMART | SIDLE_SMART_WKUP)))
> +			idlemode = HWMOD_IDLEMODE_FORCE;
> +		else
> +			idlemode = (oh->flags & HWMOD_SWSUP_SIDLE) ?
> +				HWMOD_IDLEMODE_NO : HWMOD_IDLEMODE_SMART;
>  		_set_slave_idlemode(oh, idlemode, &v);
>  	}
>  
