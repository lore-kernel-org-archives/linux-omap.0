From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Use ARM SMC Calling Convention when OP-TEE is
 available
Date: Mon, 18 Nov 2019 13:57:59 -0800
Message-ID: <20191118215759.GD35479@atomide.com>
References: <20191118165236.22136-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191118165236.22136-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Andrew F. Davis <afd@ti.com> [191118 08:53]:
> +#define OMAP_SIP_SMC_STD_CALL_VAL(func_num) \
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_STD_CALL, ARM_SMCCC_SMC_32, \
> +	ARM_SMCCC_OWNER_SIP, (func_num))
> +
> +void omap_smc1(u32 fn, u32 arg)
> +{
> +	struct device_node *optee;
> +	struct arm_smccc_res res;
> +
> +	/*
> +	 * If this platform has OP-TEE installed we use ARM SMC calls
> +	 * otherwise fall back to the OMAP ROM style calls.
> +	 */
> +	optee = of_find_node_by_path("/firmware/optee");
> +	if (optee) {
> +		arm_smccc_smc(OMAP_SIP_SMC_STD_CALL_VAL(fn), arg,
> +			      0, 0, 0, 0, 0, 0, &res);
> +		WARN(res.a0, "Secure function call 0x%08x failed\n", fn);
> +	} else {
> +		_omap_smc1(fn, arg);
> +	}
> +}

I think we're better off just making arm_smccc_smc() work properly.
See cat arch/arm*/kernel/smccc-call.S.

If quirk handling is needed, looks like ARM_SMCCC_QUIRK_STATE_OFFS
can be used.

AFAIK this should work both for optee and the current use cases.

Regards,

Tony
