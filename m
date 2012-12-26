From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCH 09/10] ARM: OMAP2+: clockdomain: convert existing atomic
 usecounts into spinlock-protected shorts/ints
Date: Wed, 26 Dec 2012 06:31:13 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECA6D3D@DBDE01.ent.ti.com>
References: <20121209011755.19716.25244.stgit@dusk.lan>
 <20121209012342.19716.66436.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46449 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab2LZGbU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Dec 2012 01:31:20 -0500
In-Reply-To: <20121209012342.19716.66436.stgit@dusk.lan>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Hi Paul,

On Sun, Dec 09, 2012 at 06:53:43, Paul Walmsley wrote:
> The atomic usecounts seem to be confusing, and are no longer needed
> since the operations that they are attached to really should take
> place under lock.  Replace the atomic counters with simple integers,
> protected by the enclosing powerdomain spinlock.
[...]
>  
> @@ -1063,7 +1123,8 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
>  	 * should be called for every clock instance or hwmod that is
>  	 * enabled, so the clkdm can be force woken up.
>  	 */
> -	if ((atomic_inc_return(&clkdm->usecount) > 1) && autodeps) {
> +	clkdm->usecount++;
> +	if (clkdm->usecount > 1 && autodeps) {
>  		pwrdm_unlock(clkdm->pwrdm.ptr);
>  		return 0;
>  	}

This is not directly related to this patch but something I noticed when I enabled
the various debug prints.

if the clkdm->usecount is > 1, there is still a call to arch_clkdm->clkdm_clk_enable().
Won't the usecount >1 guarantee that the clkdm is in the right state and the PRCM
access can be skipped?

Regards,
Vaibhav
