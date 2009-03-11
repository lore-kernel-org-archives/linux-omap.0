From: Juha Yrjola <juha.yrjola@solidboot.com>
Subject: Re: [PATCH] ARM: OMAP: Fix GPIO switch initial output state	handling
Date: Wed, 11 Mar 2009 13:35:01 +0200
Message-ID: <49B7A1E5.9060403@solidboot.com>
References: <1236677181-16601-1-git-send-email-ext-jani.1.nikula@nokia.com>	 <c236f0530903100725jf214fa3m7f4063e727366eb4@mail.gmail.com> <1236762213.2365.64.camel@jani-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from solidboot.com ([92.48.122.80]:48341 "EHLO rei.solidboot.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753946AbZCKLeX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Mar 2009 07:34:23 -0400
In-Reply-To: <1236762213.2365.64.camel@jani-desktop>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: ext Kainan Cha <thezha@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Jani Nikula wrote:

>> INIT_HIGH indicates the state of the gpio, not the state of the
>> switch. Why not ignore the OMAP_GPIO_SWITCH_FLAG_INVERTED all together
>> when setting up the switch. This way, the user does not have to think
>> twice. :)
> 
> The INVERTED flag can't be ignored, since sw->state must be the opposite
> of the GPIO if the flag is set. The only question is, should INIT_HIGH
> flag refer to the GPIO or the switch.
> 
> I did think about this, and the patch is as I intended it to be, i.e.
> INIT_HIGH refers to the switch. I thought this would be less confusing.
> If INVERTED is set, it's inverted *everywhere* - why not also when
> setting the initial value?

How about INIT_ACTIVE to reduce possible confusion? HIGH does imply an 
electrical level, as opposed to a more abstract activation level.

Cheers,
Juha
