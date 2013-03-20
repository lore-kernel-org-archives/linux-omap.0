From: Guillaume Gardet <guillaume.gardet@free.fr>
Subject: Re: Beagleboard xM - Bogomips are very low
Date: Wed, 20 Mar 2013 17:26:48 +0100
Message-ID: <5149E348.2040101@free.fr>
References: <5148819A.5040500@free.fr> <5149B028.9010703@yahoo.com>
Reply-To: guillaume.gardet@free.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:48875 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932536Ab3CTQ05 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 12:26:57 -0400
In-Reply-To: <5149B028.9010703@yahoo.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Frank Agius <ftagius@yahoo.com>
Cc: linux-omap@vger.kernel.org, openSUSE ARM ML <opensuse-arm@opensuse.org>


Le 20/03/2013 13:48, Frank Agius a =E9crit :
> On 3/19/2013 11:17 AM, Guillaume Gardet wrote:
>> Hi,
>>
>> On a Beagleboard xM rev. B, I noticed that vanilla kernel 3.4.6 have=
 the
>> folowing bogomips for 300MHz and 800 MHz operations: 262.08 and 700.=
57.
>>
>> With kernel 3.7.10, I have : 175.65 and 467.41 bogompis.
>>
>> Any idea why bogomips are so low now?
>>
>
> I believe this is the reason for the BogoMIPS change:
>
> http://www.spinics.net/lists/arm-kernel/msg221672.html
>
> It looks like BogoMIPS reporting changed because of the delay routine=
 patch introduced in 3.6.  So the change in BogoMIPS is real, but shoul=
d not be a concern.

Thanks for the pointer. So, it should not affect performances.
I will try to bench it, to be sure there is no hidden problem.

Thanks.


Guillaume


>
> frank agius
>
>> Guillaume
>>
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
