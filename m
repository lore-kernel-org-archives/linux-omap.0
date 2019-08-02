From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 2/4] counter: new TI eQEP driver
Date: Fri, 2 Aug 2019 11:17:11 -0500
Message-ID: <680ed555-c5db-6640-8fd3-121422077eff@lechnology.com>
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-3-david@lechnology.com> <20190802092727.GB30522@icarus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802092727.GB30522@icarus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 8/2/19 4:27 AM, William Breathitt Gray wrote:
>> +static const struct counter_ops ti_eqep_counter_ops = {
>> +	.count_read	= ti_eqep_count_read,
>> +	.count_write	= ti_eqep_count_write,
>> +	.function_get	= ti_eqep_function_get,
>> +	.function_set	= ti_eqep_function_set,
>> +};
> Are you able to provide a signal_read function, or are the Signals not
> exposed to the user by this device? Sometimes quadrature encoder devices
> provide an instanteous read of the signal lines to tell whether they are
> high or low, so I figured I'd ask.

No, it does not look like these signals can be read directly.

> 
> You should define an action_get function as well along with Synapses
> corresponding to each Signal. This will allow users to know whether the
> Synapse fires on a rising edge, falling edge, no edge, or both edges.
> 
> For example, consider the drivers/counter/104-quad-8.c file. Each count
> register has three associated signal lines: Quadrature A, Quadrature B,
> and Index.
> 
> Quadrature A and B are your typical quadrature encoder lines and
> depending on the function mode selected (quadrature x4, pulse-direction,
> etc.) could have a Synapse action mode of none, rising edge, falling
> edge, or both edges; see the quad8_synapse_actions_list array.
> 
> In contrast, the Index signal line only has two Synapse action modes:
> rising edge (in the case preset functionality is enabled) or none.

The encoders I have don't use the index or strobe signals, so I was
thinking maybe I should omit those two signals from the driver for the
time being since I don't have a way of testing.

> 
> For the TI eQEP driver, there will be four Synapses corresponding to the
> four Signals: QEPA, QEPB, QEPI, and QEPS. See if you are able to
> implement the Synapses and action_get function by using the 104-quad-8.c
> file as a reference. That file does have a lot of extra functionality
> tossed in compared to yours, so if you have trouble groking it, just let
> me know and I'll try to help.
> 
