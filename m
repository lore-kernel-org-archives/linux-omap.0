From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] OMAPDSS: VENC: allow switching venc type at runtime
Date: Mon, 23 Apr 2012 18:32:54 +0300
Message-ID: <CANOLnOPcuiD7+rqafeSTZc3GB0_C10viUZe0+XbJQ0be82qDtQ@mail.gmail.com>
References: <1332978312-11959-1-git-send-email-notasas@gmail.com>
	<1335183802.30659.17.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41475 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab2DWPcz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 11:32:55 -0400
In-Reply-To: <1335183802.30659.17.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

On Mon, Apr 23, 2012 at 3:23 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Thu, 2012-03-29 at 02:45 +0300, Grazvydas Ignotas wrote:
>> VENC type (composite/svideo) doesn't have to be fixed by board wirin=
g,
>> it is possible to provide both connectors, which is what pandora doe=
s.
>> Having to recompile the kernel for users who have TV connector types
>> that's don't match default board setting is very inconvenient, espec=
ially
>> for users of a consumer device, so add support for switching VENC ty=
pe
>> at runtime over a new sysfs file venc_type.
>>
>> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
>> ---
>> =C2=A0Documentation/arm/OMAP/DSS =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
>> =C2=A0drivers/video/omap2/dss/venc.c | =C2=A0 55 +++++++++++++++++++=
++++++++++++++++++++-
>> =C2=A02 files changed, 55 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/arm/OMAP/DSS b/Documentation/arm/OMAP/DSS
>> index 888ae7b..18e2214 100644
>> --- a/Documentation/arm/OMAP/DSS
>> +++ b/Documentation/arm/OMAP/DSS
>> @@ -156,6 +156,7 @@ timings =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Displ=
ay timings (pixclock,xres/hfp/hbp/hsw,yres/vfp/vbp/vsw)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "pal" and "ntsc"
>> =C2=A0panel_name
>> =C2=A0tear_elim =C2=A0 =C2=A0Tearing elimination 0=3Doff, 1=3Don
>> +venc_type =C2=A0 =C2=A0Output type (video encoder only): "composite=
" or "svideo"
>
> I think we could have a better name here. "venc" name is quite obscur=
e
> on the user level. And it's not even quite correct, venc stays the sa=
me,
> it's just the output that is changed. "output_type"? "connector"?
> "connector_type"?

I'll go for output_type then, connector* associates with fixed hardware=
 to me.
I'll take care of other comments too.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
