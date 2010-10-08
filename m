From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] tidspbridge: use a parameter to allocate shared memory
Date: Fri, 8 Oct 2010 11:20:24 +0300
Message-ID: <AANLkTikHMewD94ZBb9P4AF9oM2ZfnpA-yjO67Dx2Lg9r@mail.gmail.com>
References: <1286430336-20204-1-git-send-email-omar.ramirez@ti.com>
	<201010070940.14208.laurent.pinchart@ideasonboard.com>
	<4CADFCEB.4030008@ti.com>
	<AANLkTim8H0ibSucP3Nq=q19t0QY0pvijim1kOZSbygY1@mail.gmail.com>
	<4CAE1CA1.4050006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51043 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660Ab0JHIU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Oct 2010 04:20:26 -0400
Received: by fxm14 with SMTP id 14so274180fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 08 Oct 2010 01:20:25 -0700 (PDT)
In-Reply-To: <4CAE1CA1.4050006@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Greg Kroah-Hartman <gregkh@suse.de>, Russell King <linux@arm.linux.org.uk>, "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>

On Thu, Oct 7, 2010 at 10:16 PM, Omar Ramirez Luna <omar.ramirez@ti.com> wrote:
> On 10/7/2010 1:22 PM, Felipe Contreras wrote:
>> Anyway, we will not know for sure until we try... Right?
>
> yes we can try, at least we now for sure arm side can be done.

The only thing that changes is the cacheability of the ARM side
memory, so of course only the ARM side matters. The DSP side will
continue to do what it's doing and would not notice any difference if
the memory is flushed, or is non-cacheable.

-- 
Felipe Contreras
