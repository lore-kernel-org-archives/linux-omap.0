From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE:Fix Kernel memory poison overwritten after
	DSP_MMUFAULT
Date: Wed, 12 May 2010 22:39:10 +0300
Message-ID: <AANLkTik46ilQPBGtsgWAMTlWrdWaaYTDC2aCYmf4iUIn@mail.gmail.com>
References: <1271177720-1299-1-git-send-email-deepak.chitriki@ti.com>
	 <496565EC904933469F292DDA3F1663E602CB215CB2@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61814 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab0ELTjM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 15:39:12 -0400
Received: by fxm5 with SMTP id 5so27369fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 12 May 2010 12:39:11 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CB215CB2@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>

Hi,

I didn't touch this issue in the hopes that it would be fixed, but
seems it hasn't.

On Mon, Apr 19, 2010 at 9:25 PM, Guzman Lugo, Fernando <x0095840@ti.com> wrote:
> To sum up:
>
> - "DSPBRIDGE:Fix Kernel memory poison overwritten after DSP_MMUFAULT" is only hidden the problem, we don't need aligned memory in this point, that patch should be removed if it is already apply.
>
> - There is no need to create a patch for the issue because it is already indirectly fix with "DSPBRIDGE: MMU-Fault debugging enhancements".

If you are referring to this patch:
http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=commit;h=26ad62f03578a12e942d8bb86d0e52ef1afdee22

I tried to backport it to minimize the changes to a reproducible
test-case. I guess in the l-o branch the commit would be dd1fd0b.
Unfortunately that didn't fix the corruption. So I don't by that GPT8
theory.

> - we don't need allocate memory for dummy_va_addr, if some patch should be created should be the patch to remove dummy_va_addr allocation and deletion.

I tried that, and that actually fixes the corruption for me (passing 0
to hw_mmu_tlb_add).

-- 
Felipe Contreras
