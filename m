From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v2 3/5] counter: new TI eQEP driver
Date: Thu, 15 Aug 2019 21:37:58 +0900
Message-ID: <20190815123758.GA646493@icarus>
References: <20190807194023.15318-1-david@lechnology.com>
 <20190807194023.15318-4-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190807194023.15318-4-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 07, 2019 at 02:40:21PM -0500, David Lechner wrote:
> +static struct counter_synapse ti_eqep_position_synapses[] = {
> +	{
> +		.action		= TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES,
> +		.actions_list	= ti_eqep_position_synapse_actions,
> +		.num_actions	= ARRAY_SIZE(ti_eqep_position_synapse_actions),
> +		.signal		= &ti_eqep_signals[TI_EQEP_SIGNAL_QEPA],
> +	},
> +	{
> +		.action		= TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES,
> +		.actions_list	= ti_eqep_position_synapse_actions,
> +		.num_actions	= ARRAY_SIZE(ti_eqep_position_synapse_actions),
> +		.signal		= &ti_eqep_signals[TI_EQEP_SIGNAL_QEPB],
> +	},
> +};

Hi David,

Just a minor suggestion for your v3: you don't need to initialize
"action" here since it'll be automatically updated in the core
counter_action_show function to the value returned by your action_get
callback function. So you can safely delete those two ".action =" lines.

William Breathitt Gray
