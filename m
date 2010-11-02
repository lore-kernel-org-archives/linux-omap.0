From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 1/3] OMAP: DSS2: Add dummy panel display driver
Date: Tue, 2 Nov 2010 15:13:37 -0400
Message-ID: <AANLkTik=yXT8jP=-_Yqhr4Z6VEcPSz-yrQ-UV5cnhn-k@mail.gmail.com>
References: <1288714390-6159-1-git-send-email-bryan.wu@canonical.com>
	<1288714390-6159-2-git-send-email-bryan.wu@canonical.com>
	<AANLkTikd-hMcFkanO4SUceJuvrMoLxxcB4Fw3HvU_8-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61420 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab0KBTNj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 15:13:39 -0400
Received: by gwj21 with SMTP id 21so4340695gwj.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Nov 2010 12:13:38 -0700 (PDT)
In-Reply-To: <AANLkTikd-hMcFkanO4SUceJuvrMoLxxcB4Fw3HvU_8-w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Nov 2, 2010 at 1:21 PM, Grazvydas Ignotas <notasas@gmail.com> w=
rote:
> On Tue, Nov 2, 2010 at 6:13 PM, Bryan Wu <bryan.wu@canonical.com> wro=
te:
>> Dummy panel driver includes the driver and 4 similar panel configura=
tions. It
>> will match the panel name which is passed from platform data and set=
up the
>> right configurations.
>>
>> With dummy panel driver, we can remove those 4 duplicated panel disp=
lay
>> drivers. In the future, it is simple for us just add new panel confi=
guration
>> date in panel-dummy.h to support new display panel.
>>
>> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
>
> <snip>
>
>> diff --git a/drivers/video/omap2/displays/panel-dummy.h b/drivers/vi=
deo/omap2/displays/panel-dummy.h
>> new file mode 100644
>> index 0000000..ac2b7a2
>> --- /dev/null
>> +++ b/drivers/video/omap2/displays/panel-dummy.h
>
> There is no benefit of having this header, just add all data directly
> in .c file.
>
> <snip>
>
>> + =A0 =A0 =A0 /* Sharp LQ043T1DG01 */
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { =A0 =A0 =A0 .x_res =A0 =A0 =A0 =A0 =A0=
=3D 480,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .y_res =A0 =A0 =A0 =A0=
 =A0=3D 272,
>
> missing newline after {
>

Thanks, I will take these 2 comments.

--=20
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer =A0 =A0+86.138-1617-6545 Mobile
Ubuntu Kernel Team
Canonical Ltd. =A0 =A0 =A0www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
