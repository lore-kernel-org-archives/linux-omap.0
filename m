From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3: PM: Add the wakeup source driver, v2
Date: Sat, 4 Apr 2009 14:22:16 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904041421210.8305@utopia.booyaka.com>
References: <4d34a0a70903182125l77b0adc3rc0c672f0aa348ab@mail.gmail.com>  <87ocvhtesx.fsf@deeprootsystems.com> <4d34a0a70904030320g197f836cld9c94b113a9fdffd@mail.gmail.com>  <87y6uh1zsp.fsf@deeprootsystems.com> <4d34a0a70904031647n6ae7c175w96b1610bf553ebda@mail.gmail.com>
  <877i21w9pg.fsf@deeprootsystems.com> <4d34a0a70904031726h504d2722xb8032c8573fb1c15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38212 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532AbZDDUWS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Apr 2009 16:22:18 -0400
In-Reply-To: <4d34a0a70904031726h504d2722xb8032c8573fb1c15@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, OMAP <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>

On Sat, 4 Apr 2009, Kim Kyuwon wrote:

> No, I haven't configured GPTIMER12. And actually
> OMAP3430_ST_GPT12_MASK bit is reserved on OMAP3430 ES.1.
> This is another problem that I have to fix.....

Please see the OMAP34xx Multimedia High Security (HS) Device Silicon 
Revision 3.0 Security Addendum (SWPU119B) Table 3-244.


- Paul
