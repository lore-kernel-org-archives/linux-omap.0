From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4+: move errata initialization to
 omap4_pm_init_early
Date: Thu, 23 Jan 2014 10:49:52 -0800
Message-ID: <20140123184951.GJ7993@atomide.com>
References: <CAGa+x863_MQ22h+U=KtK++3aG2F_X4x57Xtfe16GYXKNiaWX4A@mail.gmail.com>
 <1390248397-14112-1-git-send-email-nm@ti.com>
 <52E139C5.3090207@ti.com>
 <874n4uy483.fsf@paris.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39723 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932343AbaAWSt6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jan 2014 13:49:58 -0500
Content-Disposition: inline
In-Reply-To: <874n4uy483.fsf@paris.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Taras Kondratiuk <taras.kondratiuk@linaro.org>

* Kevin Hilman <khilman@linaro.org> [140123 09:55]:
> Grygorii Strashko <grygorii.strashko@ti.com> writes:
> 
> > On 01/20/2014 10:06 PM, Nishanth Menon wrote:
> >> Move all OMAP4 PM errata initializations to centralized location in
> >> omap4_pm_init_early. This allows for users to utilize the erratas
> >> in various submodules as needed.
> >> 
> > Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >
> > This patch fixes build failure caused by patch 
> > https://patchwork.kernel.org/patch/3084521/ 
> > in case if SMP is not enabled.
> 
> So does that mean that that patch can now be applied as is?
> 
> We could sure use that fix (or equivalent) for CPUidle breakage on 4460.

Yeah, seems OK to me, feel free to apply it directly:

Acked-by: Tony Lindgren <tony@atomide.com>
