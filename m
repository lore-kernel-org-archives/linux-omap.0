From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE:Fix Kernel memory poison overwritten after
	DSP_MMUFAULT
Date: Fri, 14 May 2010 15:08:53 +0300
Message-ID: <AANLkTikZFspJxmYd1xU22ZBvKxKVXGtbn5fvkbqOYlM2@mail.gmail.com>
References: <1271177720-1299-1-git-send-email-deepak.chitriki@ti.com>
	 <496565EC904933469F292DDA3F1663E602CB215CB2@dlee06.ent.ti.com>
	 <AANLkTik46ilQPBGtsgWAMTlWrdWaaYTDC2aCYmf4iUIn@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602CB5B99E5@dlee06.ent.ti.com>
	 <AANLkTikUc623KkBg88CYr9_Pskx_A6sqXikGEdqhhKm8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41683 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378Ab0ENMJZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 08:09:25 -0400
Received: by fxm6 with SMTP id 6so1402917fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 05:09:24 -0700 (PDT)
In-Reply-To: <AANLkTikUc623KkBg88CYr9_Pskx_A6sqXikGEdqhhKm8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: "Chitriki Rudramuni, Deepak" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>

On Thu, May 13, 2010 at 2:39 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Thu, May 13, 2010 at 12:09 AM, Guzman Lugo, Fernando
> <fernando.lugo@ti.com> wrote:
>>> If you are referring to this patch:
>>> http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-
>>> 2.6.git;a=commit;h=26ad62f03578a12e942d8bb86d0e52ef1afdee22
>>
>> Yes, that's the patch. Could you make sure that the GPT8 interrupt is generated before acking MMU fault interrupt?
>
> I'll try tomorrow when I have access to the hw.

I should see "GPTimer interrupt failed" if it doesn't... right? Then
yes, the GPT8 interrupt is generated.

-- 
Felipe Contreras
