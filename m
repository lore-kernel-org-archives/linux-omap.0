From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [RFC][PATCH 3/9] OMAP4460: HWMOD: DO not reset GPIO1 during HWMOD
 init
Date: Fri, 27 May 2011 17:06:14 +0200
Message-ID: <4DDFBDE6.1020606@ti.com>
References: <1306375016-707-1-git-send-email-nm@ti.com>	<1306375016-707-4-git-send-email-nm@ti.com> <87oc2p82q0.fsf@ti.com>	<4DDF4E4D.6060008@ti.com>	<BANLkTi=dHknRn5KJSh3_bG-o19BUg2AjrA@mail.gmail.com> <87vcww5gvo.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36045 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133Ab1E0PGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 May 2011 11:06:18 -0400
In-Reply-To: <87vcww5gvo.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: Govindraj <govindraj.ti@gmail.com>, "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>

Hi Kevin,

On 5/27/2011 4:59 PM, Hilman, Kevin wrote:
> Govindraj<govindraj.ti@gmail.com>  writes:

[...]

>> uart->oh->flags |= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET;
>>
>
> This is a hack (written by me) because the UART driver is not runtime PM
> adapted.  When UART driver is runtime PM adapted, this will not be
> needed.

The UART can support reset and idle? There is no assumption for the UART 
used during the early debug phase?
Don't we have to maintain its state?
It will be indeed better if we don't have to.

Regards,
Benoit
