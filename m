From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] staging: drm/omap: add rotation properties
Date: Wed, 27 Jun 2012 15:02:45 -0500
Message-ID: <CAF6AEGuY-fx8FA8rq4EXyyM3PC0yyU50876dBOFAQOUz2EZB+g@mail.gmail.com>
References: <1340805986-10670-1-git-send-email-rob.clark@linaro.org>
	<20120627194022.GA9097@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:33982 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251Ab2F0UCq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 16:02:46 -0400
Received: by vcbf11 with SMTP id f11so999820vcb.19
        for <linux-omap@vger.kernel.org>; Wed, 27 Jun 2012 13:02:45 -0700 (PDT)
In-Reply-To: <20120627194022.GA9097@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, patches@linaro.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, cmahapatra@ti.com, s-guiriec@ti.com, archit@ti.com

On Wed, Jun 27, 2012 at 2:40 PM, Greg KH <greg@kroah.com> wrote:
> On Wed, Jun 27, 2012 at 09:06:26AM -0500, Rob Clark wrote:
>> From: Rob Clark <rob@ti.com>
>>
>> Use tiled buffers for rotated/reflected scanout, with CRTC and plane
>> properties as the interface for userspace to configure rotation.
>>
>> Signed-off-by: Rob Clark <rob@ti.com>
>> ---
>> =A0drivers/staging/omapdrm/omap_crtc.c =A0 =A0 =A0| =A0 17 +++++
>> =A0drivers/staging/omapdrm/omap_dmm_tiler.c | =A0 47 ++++++++++++--
>> =A0drivers/staging/omapdrm/omap_dmm_tiler.h | =A0 17 ++++-
>> =A0drivers/staging/omapdrm/omap_drv.c =A0 =A0 =A0 | =A0 17 +++++
>> =A0drivers/staging/omapdrm/omap_drv.h =A0 =A0 =A0 | =A0 32 +++++++++=
-
>> =A0drivers/staging/omapdrm/omap_fb.c =A0 =A0 =A0 =A0| =A0 99 +++++++=
++++++++++++++++++-----
>> =A0drivers/staging/omapdrm/omap_gem.c =A0 =A0 =A0 | =A0 43 +++++++++=
+++-
>> =A0drivers/staging/omapdrm/omap_plane.c =A0 =A0 | =A0 92 +++++++++++=
+++++++++-------
>> =A08 files changed, 318 insertions(+), 46 deletions(-)
>
> That's great you are adding new features, but how goes the progress t=
o
> get this driver out of the drivers/staging/ area and moved to the rea=
l
> part of the kernel? =A0I don't want to keep taking new features witho=
ut
> seeing some progress on getting the code cleaned up and moved out fir=
st.

Oh, heh, well I suppose the first thing to do is send a patch to clean
up the TODO file.. I just noticed that I'd been forgetting to update
it.

BR,
-R


> thanks,
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
