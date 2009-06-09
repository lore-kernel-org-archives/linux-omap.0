From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE: Compiler wanrning fix for unlocked_ioctl
Date: Tue, 9 Jun 2009 12:11:30 +0300
Message-ID: <94a0d4530906090211m635e05c5ya368da6ddbd1fc55@mail.gmail.com>
References: <1244121977-24927-1-git-send-email-ameya.palande@nokia.com>
	 <27F9C60D11D683428E133F85D2BB4A53040F3FCD75@dlee03.ent.ti.com>
	 <20090608.143425.193688889.Hiroshi.DOYU@nokia.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2F73A252@dlee03.ent.ti.com>
	 <94a0d4530906081419v74acb10fp20dc741e8d6ff098@mail.gmail.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2F73A449@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:64882 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbZFIJLc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 05:11:32 -0400
Received: by fg-out-1718.google.com with SMTP id d23so968258fga.17
        for <linux-omap@vger.kernel.org>; Tue, 09 Jun 2009 02:11:32 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2F73A449@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Jun 9, 2009 at 4:18 AM, Kanigeri, Hari<h-kanigeri2@ti.com> wrote:
>> I agree, the check should be in proc map, and should be optional.
>> However, I would prefer it to be an all-or-nothing option,
>> how about in kconfig?
>>
>
> -- One other way is we can use a bit mask in map attributes argument in DSP Proc Map function to enforce the check on the buffer.
>
> What are the reasons as why you want to make it all-or-nothing option ?

The objective is to be more strict to give less power to user-space to
screw up the system, an argument in proc map still lets user-space to
screw up.

-- 
Felipe Contreras
