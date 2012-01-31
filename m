From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 07/21] OMAP3+: PM: SR/Class3: disable errorgen before
 disable VP
Date: Tue, 31 Jan 2012 14:39:48 +0100
Message-ID: <CAORVsuWrO49aUi7iab=qzxPOjaxkOwFa6bTtdRedK+pX-59t8A@mail.gmail.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
	<1327504583-13408-8-git-send-email-j-pihet@ti.com>
	<4F213860.9050600@ru.mvista.com>
	<CAORVsuUNM8bpwyjbG2GcwfiUEf7A54ODC4tfhZNinUhQTE3g5w@mail.gmail.com>
	<4F27D264.9050203@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57412 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243Ab2AaNjt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 08:39:49 -0500
Received: by vbjk17 with SMTP id k17so129387vbj.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 05:39:48 -0800 (PST)
In-Reply-To: <4F27D264.9050203@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Sergei,

On Tue, Jan 31, 2012 at 12:37 PM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
>
>
> On 31-01-2012 14:06, Jean Pihet wrote:
>
>> ...
>
>
>>>> +int sr_disable_errgen(struct voltagedomain *voltdm)
>>>> +{
>>>> + =A0 =A0 =A0 u32 errconfig_offs, vpboundint_en;
>>>> + =A0 =A0 =A0 u32 vpboundint_st;
>>>> + =A0 =A0 =A0 struct omap_sr *sr =3D _sr_lookup(voltdm);
>>>> +
>>>> + =A0 =A0 =A0 if (IS_ERR(sr)) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: omap_sr struct for s=
r_%s not found\n",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->na=
me);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>>
>>>
>>>
>>> =A0 Not PTR_ERR(sr)?
>
>
>> _sr_lookup returns a return code using ERR_PTR so the return value
>> should be checked for errors using IS_ERR. Please note that _sr_look=
up
>> checks for NULL parameter internally.
>
>
> =A0 That's clear. I was asking don't you want to return PTR_ERR(sr) i=
nstead of
> -EINVAL.
Oh yes you are correct, that is a good catch. Sorry for my misunderstan=
ding.

I caught the same problem at a few other places and I have a patch
ready for the error handling code. To be submitted asap.

>
> WBR, Sergei

Thanks!
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
