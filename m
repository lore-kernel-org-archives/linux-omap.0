From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFC 13/19] OMAP2+: voltage: keep track of powerdomains in each voltagedomain
Date: Fri, 25 Mar 2011 08:56:20 -0700
Message-ID: <87hbartcrf.fsf@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
	<1300924833-26745-14-git-send-email-khilman@ti.com>
	<AANLkTi=JD=QJKBWekHDW08JOxrvntmTfMfTK9Eq_xH9Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:53447 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753999Ab1CYP4Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 11:56:24 -0400
Received: by iyb12 with SMTP id 12so2496772iyb.1
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 08:56:23 -0700 (PDT)
In-Reply-To: <AANLkTi=JD=QJKBWekHDW08JOxrvntmTfMfTK9Eq_xH9Y@mail.gmail.com>
	(Jean Pihet's message of "Fri, 25 Mar 2011 10:22:12 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

[...]

>> +
>> +/**
>> + * voltdm_for_each - call function on each registered voltagedomain
>> + * @fn: callback function *
>> + *
>> + * Call the supplied function @fn for each registered voltagedomain=
=2E
>> + * The callback function @fn can return anything but 0 to bail out
>> + * early from the iterator. =C2=A0Returns the last return value of =
the
>> + * callback function, which should be 0 for success or anything els=
e
>> + * to indicate failure; or -EINVAL if the function pointer is null.
>
> The function description does not match the prototype.
>

in what way?

the description is wrong in how it describes the "bail out" but I don't
see what you mean for the prototype.

[...]

>>
>> +struct powerdomain;
>> +
>> +/*
>> + * Maximum number of powerdomains that can be associated with a vol=
tagedomain.
>> + */
>> +#define VOLTDM_MAX_PWRDMS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 10
> This is not used in the patch. Is it needed?
>

Nope.  Will drop.

Thanks,

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
