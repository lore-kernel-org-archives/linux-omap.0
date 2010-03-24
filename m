From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: DSP recovery feature
Date: Wed, 24 Mar 2010 21:49:00 +0200
Message-ID: <20100324194900.GF13654@annwn.felipec.org>
References: <94a0d4531003190853y7b6bda0dg6db8ab263bbb8532@mail.gmail.com>
 <19F8576C6E063C45BE387C64729E7394044DE0E3DE@dbde02.ent.ti.com>
 <94a0d4531003190918v7e943d5ax16baf6945472530c@mail.gmail.com>
 <94a0d4531003191200r425652c3ybf505c353b2ad847@mail.gmail.com>
 <496565EC904933469F292DDA3F1663E602CACBD655@dlee06.ent.ti.com>
 <94a0d4531003191511q6135a424r9ce68c632cc826dd@mail.gmail.com>
 <496565EC904933469F292DDA3F1663E602CACBD669@dlee06.ent.ti.com>
 <496565EC904933469F292DDA3F1663E602CACBDF08@dlee06.ent.ti.com>
 <94a0d4531003241115i7b11af8cqb00b478afeb86297@mail.gmail.com>
 <496565EC904933469F292DDA3F1663E602CADC2E70@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38448 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab0CXTtM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 15:49:12 -0400
Content-Disposition: inline
In-Reply-To: <496565EC904933469F292DDA3F1663E602CADC2E70@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "Hebbar, Shivananda" <x0hebbar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Palande Ameya (Nokia-D/Helsinki)" <ameya.palande@nokia.com>

Hey Fernando,

On Wed, Mar 24, 2010 at 08:18:36PM +0100, ext Guzman Lugo, Fernando wrote:
> 
> Hi Felipe,
> 
> >So, before your patch, the get_message() failed, and the next
> >wait_for_events() succeeded and returned the MMU fault. Now, the
> >get_message() fails, and so does the wait_for_events().
> 
> The think is that the now after fatal error and recovery process start
> all bridge ioctl's will fail with -EIO (that was the requirement when
> I did the code)
> 
> @@ -496,6 +553,12 @@ static long bridge_ioctl(struct file *filp, unsigned int code,
>  	union Trapped_Args buf_in;
>  
>  	DBC_REQUIRE(filp != NULL);
> +#ifdef CONFIG_BRIDGE_RECOVERY
> +	if (recover) {
> +		status = -EIO;
> +		goto err;
> +	}
> +#endif
> 
> So you if you call dsp_node_get_message and then a fatal error
> happens, dsp_node_get_message will failed and if you what to call
> dsp_wait_for_events will fail because we are in recovery process
> (before it was succeeded because wait_for_events ioctl can go through
> and the MMUFault event was already signaled).
> 
> To sum up:
> With this patch in order to be notified of fatal errors you need to
> register for those and call dsp_wait_for_events before the fatal error
> occurs. Otherwise dsp_wait_for_events will fail.
> 
> So I think you need a dedicate thread to receive fatal errors.

One thread to fetch messages and another thread to receive fatal errors?
Come on, that's overkill... threads are not free.

I'm ok changing gst-dsp code, but let's be clear about this; this is yet
another ABI break.

If I can detect fatal errors in wait_for_events() then I don't need to
register for MMU faults, sys erros and all that stuff. Now, how do I
distinguish a fatal wait_for_events() vs a non-fatal one (timeout).

Cheers.

-- 
Felipe Contreras
