From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 4/4] dspbridge: Change LST_ELEM to list_head entirely
Date: Thu, 3 Sep 2009 12:36:35 +0300
Message-ID: <5ec8ebd50909030236y53120e47g82d3f9541c199a0b@mail.gmail.com>
References: <1251968774-25380-1-git-send-email-andy.shevchenko@gmail.com>
	 <1251968774-25380-2-git-send-email-andy.shevchenko@gmail.com>
	 <1251968774-25380-3-git-send-email-andy.shevchenko@gmail.com>
	 <1251968774-25380-4-git-send-email-andy.shevchenko@gmail.com>
	 <1251968774-25380-5-git-send-email-andy.shevchenko@gmail.com>
	 <1251969443.5060.10.camel@localhost>
	 <5ec8ebd50909030231i502c01a4i341e89e312d921d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:42863 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbZICJgg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Sep 2009 05:36:36 -0400
Received: by ewy2 with SMTP id 2so1636473ewy.17
        for <linux-omap@vger.kernel.org>; Thu, 03 Sep 2009 02:36:38 -0700 (PDT)
In-Reply-To: <5ec8ebd50909030231i502c01a4i341e89e312d921d0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dedekind1@gmail.com
Cc: linux-omap@vger.kernel.org, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On Thu, Sep 3, 2009 at 12:31 PM, Andy
Shevchenko<andy.shevchenko@gmail.com> wrote:
> On Thu, Sep 3, 2009 at 12:17 PM, Artem Bityutskiy<dedekind1@gmail.com=
> wrote:
>> On Thu, 2009-09-03 at 12:06 +0300, Andy Shevchenko wrote:
>>> @@ -590,7 +589,7 @@ DSP_STATUS CMM_GetInfo(struct CMM_OBJECT *hCmmM=
gr,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* next node. */
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pCurNode =3D (struct CMM_MNODE *)LS=
T_Next(pAltr->
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pInUseL=
istHead,
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (struct LST=
_ELEM *)pCurNode);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (struct lis=
t_head *) pCurNode);
>>
>> I do not completely agree with this change. Please do not put space
>> between the cast and the variable. The cast kind of belongs to the
>> variable, so it is nicer to have no space there.
> Partially code is written in =C2=A0way w/o spaces, partially in way w=
ith
> space. The style of whole driver is awful.
> Just for information, in our kernel:
> sh-3.2$ git grep -n 'list_head *)[^ ]' | wc
> =C2=A0 =C2=A0110 =C2=A0 =C2=A0 519 =C2=A0 =C2=A08630
> sh-3.2$ git grep -n 'list_head *) ' | wc
> =C2=A0 =C2=A0 43 =C2=A0 =C2=A0 236 =C2=A0 =C2=A03345
Oh, wrong regexp :-)

sh-3.2$ git grep -n 'list_head \*) ' | wc
     80     450    6440
sh-3.2$ git grep -n 'list_head \*)[^ ]' | wc
     28     170    2202

--=20
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
