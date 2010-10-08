From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [RFC] tidspbridge: use a parameter to allocate shared memory
Date: Fri, 8 Oct 2010 12:31:14 -0500
Message-ID: <4CAF5562.9060107@ti.com>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>	<201010070940.14208.laurent.pinchart@ideasonboard.com>	<4CADFCEB.4030008@ti.com>	<AANLkTim8H0ibSucP3Nq=q19t0QY0pvijim1kOZSbygY1@mail.gmail.com>	<4CAE1CA1.4050006@ti.com> <AANLkTikHMewD94ZBb9P4AF9oM2ZfnpA-yjO67Dx2Lg9r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51367 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758939Ab0JHRba (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 13:31:30 -0400
In-Reply-To: <AANLkTikHMewD94ZBb9P4AF9oM2ZfnpA-yjO67Dx2Lg9r@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Greg Kroah-Hartman <gregkh@suse.de>, Russell King <linux@arm.linux.org.uk>, "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 10/8/2010 3:20 AM, Felipe Contreras wrote:
> On Thu, Oct 7, 2010 at 10:16 PM, Omar Ramirez Luna<omar.ramirez@ti.com>  wrote:
>> On 10/7/2010 1:22 PM, Felipe Contreras wrote:
>>> Anyway, we will not know for sure until we try... Right?
>>
>> yes we can try, at least we now for sure arm side can be done.
>
> The only thing that changes is the cacheability of the ARM side
> memory, so of course only the ARM side matters. The DSP side will
> continue to do what it's doing and would not notice any difference if
> the memory is flushed, or is non-cacheable.
>

Please find my reply for the previous mail:

http://marc.info/?l=linux-omap&m=128655845213913&w=2

Regards,

Omar
