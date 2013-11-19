From: Nishanth Menon <nm@ti.com>
Subject: Re: cpufreq on PandaBoard
Date: Tue, 19 Nov 2013 09:01:53 -0600
Message-ID: <528B7D61.5020206@ti.com>
References: <87eh6ca150.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58622 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568Ab3KSPCU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 10:02:20 -0500
In-Reply-To: <87eh6ca150.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>

On 11/19/2013 08:59 AM, Ben Gamari wrote:
> 
> Booting a PandaBoard with a recent kernel and devicetree appears to be a
> rather messy process. There are dozens of devicetree-related warnings
> spewed on boot (many pertaining to missing regulators). At the moment,
> however, I'm most interested in this,
> 
>     cpufreq-cpu0 cpufreq-cpu0.0: no of_node; not parsing pinctrl DT
>     cpu cpu0: dummy supplies not allowed
>     cpufreq_cpu0: failed to get cpu0 regulator: -19
>     cpufreq_cpu0: failed to get cpu0 clock: -2
>     cpufreq-cpu0: probe of cpufreq-cpu0.0 failed with error -2
> 
> What is the status of cpufreq on the PandaBoard? Is this expected to
> work?
> 
> More generally, if one wants a fairly recent kernel supporting the
> PandaBoard's hardware what kernel tree should be used? Is mainline not
> yet appropriate? Is linux-next preferred? Perhaps a ti-maintained tree?
for upstream: Wait for the clock nodes to get merged.. we are at v9 of
discussion thread here[1].

for ti-maintained tree, you need to talk to TI support folks for
appropriate kernel for your product line.

[1] http://marc.info/?t=138271672500002&r=1&w=2
-- 
Regards,
Nishanth Menon
