From: Daniel Stone <daniel@fooishbar.org>
Subject: Re: [PATCH 09/21] drm/omap: handle mismatching color format and
 buffer width
Date: Fri, 27 Feb 2015 14:40:20 +0000
Message-ID: <CAPj87rP4675D9WY8eGUPCePcx7Oi+faYs5K4B_BGtyh1H4RmJA@mail.gmail.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
	<1424956829-22892-10-git-send-email-tomi.valkeinen@ti.com>
	<20150227130158.GX24485@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:42416 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbbB0OkV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Feb 2015 09:40:21 -0500
Received: by wghl2 with SMTP id l2so20849088wgh.9
        for <linux-omap@vger.kernel.org>; Fri, 27 Feb 2015 06:40:20 -0800 (PST)
In-Reply-To: <20150227130158.GX24485@phenom.ffwll.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel <dri-devel@lists.freedesktop.org>

Hi,

On 27 February 2015 at 13:01, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Feb 26, 2015 at 03:20:17PM +0200, Tomi Valkeinen wrote:
>> omapdrm doesn't check if the width of the framebuffer and the color

s/width/pitch/

>> format's bits-per-pixel match.

s/match/are compatible/

>> For example, using a display with a width of 1280, and a buffer
>> allocated with using 32 bits per pixel (i.e. 1280*4 = 5120 bytes), with

Might be clearer to say 'i.e. byte stride of ...', and also s/with using/for/.

>> a 24 bits per pixel color format, leads to the following mismatch:
>> 5120/3 = 1706.666... bytes. This causes bad colors and a tilt on the

s/bytes/pixels/

>> screen.
>>
>> Add a check into omapdrm to return an error if the user tries to use
>> such a combination.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> ---
>>  drivers/gpu/drm/omapdrm/omap_fb.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
>> index 2975096abdf5..bf98580223d0 100644
>> --- a/drivers/gpu/drm/omapdrm/omap_fb.c
>> +++ b/drivers/gpu/drm/omapdrm/omap_fb.c
>> @@ -463,6 +463,14 @@ struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
>>                       goto fail;
>>               }
>>
>> +             if (mode_cmd->width % format->planes[i].stride_bpp != 0) {
>
> width is in pixels. No idea what you're trying to check here, but this
> probably isn't it.

stride_bpp is very misnamed: it is the bits per pixel for that plane,
and not stride at all. I think the check should in fact be be (pitch %
format->planes[i].stride_bpp), which would achieve the desired result,
i.e. that the stride can be expressed as an integer number of pixels.

> Also drm checks that things fit into the specified pitch (which is in
> bytes), see the pichtes[i] < width * cpp check in framebuffer_check.

This isn't that check. At some stages, OMAP IIRC requires pitch to be
specified in pixels rather than bytes, so this makes sure that's
possible to express.

Cheers,
Daniel
