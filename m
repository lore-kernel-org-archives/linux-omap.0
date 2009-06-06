From: Rebecca Schultz Zavin <rebecca@android.com>
Subject: Re: PM error: Powerdomain (core_pwddm) didn't enter target state 1
Date: Fri, 5 Jun 2009 17:44:42 -0700
Message-ID: <aed62de90906051744q6786b991hffe8640567934501@mail.gmail.com>
References: <42B46BA8-AF35-42B5-9616-EADA31EF0553@mac.com>
	 <87fxeebrsc.fsf@deeprootsystems.com>
	 <277E4F10-4228-40C5-85C8-5B365B861DFF@mac.com>
	 <87tz2ua7uy.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:52270 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853AbZFFAoo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 20:44:44 -0400
Received: from spaceape14.eur.corp.google.com (spaceape14.eur.corp.google.com [172.28.16.148])
	by smtp-out.google.com with ESMTP id n560ijIn028131
	for <linux-omap@vger.kernel.org>; Fri, 5 Jun 2009 17:44:45 -0700
Received: from qw-out-1920.google.com (qwc5.prod.google.com [10.241.193.133])
	by spaceape14.eur.corp.google.com with ESMTP id n560iNcG017346
	for <linux-omap@vger.kernel.org>; Fri, 5 Jun 2009 17:44:43 -0700
Received: by qw-out-1920.google.com with SMTP id 5so1168540qwc.38
        for <linux-omap@vger.kernel.org>; Fri, 05 Jun 2009 17:44:43 -0700 (PDT)
In-Reply-To: <87tz2ua7uy.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Elvis Dowson <elvis.dowson@mac.com>, Linux OMAP Users <linux-omap@vger.kernel.org>

On Fri, Jun 5, 2009 at 10:49 AM, Kevin
Hilman<khilman@deeprootsystems.com> wrote:
> Elvis Dowson <elvis.dowson@mac.com> writes:
>
>> Hi Kevin,
>>
>> On Jun 5, 2009, at 7:53 PM, Kevin Hilman wrote:
>>
>>>>
>>>
>>> It's pretty difficult for me to know what you are actually running =
by
>>> the description above. =A0You've taken a bunch of stuff, put them
>>> together in some unspecified way, and are using an unspecified conf=
ig.
>>
>> Sorry about that, I'm working on an android port to the gumstix over=
o
>> earth platform. I'm trying to incorporate patches from the
>> android-2.6.29 kernel, tomi's latest dss2 patches and your pm patche=
s,
>> to the linux-omap-2.6 master branch.
>
> For initial PM debugging, I highly recommend something closer to what
> others are developing and testing against. =A0Using the PM branch
> patches on top of linux-omap master is not yet tested and validated,
> so I can't give you any support there.
>
> For example, you might start from the Android OMAP kernel which
> is 2.6.29 based and includes the PM branch already.
>
> =A0http://android.git.kernel.org/?p=3Dkernel/omap.git
>
> Then you'd just have to add your dss2 and Overo stuff there.

Dss2 is already there as are Kevin's pm patches.  We're actively
debugging pm issues there as well.  We're happy to take patches
against that branch if you feel like contributing back.

>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
