From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: DISPC: Enable predecimation
Date: Fri, 16 Mar 2012 17:29:54 +0530
Message-ID: <CAF0AtAuJrw7RzArdYnmDc-vG6STL0ce8GRbM+M3Xbo9nf_Rktg@mail.gmail.com>
References: <1331812108-9776-1-git-send-email-cmahapatra@ti.com>
	<20120315222811.GN17132@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:57387 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750791Ab2CPMHZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Mar 2012 08:07:25 -0400
Received: by mail-lpp01m010-f43.google.com with SMTP id r15so3808206lag.30
        for <linux-omap@vger.kernel.org>; Fri, 16 Mar 2012 05:07:24 -0700 (PDT)
In-Reply-To: <20120315222811.GN17132@sci.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: linux-fbdev@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>

On Fri, Mar 16, 2012 at 3:58 AM, Ville Syrj=E4l=E4 <syrjala@sci.fi> wro=
te:
> On Thu, Mar 15, 2012 at 05:18:28PM +0530, Chandrabhanu Mahapatra wrot=
e:
>> In OMAP3 and OMAP4, the DISPC Scaler can downscale an image up to 4 =
times, and
>> up to 2 times in OMAP2. However, with predecimation, the image can b=
e reduced
>> to 16 times by fetching only the necessary pixels in memory. Then th=
is
>> predecimated image can be downscaled further by the DISPC scaler.
>
> Now, where does that number 16 come from? IIRC the hardware can skip
> basically any number of pixels/rows. I certainly didn't add any such
> limit to the code in the harmattan kernel, and distinctly remember
> being able to downscale the N9/N950 UI even down to 1 pixel size :)
>

Yes, you are right. I have done vertical predecimation to a size of 2
lines beyond which it failed.
This limitation of 16 is actually on horizontal predecimation as was
mentioned by the hardware guys. Let me explain what we once discussed
with Archit.
The pipeline is configured to use a burst of size 8 * 128 bits and DSS
uses 8 L3 clock cycles to fetch it. So, burst consists of 8 mini
bursts of 16 bytes each.

Now, there are two possible situations:
1) Each mini burst has some valid pixels, so all 16 bytes are fetched
by DISPC DMA and the uneeded pixels are discarded. This case can be
shown as
    pixelinc -1 + bpp =3D< 16

2) Some mini bursts don't have any valid pixels, so these will not be
fecthed by the DISPC DMA. So, L3 interconnect may handover the bus
over so some other initiator and inturn delay the fecthing of pixels
leading to UNDERFLOWS. This case can be shown as
   pixellinc -1 + bpp > 16.
To avoid these UNDERFLOWS we better have a limitation of 16 on
horizontal predecimation. Anyways, 16 times predecimation followed by
2/4 times downscaling (may it be horizontal or vertical) by DISPC
SCALER is more than enough for any usecase required.

>> Based on the downscaling required, a prior calculation of predecimat=
ion values
>> for width and height of an image is done. Since, Predecimation reduc=
es quality
>> of an image higher priorty is given to DISPC Scaler for downscaling.
>>
>> This code was successfully tested on OMAP2, OMAP3 and OMAP4. Horizon=
tal and
>> vertical predecimation worked fine except for some synclost errors d=
ue to
>> undocumented errata in OMAP3 which are fixed later and skewed images=
 were seen
>> on OMAP2 and OMAP3 during horizontal predecimation which will be add=
ressed in
>> the future patches.
>
> All the rotation offset calculations still look suspiciously differen=
t
> to what is in the harmattan kernel. I remember that the original code
> was quite broken, and I fixed a lot of things when I was implementing
> pre-decimation and some rotation stuff for the N9/N950. Too bad I nev=
er
> managed to push that stuff upstream...
>

A number of variables are different in mainline kernel from that used
in your code. I did fix some of the rotation code to get the best
results. I will consider your suggestions for further improvement.

> --
> Ville Syrj=E4l=E4
> syrjala@sci.fi
> http://www.sci.fi/~syrjala/



--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
