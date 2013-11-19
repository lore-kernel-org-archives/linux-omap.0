From: Nishanth Menon <nm@ti.com>
Subject: Re: cpufreq on PandaBoard
Date: Tue, 19 Nov 2013 11:30:25 -0600
Message-ID: <528BA031.5050201@ti.com>
References: <87eh6ca150.fsf@gmail.com> <528B7D61.5020206@ti.com> <87hab8nwdl.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32771 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139Ab3KSRat (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Nov 2013 12:30:49 -0500
In-Reply-To: <87hab8nwdl.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>

On 11/19/2013 11:18 AM, Ben Gamari wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
>> On 11/19/2013 08:59 AM, Ben Gamari wrote:
>>>
>>> Booting a PandaBoard with a recent kernel and devicetree appears to be a
>>> rather messy process. There are dozens of devicetree-related warnings
>>> spewed on boot (many pertaining to missing regulators). At the moment,
>>> however, I'm most interested in this,
>>>
>>>     cpufreq-cpu0 cpufreq-cpu0.0: no of_node; not parsing pinctrl DT
>>>     cpu cpu0: dummy supplies not allowed
>>>     cpufreq_cpu0: failed to get cpu0 regulator: -19
>>>     cpufreq_cpu0: failed to get cpu0 clock: -2
>>>     cpufreq-cpu0: probe of cpufreq-cpu0.0 failed with error -2
>>>
>>> What is the status of cpufreq on the PandaBoard? Is this expected to
>>> work?
>>>
>>> More generally, if one wants a fairly recent kernel supporting the
>>> PandaBoard's hardware what kernel tree should be used? Is mainline not
>>> yet appropriate? Is linux-next preferred? Perhaps a ti-maintained tree?
>>
>> for upstream: Wait for the clock nodes to get merged.. we are at v9 of
>> discussion thread here[1].
>>
> I take it that the clock node work does not itself fix cpufreq? I've
> built the 3.12-dt-clks-v10-dev branch. On the bright side, it boots and
> appears to run just fine. Unfortunately, there isn't even a mention of
> cpufreq in the boot log.

You are probably picking up a branch that is yet to be posted :)...
and I assume you know the risk of in-development patches ;) - the
branch looks to introduce purely clock nodes which patch [2] adds on
to and makes cpufreq work as a start..


> 
> I've seen your Google+ post[1] from May enumerating the steps to having
> working DVFS. It would be useful to post an update showing what has been
> merged, what is waiting for merge, and what is still in progress.

We are still at "step 1 - get clock nodes" :(... and no, situation has
not improved since May 2013 when I originally posted that G+ comment
(and not because we have not been trying..).

> 
>> for ti-maintained tree, you need to talk to TI support folks for
>> appropriate kernel for your product line.
>>
> I wasn't asking for official support, just wondering where work is
> currently happening.

they are happening here in linux-omap mailing list.. just that the
changes are pretty fundamental and a lot of discussions have been
taking place
> 
> Thanks for your help.
> 
> Cheers,
> 
> - Ben
> 
> 
> [1] https://plus.google.com/112464029509057661457/posts/gvyZQcNieoq
> 
[2] http://marc.info/?l=linux-omap&m=138193821608515&w=2

-- 
Regards,
Nishanth Menon
