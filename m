From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [RFC PATCH] HDMI:Support for EDID parsing in kernel.
Date: Wed, 23 Mar 2011 18:58:27 +0530
Message-ID: <AANLkTinMUCbaEVjwZsHG9BxFVjx0YxS=Sw+3gViDJXhg@mail.gmail.com>
References: <1300815176-21206-1-git-send-email-mythripk@ti.com> <AANLkTim61Xdo6ED7mr_SvpLuotso89RdR6Qaz-GCXOmJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:41440 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932910Ab1CWN2y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 09:28:54 -0400
In-Reply-To: <AANLkTim61Xdo6ED7mr_SvpLuotso89RdR6Qaz-GCXOmJ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>

Hi Dave,

On Wed, Mar 23, 2011 at 6:16 AM, Dave Airlie <airlied@gmail.com> wrote:
> On Wed, Mar 23, 2011 at 3:32 AM, Mythri P K <mythripk@ti.com> wrote:
>> Adding support for common EDID parsing in kernel.
>>
>> EDID - Extended display identification data is a data structure prov=
ided by
>> a digital display to describe its capabilities to a video source, Th=
is a
>> standard supported by CEA and VESA.
>>
>> There are several custom implementations for parsing EDID in kernel,=
 some
>> of them are present in fbmon.c, drm_edid.c, sh_mobile_hdmi.c, Ideall=
y
>> parsing of EDID should be done in a library, which is agnostic of th=
e
>> framework (V4l2, DRM, FB) =A0which is using the functionality, just =
based on
>> the raw EDID pointer with size/segment information.
>>
>> With other RFC's such as the one below, which tries to standardize H=
DMI API's
>> It would be better to have a common EDID code in one place.It also h=
elps to
>> provide better interoperability with variety of TV/Monitor may be ev=
en by
>> listing out quirks which might get missed with several custom implem=
entation
>> of EDID.
>> http://permalink.gmane.org/gmane.linux.drivers.video-input-infrastru=
cture/30401
>>
>> This patch tries to add functions to parse some portion EDID (detail=
ed timing,
>> monitor limits, AV delay information, deep color mode support, Audio=
 and VSDB)
>> If we can align on this library approach i can enhance this library =
to parse
>> other blocks and probably we could also add quirks from other implem=
entation
>> as well.
>>
>
> If you want to take this approach, you need to start from the DRM EDI=
D parser,
> its the most well tested and I can guarantee its been plugged into mo=
re monitors
> than any of the others. There is just no way we would move the DRM pa=
rser to a
> library one that isn't derived from it + enhancements, as we'd throw =
away the
> years of testing and the regression count would be way too high.
>
I had a look at the DRM EDID code, but for quirks it looks pretty much =
the same.
yes i could take quirks and other DRM tested code and enhance, but
still the code has to do away with struct drm_display_mode
which is very much custom to DRM.

> Dave.
>

Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
