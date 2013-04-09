From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] drm/omap: Take a fb reference in omap_plane_update()
Date: Tue, 9 Apr 2013 09:17:01 -0400
Message-ID: <CAF6AEGsXDp5gnNyfU3CYNvxhEL98ngbJ7OnBnLxpFQb-2o4=aQ@mail.gmail.com>
References: <1365510362-18379-1-git-send-email-archit@ti.com>
	<20130409125317.GX2228@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:52918 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760019Ab3DINRC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 09:17:02 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so6304845iak.4
        for <linux-omap@vger.kernel.org>; Tue, 09 Apr 2013 06:17:01 -0700 (PDT)
In-Reply-To: <20130409125317.GX2228@phenom.ffwll.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Archit Taneja <archit@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

On Tue, Apr 9, 2013 at 8:53 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Tue, Apr 09, 2013 at 05:56:02PM +0530, Archit Taneja wrote:
>> When userspace calls SET_PLANE ioctl, drm core takes a reference of the fb and
>> passes control to the update_plane op defined by the drm driver.
>>
>> In omapdrm, we have a worker thread which queues framebuffers objects received
>> from update_plane and displays them at the appropriate time.
>>
>> It is possible that the framebuffer is destoryed by userspace between the time
>> of calling the ioctl and apply-worker being scheduled. If this happens, the
>> apply-worker holds a pointer to a framebuffer which is already destroyed.
>>
>> Take an extra refernece/unreference of the fb in omap_plane_update() to prevent
>> this from happening. A reference is taken of the fb passed to update_plane(),
>> the previous framebuffer (held by plane->fb) is unreferenced. This will prevent
>> drm from destroying the framebuffer till the time it's unreferenced by the
>> apply-worker.
>>
>> This is in addition to the exisitng reference/unreference in update_pin(),
>> which is taken for the scanout of the plane's current framebuffer, and an
>> unreference the previous framebuffer.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> Cc: Rob Clark <robdclark@gmail.com>
>> ---
>>  drivers/gpu/drm/omapdrm/omap_plane.c |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
>> index 2882cda..8d225d7 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_plane.c
>> +++ b/drivers/gpu/drm/omapdrm/omap_plane.c
>> @@ -247,6 +247,12 @@ static int omap_plane_update(struct drm_plane *plane,
>>  {
>>       struct omap_plane *omap_plane = to_omap_plane(plane);
>>       omap_plane->enabled = true;
>> +
>> +     if (plane->fb)
>> +             drm_framebuffer_unreference(plane->fb);
>
> Shouldn't the unref only happen once the flip has completed? Otherwise we
> might free the memory which is still being scanned out and put some other
> crap there.

yup, there is a 2nd ref grabbed when we start scanout and dropped when
we finish scanout..  so that part was already covered.  What wasn't
covered before was the time between the ioctl and the worker thread
(which was grabbing/dropping the scanout ref)

BR,
-R

> Note that I've been too lazy to read the code, but I expected the unref of
> the old one to happen after the ref-taking for the new one, with a vblank
> wait/delay in between ... Might be that I'm completely off ;-)
> -Daniel
>
>> +
>> +     drm_framebuffer_reference(fb);
>> +
>>       return omap_plane_mode_set(plane, crtc, fb,
>>                       crtc_x, crtc_y, crtc_w, crtc_h,
>>                       src_x, src_y, src_w, src_h,
>> --
>> 1.7.10.4
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
