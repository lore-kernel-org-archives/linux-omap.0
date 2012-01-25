From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 05/21] Revert "OMAP3+: PM: SR: add suspend/resume handlers"
Date: Wed, 25 Jan 2012 19:25:26 +0100
Message-ID: <4F204916.7050504@ti.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com> <1327504583-13408-6-git-send-email-j-pihet@ti.com> <4F2041B1.6060907@ti.com> <CAORVsuWu-pzTWzYp2=gqqPzRJQ1eBLu=12uNyEbVSZp407WUnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54470 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab2AYSZe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 13:25:34 -0500
In-Reply-To: <CAORVsuWu-pzTWzYp2=gqqPzRJQ1eBLu=12uNyEbVSZp407WUnA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

On 1/25/2012 7:13 PM, Jean Pihet wrote:
> Hi Benoit,
>
> On Wed, Jan 25, 2012 at 6:53 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> Salut Jean,
>>
>>
>> On 1/25/2012 4:16 PM, Jean Pihet wrote:
>>>
>>> From: Nishanth Menon<nm@ti.com>
>>>
>>> This reverts commit b6be18f0bab68ed304ebbb2d787d1c36237eda62.
>>
>> That weird, because you revert a patch you introduced just before:
>> [PATCH 03/21] OMAP3+: PM: SR: add suspend/resume handlers
> I left the 2 commits on purpose because I think the descriptions give a good
> description on why the commits have been introduced and then later removed.
>
>>
>> Moreover this commit id is not relevant since it is probably only in
>> Nishanth's GIT tree.
> I removed this in the next version.
>
>>
>>
>>> Revert the patch so that we remove any opportunity of SR disable/enable
>>> and any device_scale transitions from conflicting with suspend/resume
>>> path by moving the sr enable/disable activity to the very last
>>> stage(in pmxx.C). The previous patch tried to optimize suspend resume
>>> time, but since device_scale opportunities are from multiple drivers
>>> (other than cpufreq), hence reverting back to original approach
>>>
>>> Conflicts:
>>>
>>>         arch/arm/mach-omap2/smartreflex.c
>>>
>>> Change-Id: I236b0e8259cfb371899dd0c93875739a21358e33
> Removed as well. Sorry about that.
>
>>
>> And this looks like gerrit leftover that should not be there.
>>
>> I guess that path #3 and #5 should just be removed.
> I am ok with both options (keeping or removing the 2 commits), please
> let me know what you prefer.

I guess that removing both is the only acceptable solution anyway. That 
might force you to change a little bit the #4, but maybe it not even needed.

Regards,
Benoit
