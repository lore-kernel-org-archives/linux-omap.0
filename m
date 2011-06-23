From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH 5/8] OMAP4: DSS2: HDMI: Split the HDMI driver to DSS and IP
Date: Thu, 23 Jun 2011 11:25:18 +0530
Message-ID: <BANLkTi=5N7NiwZZm2RqCPnxNww_R4MVfhw@mail.gmail.com>
References: <1308298637-29753-1-git-send-email-mythripk@ti.com>
 <1308298637-29753-2-git-send-email-mythripk@ti.com> <1308298637-29753-3-git-send-email-mythripk@ti.com>
 <1308298637-29753-4-git-send-email-mythripk@ti.com> <1308298637-29753-5-git-send-email-mythripk@ti.com>
 <1308298637-29753-6-git-send-email-mythripk@ti.com> <B85A65D85D7EB246BE421B3FB0FBB593024D625B1D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:48788 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751582Ab1FWFzj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 01:55:39 -0400
Received: by mail-fx0-f42.google.com with SMTP id 1so1267906fxm.15
        for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 22:55:38 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D625B1D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>

Hi,

On Mon, Jun 20, 2011 at 7:18 PM, Premi, Sanjeev <premi@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of K, Mythri P
>> Sent: Friday, June 17, 2011 1:47 PM
>> To: linux-omap@vger.kernel.org; Valkeinen, Tomi
>> Cc: K, Mythri P
>> Subject: [PATCH 5/8] OMAP4: DSS2: HDMI: Split the HDMI driver
>> to DSS and IP
>>
>> Splitting HDMI IP dependent IP configuring code from HDMI DSS
>> dependent code and
>> moving to a new IP file.
>>
>> Signed-off-by: Mythri P K <mythripk@ti.com>
>> ---
>> =A0drivers/video/omap2/dss/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A01 +
>> =A0drivers/video/omap2/dss/hdmi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0751
>> -------------------
>> =A0drivers/video/omap2/dss/hdmi_ti_4xxx_ip.c =A0 =A0 =A0 =A0 =A0| =A0=
781
>> ++++++++++++++++++++
>> =A0.../video/omap2/dss/{hdmi.h =3D> hdmi_ti_4xxx_ip.h} =A0| =A0 =A09=
 +-
>> =A0include/video/hdmi_ti_4xxx_ip.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 10 +
>
> [sp] Is it okay to have 2 files by same name in two dirs?
> =A0 =A0 'include/video' and 'drivers/.../omap2/dss'.
> =A0 =A0 Compiler won't complain, but my comments is more from readabi=
lity.
> =A0 =A0 There has to be something characteristically different in the=
se
> =A0 =A0 headers - maybe this should reflect in the names as well.
>
I have seen some instances of such nomenclature , where one is generic
to be used by other drivers across and is located located in
/include/video and other in local folder restricted to that file. Do
anyone else see an issue ?

> ~sanjeev
>



--=20
Thanks and regards,
Mythri.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
