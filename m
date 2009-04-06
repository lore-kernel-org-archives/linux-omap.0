From: Kim Kyuwon <chammoru@gmail.com>
Subject: Re: [PATCH] OMAP3: PM: Add the wakeup source driver, v2
Date: Mon, 6 Apr 2009 11:30:41 +0900
Message-ID: <4d34a0a70904051930h6d103df9j76e190b5288756f5@mail.gmail.com>
References: <4d34a0a70903182125l77b0adc3rc0c672f0aa348ab@mail.gmail.com>
	<87ocvhtesx.fsf@deeprootsystems.com> <4d34a0a70904030320g197f836cld9c94b113a9fdffd@mail.gmail.com>
	<87y6uh1zsp.fsf@deeprootsystems.com> <4d34a0a70904031647n6ae7c175w96b1610bf553ebda@mail.gmail.com>
	<877i21w9pg.fsf@deeprootsystems.com> <4d34a0a70904031726h504d2722xb8032c8573fb1c15@mail.gmail.com>
	<alpine.DEB.2.00.0904041421210.8305@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:13114 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705AbZDFCa6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 5 Apr 2009 22:30:58 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2039029wff.4
        for <linux-omap@vger.kernel.org>; Sun, 05 Apr 2009 19:30:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0904041421210.8305@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>

On Sun, Apr 5, 2009 at 5:22 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Sat, 4 Apr 2009, Kim Kyuwon wrote:
>
>> No, I haven't configured GPTIMER12. And actually
>> OMAP3430_ST_GPT12_MASK bit is reserved on OMAP3430 ES.1.
>> This is another problem that I have to fix.....
>
> Please see the OMAP34xx Multimedia High Security (HS) Device Silicon
> Revision 3.0 Security Addendum (SWPU119B) Table 3-244.

Thanks again, Paul!
Now I understand.

>
> - Paul
>


Sincerely,
Kyuwon
