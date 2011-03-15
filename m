From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: Code for v2.6.39 merge window frozen, patches archived
Date: Tue, 15 Mar 2011 21:07:41 +0100
Message-ID: <4D7FC70D.7050508@ti.com>
References: <20110314192538.GH7258@atomide.com> <alpine.DEB.1.10.1103151856180.880@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51370 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757649Ab1COUHk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 16:07:40 -0400
In-Reply-To: <alpine.DEB.1.10.1103151856180.880@esdhcp041196.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Hi Aaro,

On 3/15/2011 6:54 PM, Aaro Koskinen wrote:
> Hi,
>
> On Mon, 14 Mar 2011, Tony Lindgren wrote:
>> I've applied few random fix like patches today into omap-for-linus
>> but that's it for this merge window.
>>
>> So let's do some testing with with Stephen's for-next and
>> omap-for-linus and start queueing up fixes for the -rc cycle.
>
> I did some quick testing:
>
> linux-omap/master, omap2plus_defconfig:
>
>   	- RM-680 hangs after uncompressing kernel. earlyprintk shows:
>
>   	[    0.293395] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_core
>   	[    0.300903] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_per
>   	[    0.308288] omap_hwmod: _populate_mpu_rt_base found no _mpu_rt_va for l4_wkup
>   	[    0.316101] omap_hwmod: gpt12_fck: missing clockdomain for gpt12_fck.
>
>   	(then some garbage)
>
>   	- With RX-51 I get the same messages, but no hang.

Mmm, that looks like an access to a secure timer from hwmod code on a HS 
device. Could you comment out the timer12 entry 
(&omap3xxx_timer12_hwmod) in the omap3 hwmod list at the end of 
omap_hwmod_3xxx_data.c to check that?

Thanks
Benoit

>
> omap-for-linux, omap2plus_defconfig:
>
>   	- Pretty much the same. RM-680 hangs and the first bad commit is
>   	ce722d269ff85ab11aa680784bcc6eff06e3e3ea and earlyprintk shows
>   	"external abort on non-linefetch" in omap_hwmod_read() after
>   	above messages.
>
> Mainline kernel (v2.6.38) boots fine.
>
> A.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

