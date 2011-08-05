From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH] OMAP: DSS2: DSI: Support non-dcs long read
Date: Thu, 4 Aug 2011 18:15:44 -0700
Message-ID: <CAMP5XgegzAJjp8QG=Emm9TnXrn_LiVqGxTnkQ2C5_SSBbUcp7Q@mail.gmail.com>
References: <1309405483-6876-1-git-send-email-arve@android.com>
	<1312459611.2143.18.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51397 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046Ab1HEBPp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Aug 2011 21:15:45 -0400
Received: by yxj19 with SMTP id 19so1187222yxj.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Aug 2011 18:15:44 -0700 (PDT)
In-Reply-To: <1312459611.2143.18.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Dima Zavin <dima@android.com>

2011/8/4 Tomi Valkeinen <tomi.valkeinen@ti.com>:
> Hi,
>
> On Wed, 2011-06-29 at 20:44 -0700, Arve Hj=F8nnev=E5g wrote:
>> Change-Id: I18168c887e1384c07dc033a1ffc57abdacb26073
>> Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
>> ---
>> =A0drivers/video/omap2/dss/dsi.c | =A0 =A07 ++++++-
>> =A01 files changed, 6 insertions(+), 1 deletions(-)
>
> This feels somehow partial... Why do you want to read generic packets=
 if
> there are no functions to send generic packets?
>

The chip responds with a generic packet when reading from some
registers. This is a simple fix while adding support for sending
generic packets would probably require an api change.

> And always write a patch description.
>
> =A0Tomi
>
>>
>> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss=
/dsi.c
>> index c16b933..6975645 100644
>> --- a/drivers/video/omap2/dss/dsi.c
>> +++ b/drivers/video/omap2/dss/dsi.c
>> @@ -206,6 +206,7 @@ struct dsi_reg { u16 idx; };
>> =A0#define DSI_DT_DCS_LONG_WRITE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x39
>>
>> =A0#define DSI_DT_RX_ACK_WITH_ERR =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x02
>> +#define DSI_DT_RX_LONG_READ =A0 =A0 =A0 =A0 =A00x1a
>> =A0#define DSI_DT_RX_DCS_LONG_READ =A0 =A0 =A0 =A0 =A0 =A0 =A00x1c
>> =A0#define DSI_DT_RX_SHORT_READ_1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x21
>> =A0#define DSI_DT_RX_SHORT_READ_2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x22
>> @@ -2943,6 +2944,10 @@ static u16 dsi_vc_flush_receive_data(struct p=
latform_device *dsidev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (dt =3D=3D DSI_DT_RX_SHORT_REA=
D_2) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("\tDCS short resp=
onse, 2 byte: %#x\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 FLD_GET(val, 23, 8));
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (dt =3D=3D DSI_DT_RX_LONG_READ) =
{
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("\tlong response, l=
en %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 FLD_GET(val, 23, 8));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dsi_vc_flush_long_data(dsi=
dev, channel);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (dt =3D=3D DSI_DT_RX_DCS_LONG_=
READ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("\tDCS long respo=
nse, len %d\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 FLD_GET(val, 23, 8));
>> @@ -3287,7 +3292,7 @@ int dsi_vc_dcs_read(struct omap_dss_device *ds=
sdev, int channel, u8 dcs_cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 buf[1] =3D (data >> 8) & 0xff;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 2;
>> - =A0 =A0 } else if (dt =3D=3D DSI_DT_RX_DCS_LONG_READ) {
>> + =A0 =A0 } else if (dt =3D=3D DSI_DT_RX_DCS_LONG_READ || dt =3D=3D =
DSI_DT_RX_LONG_READ) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int w;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int len =3D FLD_GET(val, 23, 8);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dsi->debug_read)
>
>
>



--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
