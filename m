From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH 1/2] omap2+: add drm device
Date: Thu, 9 Feb 2012 11:41:55 -0600
Message-ID: <CAN_cFWPNKGTy=C+SegJ7yrQZGZ9HrKu_R6sRfqcpAQ8xajzvGQ@mail.gmail.com>
References: <1326487320-8781-1-git-send-email-rob.clark@linaro.org>
	<20120209172804.GA27532@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46643 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab2BIRl4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 12:41:56 -0500
Received: by vcge1 with SMTP id e1so1253976vcg.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 09:41:55 -0800 (PST)
In-Reply-To: <20120209172804.GA27532@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, patches@linaro.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

On Thu, Feb 9, 2012 at 11:28 AM, Greg KH <gregkh@linuxfoundation.org> w=
rote:
> On Fri, Jan 13, 2012 at 02:41:59PM -0600, Rob Clark wrote:
>> From: Rob Clark <rob@ti.com>
>>
>> Register OMAP DRM/KMS platform device, and reserve a CMA region for
>> the device to use for buffer allocation.
>>
>> v1: initial patch
>> v2: move platform data structs into plat-omap to avoid having to
>> =A0 =A0 #include headers from drivers/staging and cleanups
>>
>> Signed-off-by: Rob Clark <rob@ti.com>
>> ---
>> Note: after applying this patch there will be duplicate copies of th=
e
>> platform data structs (until the 2nd patch is applied). =A0But I tes=
ted
>> to ensure this does not cause build breaks. =A0So the 2nd patch whic=
h
>> should go thru staging tree is safe to be held until this patch hits
>> Linus's master branch.
>>
>> =A0arch/arm/plat-omap/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
>> =A0arch/arm/plat-omap/common.c =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +-
>> =A0arch/arm/plat-omap/drm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 83 ++++=
+++++++++++++++++++++++++++++
>> =A0arch/arm/plat-omap/include/plat/drm.h | =A0 70 ++++++++++++++++++=
+++++++++
>> =A04 files changed, 156 insertions(+), 2 deletions(-)
>> =A0create mode 100644 arch/arm/plat-omap/drm.c
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/drm.h
>
> Did this ever get applied?

Not yet, there was requested some omap hwmod related changes for how
the driver gets SoC version specific information (irq, base addr), so
I'll resubmit again the device file registration (and the 2nd patch)
but that might have to be for 3.4

You can drop the existing 2/2 patch

BR,
-R


> As I can't apply 2/2 without it, please feel
> free to add:
> =A0 =A0 =A0 =A0Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.o=
rg>
>
> to 2/2 when some dri/omap developer commits this one.
>
> thanks,
>
> greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
