From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 05/21] Revert "OMAP3+: PM: SR: add suspend/resume handlers"
Date: Wed, 25 Jan 2012 19:13:55 +0100
Message-ID: <CAORVsuWu-pzTWzYp2=gqqPzRJQ1eBLu=12uNyEbVSZp407WUnA@mail.gmail.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
	<1327504583-13408-6-git-send-email-j-pihet@ti.com>
	<4F2041B1.6060907@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45679 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833Ab2AYSN5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 13:13:57 -0500
Received: by vbbfc26 with SMTP id fc26so2294335vbb.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Jan 2012 10:13:56 -0800 (PST)
In-Reply-To: <4F2041B1.6060907@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

Hi Benoit,

On Wed, Jan 25, 2012 at 6:53 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> Salut Jean,
>
>
> On 1/25/2012 4:16 PM, Jean Pihet wrote:
>>
>> From: Nishanth Menon<nm@ti.com>
>>
>> This reverts commit b6be18f0bab68ed304ebbb2d787d1c36237eda62.
>
> That weird, because you revert a patch you introduced just before:
> [PATCH 03/21] OMAP3+: PM: SR: add suspend/resume handlers
I left the 2 commits on purpose because I think the descriptions give a=
 good
description on why the commits have been introduced and then later remo=
ved.

>
> Moreover this commit id is not relevant since it is probably only in
> Nishanth's GIT tree.
I removed this in the next version.

>
>
>> Revert the patch so that we remove any opportunity of SR disable/ena=
ble
>> and any device_scale transitions from conflicting with suspend/resum=
e
>> path by moving the sr enable/disable activity to the very last
>> stage(in pmxx.C). The previous patch tried to optimize suspend resum=
e
>> time, but since device_scale opportunities are from multiple drivers
>> (other than cpufreq), hence reverting back to original approach
>>
>> Conflicts:
>>
>> =A0 =A0 =A0 =A0arch/arm/mach-omap2/smartreflex.c
>>
>> Change-Id: I236b0e8259cfb371899dd0c93875739a21358e33
Removed as well. Sorry about that.

>
> And this looks like gerrit leftover that should not be there.
>
> I guess that path #3 and #5 should just be removed.
I am ok with both options (keeping or removing the 2 commits), please
let me know what you prefer.

>
> Regards,
> Benoit
>
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
