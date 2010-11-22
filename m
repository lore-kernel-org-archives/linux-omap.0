From: James Adams <james.r.adams@gmail.com>
Subject: Re: DSP Bridge video decode of above VGA videos
Date: Mon, 22 Nov 2010 17:12:02 +0000
Message-ID: <AANLkTinkMPb4Htv4GN8--PZP0UdkWuyXiLYvRC3QasWD@mail.gmail.com>
References: <AANLkTim2PQ9kAvSi12987gAykMAuPg7f3XM3zQNo5Tip@mail.gmail.com>
	<AANLkTinCT-zQaGyLfS-NZU9Pue+2hmrLDckHYKqD_u8m@mail.gmail.com>
	<AANLkTimhKaS4y+k0t_x39aw8LvO-tNUH-=x3V9jk7BsC@mail.gmail.com>
	<AANLkTi=71zFhuBh3MArYjSEvJ+YXciF_9d2cn+5ojTb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:57265 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336Ab0KVRME convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 12:12:04 -0500
Received: by pvg16 with SMTP id 16so2534pvg.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 09:12:04 -0800 (PST)
In-Reply-To: <AANLkTi=71zFhuBh3MArYjSEvJ+YXciF_9d2cn+5ojTb6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sapiens, Rene" <rene.sapiens@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, linux-omap@vger.kernel.org

Hi Rene,

We have got the watchdog timer enabled at the moment (interval 5 second=
s).
The code does indeed point to the line as you say.
I tried using dump_stack and it was getting triggered by an interrupt
calling handle_hibernation_fromDSP which then called functions
eventually triggering the SYNC_entercs (via DEV_getfirst if I remember
right)
I certainly don't understand why this should happen, but it seems to
happen quite a lot (probably every 5 seconds...) and the lower
resolution videos didn't seem to mind so I have been ignoring it.

Is it a bad idea to use WDT?

Thanks,

James

On Mon, Nov 22, 2010 at 4:56 PM, Sapiens, Rene <rene.sapiens@ti.com> wr=
ote:
> Hi James,
>
> On Mon, Nov 22, 2010 at 9:26 AM, James Adams <james.r.adams@gmail.com=
> wrote:
>> D/TI_Video_Decoder( =A0934): VIDDEC_InitDSP_H264Dec():6573 After Rou=
nding:
>> nFrameW
>> idth =3D 1280, nFrameHeight =3D 544
>> drivers/dsp/bridge/services/sync.c, line 357: Assertion (0) failed.
>> drivers/dsp/bridge/services/sync.c, line 357: Assertion (0) failed.
>
> Does the version of your sync.c file points to sync_entercs() and the
> the assert failed for "in_interrupt()" for the line 357?
>
> Do your dspbridge version uses the WDT implementation?
>
>> D/TI_Video_Decoder( =A0934): VIDDEC_InitDSP_H264Dec():6619
>> LCML_InitMMCodec Failed
>> !...80001009
>> D/TI_Video_Decoder( =A0934): VIDDEC_HandleCommand():1950 LCML Error =
1
>> D/TI_Video_Decoder( =A0934): OMX_VidDec_Thread():165 Error in Select
>
> Regards,
> Rene Sapiens
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
