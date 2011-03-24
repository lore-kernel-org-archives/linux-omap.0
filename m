From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [RFC PATCH] HDMI:Support for EDID parsing in kernel.
Date: Thu, 24 Mar 2011 15:21:39 +0530
Message-ID: <AANLkTinYHzCgXe9yw1rGHZA0uM=-VrY+Mktpn-HvfRyR@mail.gmail.com>
References: <1300815176-21206-1-git-send-email-mythripk@ti.com>
 <AANLkTim61Xdo6ED7mr_SvpLuotso89RdR6Qaz-GCXOmJ@mail.gmail.com>
 <AANLkTinMUCbaEVjwZsHG9BxFVjx0YxS=Sw+3gViDJXhg@mail.gmail.com> <20110323081820.5b37d169@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:57271 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751811Ab1CXJwC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 05:52:02 -0400
In-Reply-To: <20110323081820.5b37d169@jbarnes-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Dave Airlie <airlied@gmail.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, linux-media@vger.kernel.org

Hi Jesse,

On Wed, Mar 23, 2011 at 8:48 PM, Jesse Barnes <jbarnes@virtuousgeek.org=
> wrote:
> On Wed, 23 Mar 2011 18:58:27 +0530
> "K, Mythri P" <mythripk@ti.com> wrote:
>
>> Hi Dave,
>>
>> On Wed, Mar 23, 2011 at 6:16 AM, Dave Airlie <airlied@gmail.com> wro=
te:
>> > On Wed, Mar 23, 2011 at 3:32 AM, Mythri P K <mythripk@ti.com> wrot=
e:
>> >> Adding support for common EDID parsing in kernel.
>> >>
>> >> EDID - Extended display identification data is a data structure p=
rovided by
>> >> a digital display to describe its capabilities to a video source,=
 This a
>> >> standard supported by CEA and VESA.
>> >>
>> >> There are several custom implementations for parsing EDID in kern=
el, some
>> >> of them are present in fbmon.c, drm_edid.c, sh_mobile_hdmi.c, Ide=
ally
>> >> parsing of EDID should be done in a library, which is agnostic of=
 the
>> >> framework (V4l2, DRM, FB) =A0which is using the functionality, ju=
st based on
>> >> the raw EDID pointer with size/segment information.
>> >>
>> >> With other RFC's such as the one below, which tries to standardiz=
e HDMI API's
>> >> It would be better to have a common EDID code in one place.It als=
o helps to
>> >> provide better interoperability with variety of TV/Monitor may be=
 even by
>> >> listing out quirks which might get missed with several custom imp=
lementation
>> >> of EDID.
>> >> http://permalink.gmane.org/gmane.linux.drivers.video-input-infras=
tructure/30401
>> >>
>> >> This patch tries to add functions to parse some portion EDID (det=
ailed timing,
>> >> monitor limits, AV delay information, deep color mode support, Au=
dio and VSDB)
>> >> If we can align on this library approach i can enhance this libra=
ry to parse
>> >> other blocks and probably we could also add quirks from other imp=
lementation
>> >> as well.
>> >>
>> >
>> > If you want to take this approach, you need to start from the DRM =
EDID parser,
>> > its the most well tested and I can guarantee its been plugged into=
 more monitors
>> > than any of the others. There is just no way we would move the DRM=
 parser to a
>> > library one that isn't derived from it + enhancements, as we'd thr=
ow away the
>> > years of testing and the regression count would be way too high.
>> >
>> I had a look at the DRM EDID code, but for quirks it looks pretty mu=
ch the same.
>> yes i could take quirks and other DRM tested code and enhance, but
>> still the code has to do away with struct drm_display_mode
>> which is very much custom to DRM.
>
> If that's the only issue you have, we could easily rename that
> structure or add conversion funcs to a smaller structure if that's wh=
at
> you need.
>
> Dave's point is that we can't ditch the existing code without
> introducing a lot of risk; it would be better to start a library-ized
> EDID codebase from the most complete one we have already, i.e. the DR=
M
> EDID code.
>
This sounds good. If we can remove the DRM dependent portion to have a
library-ized EDID code,
That would be perfect. The main Intention to have a library is,
Instead of having several different Implementation in kernel, all
doing the same EDID parsing , if we could have one single
implementation , it would help in better testing and interoperability.

> Do you really think the differences between your code and the existin=
g
> DRM code are irreconcilable?
>
On the contrary if there is a library-ized  EDID parsing using the
drm_edid, and there is any delta / fields( Parsing the video block in
CEA extension for Short Video Descriptor, Vendor block for AV delay
/Deep color information etc) that are parsed with the RFC i posted i
would be happy to add.

Thanks and regards,
Mythri.
> --
> Jesse Barnes, Intel Open Source Technology Center
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
