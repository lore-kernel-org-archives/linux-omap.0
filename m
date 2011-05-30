From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCHv2 2/2] OMAP: add omap_device_reset()
Date: Mon, 30 May 2011 10:49:16 +0200
Message-ID: <4DE35A0C.6040301@ti.com>
References: <1306481908-7386-1-git-send-email-tomi.valkeinen@ti.com>  <1306481908-7386-3-git-send-email-tomi.valkeinen@ti.com>  <4DDF9B5D.7060408@ti.com> <1306500367.1905.18.camel@deskari>  <4DDFB8AF.1080800@ti.com> <1306514427.1905.27.camel@deskari> <alpine.DEB.2.00.1105292006330.8973@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54232 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752552Ab1E3ItX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 May 2011 04:49:23 -0400
In-Reply-To: <alpine.DEB.2.00.1105292006330.8973@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 5/30/2011 4:15 AM, Paul Walmsley wrote:
> On Fri, 27 May 2011, Tomi Valkeinen wrote:
>
>> However, VENC doesn't use the standard syscontrol mechanism, so that
>> cannot be done via omap_device interface anyway.
>
> struct omap_hwmod_class has a .reset function pointer for this purpose.
> It's already been necessary to deal with the I2C IP block:
>
>     https://patchwork.kernel.org/patch/804072/
>
> If all that's needed are the steps in 4430 TRM Rev. T Section 10.6.5.1.2.3
> "Subsequence--Video Encoder Software Reset", then it should be possible to
> handle this internal reset with hwmod code.

Mmm, but in that case, if this is purely handled inside the IP, it is up 
to the driver to manage that.

hwmod should not manage more than the SYSCONFIG ocpreset because this is 
part of the PRCM/OCP wrapper and not really the IP.

In the case of the VENC, the reset is part of the regular init sequence, 
so the driver will take care of it.

Don't you think so?

Regards,
Benoit
