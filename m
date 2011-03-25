From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 10/19] OMAP3: powerdomain data: add voltage domains
Date: Fri, 25 Mar 2011 08:51:00 -0700
Message-ID: <87wrjntd0b.fsf@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-11-git-send-email-khilman@ti.com>
	<AANLkTinQXj63xHUs2yX1kjwYOXbj+vCQrZXJBAc6Wo7i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:58391 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753984Ab1CYPvE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 11:51:04 -0400
Received: by mail-iy0-f176.google.com with SMTP id 1so872964iym.35
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 08:51:02 -0700 (PDT)
In-Reply-To: <AANLkTinQXj63xHUs2yX1kjwYOXbj+vCQrZXJBAc6Wo7i@mail.gmail.com>
	(Jean Pihet's message of "Fri, 25 Mar 2011 10:09:42 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Thu, Mar 24, 2011 at 1:00 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Add voltage domain name to indicate which voltagedomain each
>> powerdomain is in. =C2=A0A missing voltage domain name means that th=
at
>> powerdomain is not in one of the currently scalable voltage domains.
>
> Is that the role of the 'scalable' flag? Why not fill in all
> powerdomain structs and set the flag on scalable VDs only?
>

Yes.

This changelog was written before I added the scalable flag.  Will fix
up the changelog.

Thanks,

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
