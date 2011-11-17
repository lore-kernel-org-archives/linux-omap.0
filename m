From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: arm pmu interrupt on pandaboard
Date: Thu, 17 Nov 2011 15:53:05 +0800
Message-ID: <CACVXFVOirXk63bxNbkAAoVg2syQAKkXL_zL4ONbkh9uZfaw55A@mail.gmail.com>
References: <1321513474.40681.YahooMailNeo@web125720.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41185 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab1KQHxH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Nov 2011 02:53:07 -0500
Received: by wyh11 with SMTP id 11so1597710wyh.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Nov 2011 23:53:06 -0800 (PST)
In-Reply-To: <1321513474.40681.YahooMailNeo@web125720.mail.ne1.yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fan Ye <mouseyefan@yahoo.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org

Hi,

On Thu, Nov 17, 2011 at 3:04 PM, Fan Ye <mouseyefan@yahoo.com> wrote:
> Hi Tom,
> I am currently working on PMU interrupt on Pandaboard.I use the patch=
 sent
> by you:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-March/0452=
83.html
>
> But it will fail to boot the kernel. So I also apply the following pa=
tch:
> http://lists.linaro.org/pipermail/linaro-dev/2011-April/004019.html
>
> Now the kernel can boot up successfully. But I find that PMU interrup=
t is
> not=A0triggered=A0even if the PMU overflow happens and the interrupt =
is enabled
> in the=A0PMINTENSET register.

I have posted some new code about the issue, see

       http://marc.info/?t=3D131946776600001&r=3D1&w=3D2

I think this one can make your pmu work, :-)

> The code base I am using is
> http://git.linaro.org/gitweb?p=3Dkernel/linux-linaro-2.6.39.git;a=3Ds=
ummary
> Thank you very much.
> Ye Fan
>

thanks,
--=20
Ming Lei
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
