From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 0/7 v5] OMAP3: clean up ASM sleep code
Date: Sat, 18 Dec 2010 16:51:18 +0100
Message-ID: <AANLkTincitcFQ2fGerSk-p4GmoodG4L4Lz1Cr1vuPYye@mail.gmail.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>
	<87bp4k6m1d.fsf@deeprootsystems.com>
	<AANLkTi=4XhE+fYDa9BYqk+1yb08Kiu3ppYNqEfW2w5Hf@mail.gmail.com>
	<4D0BF09B.5050709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41827 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211Ab0LRPvU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Dec 2010 10:51:20 -0500
Received: by qwa26 with SMTP id 26so1604614qwa.19
        for <linux-omap@vger.kernel.org>; Sat, 18 Dec 2010 07:51:19 -0800 (PST)
In-Reply-To: <4D0BF09B.5050709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

On Sat, Dec 18, 2010 at 12:22 AM, Nishanth Menon <nm@ti.com> wrote:
> Jean Pihet had written, on 12/17/2010 05:07 PM, the following:
>>
>> Hi Kevin,
>>
>> On Sat, Dec 18, 2010 at 12:02 AM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>>
>>> Hi Jean,
>>>
>>> jean.pihet@newoldbits.com writes:
>>>
>>>> From: Jean Pihet <j-pihet@ti.com>
>>>>
>>>> This patch only contains clean-ups and cosmetic changes,
>>>> no functional change.
>>>>
>>>> Clean-up of the ASM sleep code, for better readability and
>>>> easier maintenance.
>>>>
>>>> Applies on top of Nishant's latest idle path errata fixes step 2,
>>>> cf. http://marc.info/?l=3Dlinux-omap&m=3D129139584919242&w=3D2
>>>
>>> Can you do one more spin of this series in order to collect the
>>> reviewed-by/tested-by tags posted, and address some of Nishanth's
>>> comments. =A0Since we are reaching a merge window deadline, I'll le=
ave it
>>> to your discretion to decide which of Nishanth's suggestions to add=
ress
>>> now and which to address later.
>>
>> Sure I will post a new version tomorrow.
>> This will include some fixes after Nishant's comments. The rest can =
be
>> done later after we agree on the future changes.
>
> Sounds good to me as well.. the minor cleanups should be easy to do..
> will help with testing tomorrow on the new series if there are any
> functional changes. I will post out my revamped series as well 2morro=
w.

Ok I just re-sent the series as '[PATCH 0/7 v6] OMAP3: clean up ASM sle=
ep code'.

Thanks!
Jean

>
>
> --
> Regards,
> Nishanth Menon
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
