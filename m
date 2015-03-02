From: Daniel Stone <daniel@fooishbar.org>
Subject: Re: [PATCH 09/21] drm/omap: handle mismatching color format and
 buffer width
Date: Mon, 2 Mar 2015 10:22:24 +0000
Message-ID: <CAPj87rOranF8WA=cPiHv=XwLSRscBLfNi+BemUhObys2nb8YKQ@mail.gmail.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
	<1424956829-22892-10-git-send-email-tomi.valkeinen@ti.com>
	<20150227130158.GX24485@phenom.ffwll.local>
	<CAPj87rP4675D9WY8eGUPCePcx7Oi+faYs5K4B_BGtyh1H4RmJA@mail.gmail.com>
	<54F4326B.6040209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:46609 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbbCBKW0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2015 05:22:26 -0500
Received: by widem10 with SMTP id em10so13557108wid.5
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2015 02:22:25 -0800 (PST)
In-Reply-To: <54F4326B.6040209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, linux-omap@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel <dri-devel@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>

Hi,

On 2 March 2015 at 09:50, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 27/02/15 16:40, Daniel Stone wrote:
>> On 27 February 2015 at 13:01, Daniel Vetter <daniel@ffwll.ch> wrote:
>>> On Thu, Feb 26, 2015 at 03:20:17PM +0200, Tomi Valkeinen wrote:
>>>> omapdrm doesn't check if the width of the framebuffer and the color
>>
>> s/width/pitch/
>>
>>>> format's bits-per-pixel match.
>>
>> s/match/are compatible/
>>
>>>> For example, using a display with a width of 1280, and a buffer
>>>> allocated with using 32 bits per pixel (i.e. 1280*4 = 5120 bytes), with
>>
>> Might be clearer to say 'i.e. byte stride of ...', and also s/with using/for/.
>
> Above you said pitch, here you say stride. They are the same thing, right?

Yeah, they're interchangeable. In theory, I think it's supposed to be
that pitch is in pixels and stride in bpp, but they're so often
interchanged that they've lost that distinction. Still, using one
consistently is always good - and since KMS uses pitch exclusively,
that might be a good one to settle on.

>> stride_bpp is very misnamed: it is the bits per pixel for that plane,
>> and not stride at all. I think the check should in fact be be (pitch %
>
> I don't know why Rob named it like that. "The bpp of the stride"? Shrug.

It's just the bpp of the pixel format; it's not at all associated with
the stride?

>> This isn't that check. At some stages, OMAP IIRC requires pitch to be
>> specified in pixels rather than bytes, so this makes sure that's
>> possible to express.
>
> Right, that's what this patch was trying to achieve.
>
> However... After thinking about this and going through some of the DISPC
> code, I think that's not a strict requirement. We do calculate all the
> configs using pixels as units, so at the moment the stride has to be an
> integer number of pixels. But the hardware actually takes the row-inc
> and pix-inc as bytes.
>
> That said, the HW supports features like rotation and whatnot, and it
> was not clear with a quick study if there are corner cases where the
> hardware also requires the stride to be an integer number of pixels.
> Also, the HW documentation only talks about pixels in this context, even
> if the final value written to the registers is in bytes. I don't know if
> that's just to make the documentation simpler, or if there's some
> reasoning to only use pixel units.

Indeed that was my impression from a quick look, but my OMAP is
extremely rusty these days, so wasn't quite sure ... :) Specifying
pixel units isn't totally unheard of, but bytes is definitely more
common.

Cheers,
Daniel
