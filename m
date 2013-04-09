From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/omap: Take a fb reference in omap_plane_update()
Date: Tue, 9 Apr 2013 15:41:42 +0200
Message-ID: <CAKMK7uHfWhhYzFagbBSBfwcDPz7AbXZaBtMQFmvvUTN2H4Uk8g@mail.gmail.com>
References: <1365510362-18379-1-git-send-email-archit@ti.com>
	<20130409125317.GX2228@phenom.ffwll.local>
	<CAF6AEGsXDp5gnNyfU3CYNvxhEL98ngbJ7OnBnLxpFQb-2o4=aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:44000 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932747Ab3DINln (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 09:41:43 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so8480116ieb.34
        for <linux-omap@vger.kernel.org>; Tue, 09 Apr 2013 06:41:43 -0700 (PDT)
In-Reply-To: <CAF6AEGsXDp5gnNyfU3CYNvxhEL98ngbJ7OnBnLxpFQb-2o4=aQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

On Tue, Apr 9, 2013 at 3:17 PM, Rob Clark <robdclark@gmail.com> wrote:
>>> diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
>>> index 2882cda..8d225d7 100644
>>> --- a/drivers/gpu/drm/omapdrm/omap_plane.c
>>> +++ b/drivers/gpu/drm/omapdrm/omap_plane.c
>>> @@ -247,6 +247,12 @@ static int omap_plane_update(struct drm_plane *plane,
>>>  {
>>>       struct omap_plane *omap_plane = to_omap_plane(plane);
>>>       omap_plane->enabled = true;
>>> +
>>> +     if (plane->fb)
>>> +             drm_framebuffer_unreference(plane->fb);
>>
>> Shouldn't the unref only happen once the flip has completed? Otherwise we
>> might free the memory which is still being scanned out and put some other
>> crap there.
>
> yup, there is a 2nd ref grabbed when we start scanout and dropped when
> we finish scanout..  so that part was already covered.  What wasn't
> covered before was the time between the ioctl and the worker thread
> (which was grabbing/dropping the scanout ref)

Ah, I see. And the ordering doesn't seem to matter here since it's all
protected by locks (against races with the worker thread) anyway.
Thanks for the explanation.
-Daniel

--
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
