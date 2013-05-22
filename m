From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 1/5] ARM: dts: OMAP2+: use #include for all device trees
Date: Wed, 22 May 2013 18:05:35 +0200
Message-ID: <519CECCF.2080405@epfl.ch>
References: <1369232864-14460-1-git-send-email-florian.vaussard@epfl.ch> <1369232864-14460-2-git-send-email-florian.vaussard@epfl.ch> <20130522154006.GB10378@atomide.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.218]:45947 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752176Ab3EVQFj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 May 2013 12:05:39 -0400
In-Reply-To: <20130522154006.GB10378@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

On 05/22/2013 05:40 PM, Tony Lindgren wrote:
> * Florian Vaussard <florian.vaussard@epfl.ch> [130522 07:33]:
>> Replace /include/ by #include for OMAP2+ DT, in order to use the
>> C pre-processor, making use of #define features possible.
>
> This is good, but let's use it with case. Probably the best use
> for this right now is to add defines for the mux modes from
> mach-omap2/mux.h as that makes the raw values readable without
> comments.
>

I think that one first good case is the IRQs in patch 5. But I
agree, adding defines for the mux modes would be great. I can have
a look at it for a v2.

Regards,

Florian
