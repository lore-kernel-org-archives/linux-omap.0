From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] DSPBRIDGE: Compiler wanrning fix for unlocked_ioctl
Date: Tue, 9 Jun 2009 00:19:07 +0300
Message-ID: <94a0d4530906081419v74acb10fp20dc741e8d6ff098@mail.gmail.com>
References: <1244121977-24927-1-git-send-email-ameya.palande@nokia.com>
	 <27F9C60D11D683428E133F85D2BB4A53040F3FCD75@dlee03.ent.ti.com>
	 <20090608.143425.193688889.Hiroshi.DOYU@nokia.com>
	 <8F7AF80515AF0D4D93307E594F3CB40E2F73A252@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:36124 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754AbZFHVTH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 17:19:07 -0400
Received: by fg-out-1718.google.com with SMTP id d23so892733fga.17
        for <linux-omap@vger.kernel.org>; Mon, 08 Jun 2009 14:19:07 -0700 (PDT)
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E2F73A252@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Jun 8, 2009 at 11:49 PM, Kanigeri, Hari<h-kanigeri2@ti.com> wrote:
> Hi Doyu-san,
>
> Regarding
>
>> http://marc.info/?l=linux-omap&m=124201773423892&w=2
>> I think that the first one should be merged into d.o-z.org now, but
>> for the second one about 128 byte alignment. let me know your
>> thought/plan on it.
>
> -- I think you sent this patch as a probable fix for the slab corruption that was observed in Bridge driver, but then we found that slab corruption was due to some other issue in Bridge driver and not due to the cache alignment.
>
> Irrespective of above point, I think it is good to enforce the cache alignment check, but I think the check should be in Proc Map function and to start with the check should be under a flag so as not to affect some MM applications that use padding to get over the alignment issue.

I agree, the check should be in proc map, and should be optional.
However, I would prefer it to be an all-or-nothing option, how about
in kconfig?

-- 
Felipe Contreras
