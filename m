From: Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH v3 04/13] OMAP: hwmod: Wait the idle status to be disabled
Date: Tue, 5 Jul 2011 11:21:44 -0700
Message-ID: <20110705182144.GA10846@google.com>
References: <1309554558-19819-1-git-send-email-b-cousson@ti.com>
	<1309554558-19819-5-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1309554558-19819-5-git-send-email-b-cousson@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: paul@pwsan.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 01, 2011 at 11:09:09PM +0200, Benoit Cousson wrote:
> It is mandatory to wait for a module to be in disabled state before
> potentially disabling source clock or re-asserting a reset.
> 
> omap_hwmod_idle and omap_hwmod_shutdown does not wait for
> the module to be fully idle.
> 
> Add a cm_xxx accessor to wait the clkctrl idle status to be disabled.
> Fix hwmod_[idle|shutdown] to use this API.
...
> +int omap4_cm_wait_module_idle(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs)

Technically this waits for a module slave to enter "full idle" --
"interface idle" not good enough, and if the module is also a master
its standby status could possibly be different... personally, these
details make my brain hurt, but thought I'd mention this in case
the naming of this interface should capture any of these distinctions.

> +{
> +	int i = 0;
> +
> +	if (!clkctrl_offs)
> +		return 0;
> +
> +	omap_test_timeout(
> +		_clkctrl_idlest(part, inst, cdoffs, clkctrl_offs) == 0x3,
> +		MAX_MODULE_READY_TIME, i);

The numeric constant may already have an equivalent symbol defined, or
suggest adding one.

>  /**
> + * _wait_target_disable - wait for a module to be disabled
> + * @oh: struct omap_hwmod *
> + *
> + * Wait for a module @oh to leave slave idle.  Returns 0 if the module
> + * does not have an IDLEST bit or if the module successfully leaves
> + * slave idle; otherwise, pass along the return value of the
> + * appropriate *_cm_wait_module_ready() function.

This paragraph probably c&p from a function with opposite meaning.

...
>  static int _idle(struct omap_hwmod *oh)
>  {
> +	int ret;
> +
>  	pr_debug("omap_hwmod: %s: idling\n", oh->name);
>  
>  	if (oh->_state != _HWMOD_STATE_ENABLED) {
> @@ -1351,6 +1383,10 @@ static int _idle(struct omap_hwmod *oh)
>  		_idle_sysc(oh);
>  	_del_initiator_dep(oh, mpu_oh);
>  	_disable_clocks(oh);
> +	ret = _wait_target_disable(oh);
> +	if (ret)
> +		pr_debug("omap_hwmod: %s: _wait_target_disable failed\n",
> +			   oh->name);

Should callers see an error function return in this case?


Todd
