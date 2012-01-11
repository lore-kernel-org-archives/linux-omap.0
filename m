From: Archit <a0393947@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Wed, 11 Jan 2012 22:24:21 +0530
Message-ID: <4F0DBEBD.3040705@ti.com>
References: <WC20120109124643.880164@terrafix.co.uk> <20120110080849.5a242adf@notabene.brown> <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com> <4F0D9B15.4070803@ti.com> <WC20120111151532.4602C0@terrafix.co.uk> <4F0DB020.2080804@ti.com> <WC20120111161330.3602C8@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46718 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933596Ab2AKQyk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Jan 2012 11:54:40 -0500
In-Reply-To: <WC20120111161330.3602C8@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Paul Walmsley <paul@pwsan.com>, NeilBrown <neilb@suse.de>, khilman@ti.com, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

On Wednesday 11 January 2012 09:43 PM, Joe Woodward wrote:
> -----Original Message-----
> From: Archit<a0393947@ti.com>
> To: Joe Woodward<jw@terrafix.co.uk>
> Cc: Paul Walmsley<paul@pwsan.com>, NeilBrown<neilb@suse.de>,<khilman@ti.com>,<linux-omap@vger.kernel.org>, Tomi Valkeinen
> <tomi.valkeinen@ti.com>
> Date: Wed, 11 Jan 2012 21:22:00 +0530
> Subject: Re: DSS2/PM on 3.2 broken?
>
>> Hi,
>>
>> On Wednesday 11 January 2012 08:45 PM, Joe Woodward wrote:
>>> ...snip...
>>>
>>>>
>>>> Could you enable omapdss debug by adding 'omapdss.debug=1 debug' in
>>>> your bootargs and share logs?
>>>

<snip>

>> Archit
>
> I'm not 100% sure what you mean for mmount -t debugfs debugfs /sys/kernel/debuge to do here?
>
> Do you mean to halt the kernel after suspending, but before resuming? If so, how would I go about doing this?
>

I'd asked for reboot or power off as you have done below. The suspend 
path looks okay, I asked for the power off to see if there was a 
dss_runtime_get() was called at the wrong time by some interrupt while 
suspending.

One difference between the shutdown and suspend logs is that we don't 
see the prints 'omapdss DSS: dss_save_context' and 'omapdss DSS: context 
saved', that seems a bit fishy.

I'm not sure how to go ahead from here. We haven't seen this on OMAP4, 
and I don't think I have tried this on OAMP3. Maybe Tomi has more ideas.

Archit

> If I just reboot or poweroff I get the following...
>
> # poweroff
> The system is going down NOW!
> Sent SIGTERM to all processes
> Sent SIGKILL to all processes
> Requesting system poweroff
> [   43.310607] omapdss CORE: shutdown
> [   43.499053] omapdss DISPC: dispc_runtime_put
> [   43.504272] omapdss DISPC: dispc_save_context
> [   43.509399] omapdss DISPC: context saved, ctx_loss_count 0
> [   43.515747] omapdss DSS: dss_runtime_put
> [   43.521453] omapdss DSS: dss_runtime_put
> [   43.527221] System halted.
>
> # reboot
> The system is going down NOW!
> Sent SIGTERM to all processes
> Sent SIGKILL to all processes
> Requesting system reboot
> [   25.652008] omapdss CORE: shutdown
> [   25.836120] omapdss DISPC: dispc_runtime_put
> [   25.841125] omapdss DISPC: dispc_save_context
> [   25.846221] omapdss DSS: dss_runtime_put
> [   25.851776] omapdss DISPC: context saved, ctx_loss_count 0
> [   25.857788] omapdss DSS: dss_runtime_put
> [   25.864074] Restarting system.
>
> Cheers,
> Joe
>
>

