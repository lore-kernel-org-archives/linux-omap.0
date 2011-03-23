From: Dave Airlie <airlied@gmail.com>
Subject: Re: [RFC PATCH] HDMI:Support for EDID parsing in kernel.
Date: Wed, 23 Mar 2011 10:46:03 +1000
Message-ID: <AANLkTim61Xdo6ED7mr_SvpLuotso89RdR6Qaz-GCXOmJ@mail.gmail.com>
References: <1300815176-21206-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54346 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516Ab1CWAqH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Mar 2011 20:46:07 -0400
In-Reply-To: <1300815176-21206-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mythri P K <mythripk@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>

On Wed, Mar 23, 2011 at 3:32 AM, Mythri P K <mythripk@ti.com> wrote:
> Adding support for common EDID parsing in kernel.
>
> EDID - Extended display identification data is a data structure provi=
ded by
> a digital display to describe its capabilities to a video source, Thi=
s a
> standard supported by CEA and VESA.
>
> There are several custom implementations for parsing EDID in kernel, =
some
> of them are present in fbmon.c, drm_edid.c, sh_mobile_hdmi.c, Ideally
> parsing of EDID should be done in a library, which is agnostic of the
> framework (V4l2, DRM, FB) =A0which is using the functionality, just b=
ased on
> the raw EDID pointer with size/segment information.
>
> With other RFC's such as the one below, which tries to standardize HD=
MI API's
> It would be better to have a common EDID code in one place.It also he=
lps to
> provide better interoperability with variety of TV/Monitor may be eve=
n by
> listing out quirks which might get missed with several custom impleme=
ntation
> of EDID.
> http://permalink.gmane.org/gmane.linux.drivers.video-input-infrastruc=
ture/30401
>
> This patch tries to add functions to parse some portion EDID (detaile=
d timing,
> monitor limits, AV delay information, deep color mode support, Audio =
and VSDB)
> If we can align on this library approach i can enhance this library t=
o parse
> other blocks and probably we could also add quirks from other impleme=
ntation
> as well.
>

If you want to take this approach, you need to start from the DRM EDID =
parser,
its the most well tested and I can guarantee its been plugged into more=
 monitors
than any of the others. There is just no way we would move the DRM pars=
er to a
library one that isn't derived from it + enhancements, as we'd throw aw=
ay the
years of testing and the regression count would be way too high.

Dave.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
