From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: OMAP3 & DSP
Date: Mon, 26 Jan 2015 21:35:40 +0100
Message-ID: <CAGGh5h1OFHbXD1z78oQ1+pWbnDrTU+sU7AVCW6LLUpU9D=echg@mail.gmail.com>
References: <54C69BF6.4010105@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:42722 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbbAZUfk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Jan 2015 15:35:40 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so6030829igb.0
        for <linux-omap@vger.kernel.org>; Mon, 26 Jan 2015 12:35:40 -0800 (PST)
In-Reply-To: <54C69BF6.4010105@gmx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sven Brandau <brandau@gmx.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

2015-01-26 20:56 GMT+01:00 Sven Brandau <brandau@gmx.de>:
>
> Hello,
>
> is there any driver support for the DSP on OMAP3 SOCs available in th=
e current kernel?
>
> This means DSP image loading, starting and communication mechanisms b=
etween ARM CPU and DSP.
>
> The original TI driver only running on kernels with versions 2.6.x.
>
Last time I looked for, I could not find any.
However, with only small patches, the dvsdk for dm3730 for instance
runs fine on 3.10 kernel.
I did not try on later kernel.

On the other hand, the dspbridge driver that was supposed to be the
way forward is now marked as BROKEN...

Jean-Philippe Fran=C3=A7ois

>
> Best regards,
> Sven
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
