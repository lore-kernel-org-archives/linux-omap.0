From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH/RFC 10/19] OMAP3: powerdomain data: add voltage domains
Date: Fri, 25 Mar 2011 17:43:09 +0100
Message-ID: <AANLkTikya3cX6tMRCz9AJUZAw4MnQScr4rUfUp0DcBGs@mail.gmail.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-11-git-send-email-khilman@ti.com>
	<AANLkTinQXj63xHUs2yX1kjwYOXbj+vCQrZXJBAc6Wo7i@mail.gmail.com>
	<87wrjntd0b.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60705 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab1CYQnK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 12:43:10 -0400
Received: by qyg14 with SMTP id 14so825861qyg.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 09:43:09 -0700 (PDT)
In-Reply-To: <87wrjntd0b.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

On Fri, Mar 25, 2011 at 4:51 PM, Kevin Hilman <khilman@ti.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> On Thu, Mar 24, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> Add voltage domain name to indicate which voltagedomain each
>>> powerdomain is in. =A0A missing voltage domain name means that that
>>> powerdomain is not in one of the currently scalable voltage domains=
=2E
>>
>> Is that the role of the 'scalable' flag? Why not fill in all
>> powerdomain structs and set the flag on scalable VDs only?
>>
>
> Yes.
>
> This changelog was written before I added the scalable flag. =A0Will =
fix
> up the changelog.
Ok if the code does accordingly (which I suppose it does).

>
> Thanks,
>
> Kevin
>

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
