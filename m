From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE: Various compile warning fixes
Date: Thu, 21 Jan 2010 18:01:13 +0200
Message-ID: <5ec8ebd51001210801h3eb8c337l2cd0d4e501ed724f@mail.gmail.com>
References: <e237d5197c6847e669ff873a432a387b5c4dd2f6.1264080558.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:53858 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab0AUQBU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 11:01:20 -0500
Received: by ewy19 with SMTP id 19so135642ewy.1
        for <linux-omap@vger.kernel.org>; Thu, 21 Jan 2010 08:01:18 -0800 (PST)
In-Reply-To: <e237d5197c6847e669ff873a432a387b5c4dd2f6.1264080558.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap@vger.kernel.org, omar.ramirez@ti.com, nm@ti.com, deepak.chitriki@ti.com, mika.kukkonen@nokia.com

On Thu, Jan 21, 2010 at 3:40 PM, Ameya Palande <ameya.palande@nokia.com=
> wrote:
> --- a/drivers/dsp/bridge/wmd/io_sm.c
> +++ b/drivers/dsp/bridge/wmd/io_sm.c
> @@ -1210,7 +1210,7 @@ static void InputChnl(struct IO_MGR *pIOMgr, st=
ruct CHNL_OBJECT *pChnl,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0pChnlMgr->uWordSize;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0chnlId =3D IO_GetValue(pIOMgr->hWmdContext=
, struct SHM, sm, inputId);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dwArg =3D IO_GetLong(pIOMgr->hWmdContext, =
struct SHM, sm, arg);
> - =C2=A0 =C2=A0 =C2=A0 if (!(chnlId >=3D 0) || !(chnlId < CHNL_MAXCHA=
NNELS)) {
> + =C2=A0 =C2=A0 =C2=A0 if (chnlId >=3D CHNL_MAXCHANNELS) {
Could chnlld be less than zero? Anyway better to test:
(chnlId >=3D CHNL_MAXCHANNELS || chnlld < 0)

--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
