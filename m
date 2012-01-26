From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 17/21] OMAP3430: SR: class3: restrict CPU to run on
Date: Thu, 26 Jan 2012 13:22:05 +0100
Message-ID: <CAORVsuVPwgONiE3_SdONSB2at5L4hmT=vV5ipyOhEEbJ-X6DAw@mail.gmail.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
	<1327504583-13408-18-git-send-email-j-pihet@ti.com>
	<4F2139F1.6060908@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:59257 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab2AZMWH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 07:22:07 -0500
Received: by vcbgb30 with SMTP id gb30so315199vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Jan 2012 04:22:05 -0800 (PST)
In-Reply-To: <4F2139F1.6060908@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Sergei,

On Thu, Jan 26, 2012 at 12:33 PM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
>
>
> On 25-01-2012 19:16, Jean Pihet wrote:
>
>> From: Nishanth Menon<nm@ti.com>
>
>
>> Use SmartReflex AVS Class3 initialization only for OMAP343x family o=
f
>> processors.
>
>
>> Change-Id: I660326bf265541ba4e0feb52853ff6cb9b293aed
>
>
> =A0 All patchjes from Nishanth Menon seem to contain this line. Pleas=
e remove
> it...
OK done in the next revision, sorry about that.
That 'Change-Id' line seems to have very much success on the mailing li=
st ;p

Thanks for reviewing,
Jean

>
>
>> Signed-off-by: Nishanth Menon<nm@ti.com>
>> Signed-off-by: Jean Pihet<j-pihet@ti.com>
>
>
> WBR, Sergei
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
