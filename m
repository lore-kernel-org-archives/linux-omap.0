From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH 1/2] omap2+: add drm device
Date: Fri, 13 Jan 2012 15:19:59 -0600
Message-ID: <CAF6AEGvdLsg33yGqTQQ7EWJh_4+rGSPbCZmSSYCib1cSS2pqWg@mail.gmail.com>
References: <1326487320-8781-1-git-send-email-rob.clark@linaro.org>
	<CAMP44s36cE_dBQcyDnboUgbUCtjgMnLnZq8c+0qB8GfH9Tq8aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37339 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831Ab2AMVUA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jan 2012 16:20:00 -0500
Received: by vcbfk1 with SMTP id fk1so644040vcb.19
        for <linux-omap@vger.kernel.org>; Fri, 13 Jan 2012 13:19:59 -0800 (PST)
In-Reply-To: <CAMP44s36cE_dBQcyDnboUgbUCtjgMnLnZq8c+0qB8GfH9Tq8aA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: linux-omap@vger.kernel.org, patches@linaro.org, Greg KH <greg@kroah.com>, dri-devel@lists.freedesktop.org

On Fri, Jan 13, 2012 at 2:59 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Fri, Jan 13, 2012 at 10:41 PM, Rob Clark <rob.clark@linaro.org> wr=
ote:
>> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefi=
le
>> index 9a58461..b86e6cb 100644
>> --- a/arch/arm/plat-omap/Makefile
>> +++ b/arch/arm/plat-omap/Makefile
>> @@ -4,7 +4,7 @@
>>
>> =A0# Common support
>> =A0obj-y :=3D common.o sram.o clock.o devices.o dma.o mux.o \
>> - =A0 =A0 =A0 =A0usb.o fb.o counter_32k.o
>> + =A0 =A0 =A0 =A0usb.o fb.o counter_32k.o drm.o
>
> Should be something like this:
> obj-$(CONFIG_DRM_OMAP) +=3D drm.o

btw, how does that work if CONFIG_DRM_OMAP=3Dm?  Do you end up w/ a
plat-omap module?

BR,
-R

> No?
>
> --
> Felipe Contreras
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
