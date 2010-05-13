From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE: MMU-Fault debugging enhancements
Date: Fri, 14 May 2010 01:06:06 +0300
Message-ID: <AANLkTikYoYlsSAI_3L09EtO7td5urGKUgXnrgI3dP_95@mail.gmail.com>
References: <496565EC904933469F292DDA3F1663E602CB04896F@dlee06.ent.ti.com>
	 <x2y94a0d4531004300821v920d3240p5215a967c6c48759@mail.gmail.com>
	 <C161915E2DD8304FAAE595A13B0A0948024AE50D98@dlee01.ent.ti.com>
	 <20100505115802.GE4265@annwn.felipec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52258 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759236Ab0EMWGH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 18:06:07 -0400
Received: by fxm6 with SMTP id 6so896647fxm.19
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 15:06:06 -0700 (PDT)
In-Reply-To: <20100505115802.GE4265@annwn.felipec.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>, "ext Ramos Falcon, Ernesto" <ernesto@ti.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@v>

On Wed, May 5, 2010 at 2:58 PM, Felipe Contreras
<felipe.contreras@nokia.com> wrote:
> Hey Ernesto,
>
> On Fri, Apr 30, 2010 at 09:24:15PM +0200, ext Ramos Falcon, Ernesto wrote:
>> >This patch seems to be doing a lot of things. Couldn't it have been
>> >split?
>> >
>> >Also, from the commit message it seems to implement a new feature,
>> >however, I heard it's supposed to fix memory corruption too. Is that
>> >true? If that's the case the code that fixes that would have to be
>> >separate.
>> >
>> >I understand this patch was already pushed to dspbridge branch, but I
>> >think such important changes should be properly recorded in the
>> >history.
>>
>> I agree important changes must be properly recorded but in this case
>> the patch introduces only one new feature and because of the way that
>> it is implemented using gpt8 overflow interrupt instead of mailbox to
>> inform about the MMU Fault, the problem of the memory corruption was
>> fixed indirectly, however these changes are part of the feature design
>> itself and I don't see the need to split this new feature.
>
> In general, logically independent changes should end up as separate
> patches. Many times it looks like a patch cannot be split further, but
> with a little bit of creativity it usually can.
>
> I can think of one patch that switches to gpt8 overflow, and another one
> that actually shows the extra information.
>
> Anyway, I ask because we found some issues with the latest commits of
> dspbridge, and I would like to isolate the memory corruption fix just to
> be safe.

Disregard that. This patch doesn't actually fix the corruption. I sent
one proposal for a patch that does.

> Also, from that description it looks like there might be still a problem
> in the mailbox that is hidded by this patch... so it's more like a
> workaround, not really a fix.

I've extracted the GPT8 related changes, which are good in themselves,
and I sent a separate patch for reference. I also cleaned the patch a
bit.

Now I wonder if there are some situations where we might not want to
use GPT8, but the mailbox interrupt. Maybe some baseimages are not
using GPT8, or maybe the system doesn't have OMAP_DM_TIMER.

Also, all this MMU fault backtracing and so on seems to consume quite
a bit of code. Production systems most likely would want to have this
off (specially when constrained by size), so it should be a
configuration option.

Cheers.

-- 
Felipe Contreras
