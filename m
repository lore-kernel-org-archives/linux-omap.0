From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] ARM: OMAP: clock, powerdomain, clockdomain, hwmod
 fixes for early v3.4-rc (misc_devel_3.4 patches dropped)
Date: Thu, 5 Apr 2012 21:45:12 -0700
Message-ID: <CAOesGMjnKzA=BMPVHw0Jtsr2Lz+_ggAihaAyyVO3hWifUPd8Kw@mail.gmail.com>
References: <alpine.DEB.2.00.1204050339510.10302@utopia.booyaka.com>
	<20120405224658.GI3785@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38646 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab2DFEpN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Apr 2012 00:45:13 -0400
Received: by yenl12 with SMTP id l12so1146246yen.19
        for <linux-omap@vger.kernel.org>; Thu, 05 Apr 2012 21:45:12 -0700 (PDT)
In-Reply-To: <20120405224658.GI3785@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Arnd Bergmann <arnd@arndb.de>

On Thu, Apr 5, 2012 at 3:46 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Olof,
>
> * Paul Walmsley <paul@pwsan.com> [120405 02:45]:
>> Hi Tony,
>>
>> The following changes since commit dd775ae2549217d3ae09363e3edb305d0=
fa19928:
>>
>> =A0 Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)
>>
>> are available in the git repository at:
>>
>> =A0 git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending t=
ags/omap-fixes-a2-for-3.4rc
>>
>> for you to fetch changes up to a9dd31b744a033b4324c93cec4ecb4c74061e=
2cf:
>>
>> =A0 Merge branches 'clock_fixes_3.4rc', 'clockdomain_fixes_3.4rc', '=
hsmmc_erratum_2_1_1_128_refine_3.4rc1', 'hwmod_data_fixes_a_3.4rc', 'hw=
mod_fixes_a2_3.4rc' and 'powerdomain_fixes_a_3.4rc' into omap-fixes-a2-=
for-3.4rc-branch (2012-04-05 03:00:22 -0600)
>>
>> This version is intended to merge cleanly into your 'fixes' branch.
>
> If not too late for this round of fixes, can you please pull this
> set of fixes directly from Paul?
>
> I was planning on including this into my fixes yesterday, but
> two patches had to be dropped that Paul did last night.
>
> This one already has the signed tag ;)

Thanks, pulled.

Paul, thanks for using a signed tag with an overview. There's no need
to list the changes in the signed tag though -- "git pull --log" will
include them in the merge commit instead. In general Linus tends to
not like seeing redundant info in the tag text that can be derived
from the branch contents instead.


-Olof
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
