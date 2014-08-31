From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] ARM: OMAP2+: DRA72x/DRA74x basic support
Date: Sun, 31 Aug 2014 10:19:04 -0700
Message-ID: <CAOesGMiudDK71Pzo+k9iiKJAcJzobc5z4+cpcomeJyM1KzbvgQ@mail.gmail.com>
References: <alpine.DEB.2.02.1408280617360.21985@utopia.booyaka.com>
	<20140828170258.GH16006@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:40977 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbaHaRTG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2014 13:19:06 -0400
Received: by mail-vc0-f174.google.com with SMTP id hy4so4476174vcb.5
        for <linux-omap@vger.kernel.org>; Sun, 31 Aug 2014 10:19:05 -0700 (PDT)
In-Reply-To: <20140828170258.GH16006@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "arm@kernel.org" <arm@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>

Hi,

This one clearly falls into the category of new platform support, not
bugfixes. But it's pretty small so I'll pick it up this time.


-Olof

On Thu, Aug 28, 2014 at 10:02 AM, Tony Lindgren <tony@atomide.com> wrote:
> Arnd & Olof,
>
> Can you please pick this one up for the -rc cycle so the TI guys
> can boot test dra7 with mainline properly?
>
> Regards,
>
> Tony
>
> * Paul Walmsley <paul@pwsan.com> [140827 23:18]:
>> Hi Tony,
>>
>> The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:
>>
>>   Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.17-rc/omap-dra72x-d74x-support-a
>>
>> for you to fetch changes up to f7f7a29bf0cf25af23f37e5b5bf1368b85705286:
>>
>>   ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp interface lists (2014-08-27 19:38:23 -0600)
>>
>> ----------------------------------------------------------------
>> Add basic subarchitecture support for the DRA72x and DRA74x.  These
>> are OMAP2+ derivative SoCs.  This should be low-risk to existing OMAP
>> platforms.
>>
>> Basic build, boot, and PM test logs are available here:
>>
>> http://www.pwsan.com/omap/testlogs/hwmod-a-early-v3.17-rc/20140827194314/
>>
>> ----------------------------------------------------------------
>> Rajendra Nayak (2):
>>       ARM: DRA7: Add support for soc_is_dra74x() and soc_is_dra72x() variants
>>       ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp interface lists
>>
>>  arch/arm/mach-omap2/omap_hwmod.c          |  3 +++
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 22 ++++++++++++++++++++--
>>  arch/arm/mach-omap2/soc.h                 |  6 ++++++
>>  3 files changed, 29 insertions(+), 2 deletions(-)
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
