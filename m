From: "Sapiens, Rene" <rene.sapiens@ti.com>
Subject: Re: DSP Bridge video decode of above VGA videos
Date: Mon, 22 Nov 2010 10:56:43 -0600
Message-ID: <AANLkTi=71zFhuBh3MArYjSEvJ+YXciF_9d2cn+5ojTb6@mail.gmail.com>
References: <AANLkTim2PQ9kAvSi12987gAykMAuPg7f3XM3zQNo5Tip@mail.gmail.com>
	<AANLkTinCT-zQaGyLfS-NZU9Pue+2hmrLDckHYKqD_u8m@mail.gmail.com>
	<AANLkTimhKaS4y+k0t_x39aw8LvO-tNUH-=x3V9jk7BsC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:37923 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752179Ab0KVQ4p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 11:56:45 -0500
Received: by mail-wy0-f176.google.com with SMTP id 19so7701938wyf.35
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 08:56:44 -0800 (PST)
In-Reply-To: <AANLkTimhKaS4y+k0t_x39aw8LvO-tNUH-=x3V9jk7BsC@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: James Adams <james.r.adams@gmail.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, linux-omap@vger.kernel.org

Hi James,

On Mon, Nov 22, 2010 at 9:26 AM, James Adams <james.r.adams@gmail.com> =
wrote:
> D/TI_Video_Decoder( =A0934): VIDDEC_InitDSP_H264Dec():6573 After Roun=
ding:
> nFrameW
> idth =3D 1280, nFrameHeight =3D 544
> drivers/dsp/bridge/services/sync.c, line 357: Assertion (0) failed.
> drivers/dsp/bridge/services/sync.c, line 357: Assertion (0) failed.

Does the version of your sync.c file points to sync_entercs() and the
the assert failed for "in_interrupt()" for the line 357?

Do your dspbridge version uses the WDT implementation?

> D/TI_Video_Decoder( =A0934): VIDDEC_InitDSP_H264Dec():6619
> LCML_InitMMCodec Failed
> !...80001009
> D/TI_Video_Decoder( =A0934): VIDDEC_HandleCommand():1950 LCML Error 1
> D/TI_Video_Decoder( =A0934): OMX_VidDec_Thread():165 Error in Select

Regards,
Rene Sapiens
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
