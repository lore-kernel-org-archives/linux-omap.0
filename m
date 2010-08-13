From: "Que, Simon" <sque@ti.com>
Subject: RE: [PATCH 3/4 v2] omap: hwspinlock: Created driver for OMAP
 hardware spinlock.
Date: Fri, 13 Aug 2010 10:21:17 -0500
Message-ID: <F39349C6FA641B4A831B7BF4EBF4D4E148156ECB@dlee03.ent.ti.com>
References: <F39349C6FA641B4A831B7BF4EBF4D4E1480D9E48@dlee03.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E814709F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33980 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934495Ab0HMPVV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 11:21:21 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E814709F@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>

Sanjeev,

Please see my comments below:

> +EXPORT_SYMBOL(hwspinlock_trylock);

[sp] The code is almost duplicated in the functions hwspinlock_trylock()
     and hwspinlock_lock(). The difference being try-once/ try-multiple.
     I believe one function with additional arg - say limit - should be
     sufficient.

     If there is need to abstract additional arg, you can define macros
     for the same.
[SQ] Good point, done.

> +	for (i = 0; i < hwspinlock_state.num_locks && !found; i++) {
> +		if (!hwspinlock_array[i].is_allocated) {
> +			found = true;
> +			handle = &hwspinlock_array[i];
> +		}

[sp] Starting from index 0 every time can be quite time consuming
     esp. in the situations where we need spinlocks. IRQs being
     disabled for long can impact the performance.

     Wouldn't a used and free list be better alternative?
[SQ] Done.

> +	if (WARN_ON(hwspinlock_array[id].is_allocated))
> +		goto exit;
> +
[sp] if (id > hwspinlock_state.num_locks) then ??
[SQ] Good catch.  Fixed.

> +EXPORT_SYMBOL(hwspinlock_request_specific);

[sp] What if either of the "request" funcs are called before
     hwspinlock_probe() gets executed?
[SQ] Added a check for that.

> +/* Probe function */
> +static int __devinit hwspinlock_probe(struct platform_device *pdev) {
> +	struct resource *res;
> +	void __iomem *io_base;
> +	int id;
> +
[sp] Extra line?
[SQ] Yeah, got rid of it.

> +	void __iomem *sysstatus_reg;
[sp] can be combined with op_base declaration.
[SQ] Okay done.

> +static struct platform_driver hwspinlock_driver = {
> +	.probe		= hwspinlock_probe,
> +	.driver		= {
> +		.name	= "hwspinlock",

[sp] Extra TAB?
[SQ] No, it's one level down.  Notice the extra { }'s.


Thanks,
Simon
