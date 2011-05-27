From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC][PATCH 3/9] OMAP4460: HWMOD: DO not reset GPIO1 during HWMOD init
Date: Fri, 27 May 2011 12:35:41 -0700
Message-ID: <87zkm8x7g2.fsf@ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>
	<1306375016-707-4-git-send-email-nm@ti.com> <87oc2p82q0.fsf@ti.com>
	<4DDF4E4D.6060008@ti.com>
	<BANLkTi=dHknRn5KJSh3_bG-o19BUg2AjrA@mail.gmail.com>
	<87vcww5gvo.fsf@ti.com> <4DDFBDE6.1020606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:50321 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752847Ab1E0Tfo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 May 2011 15:35:44 -0400
Received: by mail-pz0-f50.google.com with SMTP id 2so938859pzk.9
        for <linux-omap@vger.kernel.org>; Fri, 27 May 2011 12:35:43 -0700 (PDT)
In-Reply-To: <4DDFBDE6.1020606@ti.com> (Benoit Cousson's message of "Fri, 27
	May 2011 17:06:14 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Govindraj <govindraj.ti@gmail.com>, "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>

"Cousson, Benoit" <b-cousson@ti.com> writes:

> Hi Kevin,
>
> On 5/27/2011 4:59 PM, Hilman, Kevin wrote:
>> Govindraj<govindraj.ti@gmail.com>  writes:
>
> [...]
>
>>> uart->oh->flags |= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;
>>>
>>
>> This is a hack (written by me) because the UART driver is not runtime PM
>> adapted.  When UART driver is runtime PM adapted, this will not be
>> needed.
>
> The UART can support reset and idle? There is no assumption for the
> UART used during the early debug phase?

No.  As long as the UART driver is doing runtime PM properly, there are
no assumptions required.

Kevin

> Don't we have to maintain its state?
> It will be indeed better if we don't have to.
>
> Regards,
> Benoit
