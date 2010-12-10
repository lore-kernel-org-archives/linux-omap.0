From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] OMAP: device: make rt_va easily avaialable to drivers
Date: Fri, 10 Dec 2010 12:47:02 -0600
Message-ID: <AANLkTi=mGG5mRUP9VpH5AfPn1irNXn-+sZTFwjhG6_Jp@mail.gmail.com>
References: <1291852792-3584-1-git-send-email-omar.ramirez@ti.com>
	<87oc8uc1dg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:55393 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752342Ab0LJSrD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 13:47:03 -0500
Received: by mail-iw0-f182.google.com with SMTP id 39so6259649iwn.27
        for <linux-omap@vger.kernel.org>; Fri, 10 Dec 2010 10:47:02 -0800 (PST)
In-Reply-To: <87oc8uc1dg.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Russell King <linux@arm.linux.org.uk>, Thara Gopinath <thara@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 9, 2010 at 11:16 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Omar Ramirez Luna <omar.ramirez@ti.com> writes:
>
>> Patch "OMAP: hwmod/device: add omap_{device, hwmod}_get_mpu_rt_va"[1=
],
>> introduces omap_device_get_rt_va which is meant to be called
>> by drivers to retrieve the _mpu_rt_va, however this function
>> receives a pointer to an omap_device; since there is no
>> practical way for a driver to get this parameter without
>> fiddling with pdev and container_of macro, and omap_device code
>> already does this, it is better for it to handle this case.
>>
>> Also moved header declaration to appear in the set of
>> functions to be used by drivers, as per the comment there.
>>
>> [1] http://marc.info/?l=3Dlinux-omap&m=3D127808467703366&w=3D2
>>
>> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
>
> Looks right, since all the other driver-accessible functions take a
> platform_device pointer, not an omap_device pointer.
>
> Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>
> However, I thing the subject/shortlog should be clearer. =A0IMO, this
> patch makes the API more consistent rather than making it easier.
> Also, subject prefix should be preferrably 'OMAP: omap_device:'.

I saw few patches following the convention "OMAP: device" that's why I
followed that one, I will change the subject/changelog according to
your suggestions.

Thanks,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
