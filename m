From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] omap2+: add drm device
Date: Thu, 15 Mar 2012 07:32:50 -0500
Message-ID: <CAF6AEGtC9BA-8WZGNOs_rMFrzt88XPNjVRUooG7-Nxe7yDKjpA@mail.gmail.com>
References: <1331670878-12951-1-git-send-email-rob.clark@linaro.org>
	<1331728737.2386.76.camel@deskari>
	<CAF6AEGvBB3AVrfXnpZwZCZGy48Re5sxm-jgLxSpH=nLzLKe0iA@mail.gmail.com>
	<1331730465.1542.8.camel@lappy>
	<CAF6AEGtTKf6w7TrgV8sKoSg=XEuqkfdgMj=vL2oksOMdB2Tbyg@mail.gmail.com>
	<1331732624.1542.32.camel@lappy>
	<CAF6AEGsCpz4zXCSXhP5qA7hL4Xac9+c03rS1PZejhUog_+SHkg@mail.gmail.com>
	<1331801177.2768.8.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:56142 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761477Ab2COMcv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 08:32:51 -0400
Received: by vcqp1 with SMTP id p1so3078112vcq.19
        for <linux-omap@vger.kernel.org>; Thu, 15 Mar 2012 05:32:50 -0700 (PDT)
In-Reply-To: <1331801177.2768.8.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org

On Thu, Mar 15, 2012 at 3:46 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Wed, 2012-03-14 at 10:06 -0500, Rob Clark wrote:
>
>> > Well, as I said, it's not an issue for me and from my side it can =
be
>> > improved later.
>>
>> yeah, when CMA is actually merged, there are a few other things I'd
>> like to do to, incl converting omapfb over to use CMA and remove
>> omap_vram.. but I guess those will be other patches.
>
> Right, I just realized CMA is not in the kernel, nor does it seem to =
be
> in the linux-next. Is there a reason why you want it already merged?
> Wouldn't it be easier to get it in only when it can actually be used.
> Especially if there's room for improvement.

Some folks are already pulling CMA into product kernels for various
reasons.. keeping this w/ #ifdef CONFIG_CMA guards seemed like it
would make their life a bit easier.

But if people feel strongly about it, I can strip that out.

BR,
-R


> =A0Tomi
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
