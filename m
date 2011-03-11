From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH v5 00/10] OMAP4 : DSS2 : HDMI support on OMAP4
Date: Fri, 11 Mar 2011 13:54:55 +0530
Message-ID: <AANLkTik7kaMDMrL_AweAY0dCo7wxaaHkQxTcmMfVB-=f@mail.gmail.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com> <1299769580.2017.235.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:47170 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751953Ab1CKIZR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 03:25:17 -0500
Received: by mail-vw0-f45.google.com with SMTP id 17so418235vws.4
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 00:25:15 -0800 (PST)
In-Reply-To: <1299769580.2017.235.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

On Thu, Mar 10, 2011 at 8:36 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> Hi Mythri,
>
> On Thu, 2011-03-10 at 04:44 -0600, K, Mythri P wrote:
>> Adding HDMI support on OMAP4.
>>
>> HDMI is a driver that is similar to the VENC or the DSI driver to su=
pport
>> HDMI/DVI sink device.
>>
>> The current design adheres to the DSS2 architecture.
>
> I was testing this on Blaze, with VENC enabled in Kconfig and a small
> hack in venc.c which skips registering the venc device on omap4.
>
> I haven't seen these earlier, so it may just be I've been lucky, or
> enabling VENC affected this.
>
> I've seen this twice when loading the modules:
>
> [ =A0 23.007690] omapdss HDMI: no valid timing found , falling back t=
o VGA
> [ =A0 23.040161] omapdss HDMI error: PLL GO bit not set
> [ =A0 23.045196] omapdss HDMI error: failed to power on device
> [ =A0 23.050964] omapdss error: failed to power on
> [ =A0 23.055572] omapfb omapfb: Failed to enable display 'hdmi'
> [ =A0 23.066162] omapfb omapfb: failed to setup omapfb
> [ =A0 23.071166] omapfb: probe of omapfb failed with error -5
>
> And I've seen this once when unloading modules:
>
> [ =A0126.473419] omapdss DISPC error: SYNC_LOST_DIGIT, disabling TV
> [ =A0126.569244] omapdss DISPC error: timeout waiting for EVSYNC
> [ =A0126.670776] omapdss DISPC error: timeout waiting for EVSYNC
> [ =A0126.773376] omapdss HDMI: no valid timing found , falling back t=
o VGA
> [ =A0126.881896] omapdss DISPC error: timeout waiting for EVSYNC
> [ =A0126.983367] omapdss DISPC error: timeout waiting for EVSYNC
> rmmod: can't unload 'omapdss': Resource temporarily unavailable
>
> This looks a bit bad, as it sounds to me that when an error happened,
> some code path returned too early and the omapdss driver could not
> unload.
>
I tried loading and unloading around 10-15 times and did not hit the pr=
oblem,
Can you please paste the entire log ? Did you see this only when VENC w=
as
enabled?

> There is this code in dss.c:
>
> #ifdef CONFIG_OMAP2_DSS_VENC
> =A0 =A0 =A0 =A0REG_FLD_MOD(DSS_CONTROL, 1, 4, 4); =A0 =A0 =A0/* venc =
dac demen */
> =A0 =A0 =A0 =A0REG_FLD_MOD(DSS_CONTROL, 1, 3, 3); =A0 =A0 =A0/* venc =
clock 4x enable */
> =A0 =A0 =A0 =A0REG_FLD_MOD(DSS_CONTROL, 0, 2, 2); =A0 =A0 =A0/* venc =
clock mode =3D normal */
> #endif
>
Regarding this piece of code , although it appears that is should not a=
ffect ,
I think we should move this out of dss_init , if any such change is nee=
ded
we should do that on VENC enable dont you think ?

> They don't sound like they would affect HDMI, but that was the only
> difference I found (between VENC enabled and disabled) with a quick
> search.
>
> =A0Tomi
>
Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
