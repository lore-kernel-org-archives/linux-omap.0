From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: DSP Bridge video decode of above VGA videos
Date: Mon, 22 Nov 2010 07:23:04 -0600
Message-ID: <AANLkTinCT-zQaGyLfS-NZU9Pue+2hmrLDckHYKqD_u8m@mail.gmail.com>
References: <AANLkTim2PQ9kAvSi12987gAykMAuPg7f3XM3zQNo5Tip@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:42470 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754583Ab0KVNXH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 08:23:07 -0500
Received: by mail-qw0-f48.google.com with SMTP id 7so36492qwb.21
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 05:23:04 -0800 (PST)
In-Reply-To: <AANLkTim2PQ9kAvSi12987gAykMAuPg7f3XM3zQNo5Tip@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: James Adams <james.r.adams@gmail.com>
Cc: linux-omap@vger.kernel.org

James,

On Mon, Nov 22, 2010 at 7:14 AM, James Adams <james.r.adams@gmail.com> =
wrote:
> Hi All,
>
> We are running Android on a custom Gumstix Overo Water platform. We
> have ported the 25.12 Zoom2 release to do this.
>
> It is almost working except that when trying to decode H264 videos
> with resolution above 640x480 (either horizontally or vertically, e.g=
=2E
> 640*544) the DSP module appears to crash. Decoding anything at VGA or
> below is working fine.
>
> DSP bridge is configured with 0x600000 memory (but larger doesn't see=
m
> to help). =A0Is anyone aware of other configuration options that we
> should be checking (e.g. in DSP bridge, OMAP video drivers, or
> android?) that might cause large video decodes to fail?

Can you please post any error/failure logs ?


Thank you,
Best regards,
Hari Kanigeri
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
