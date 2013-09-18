From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 1/2] ARM: dts: Fix muxing and regulator for wl12xx on
 the SDIO bus for pandaboard
Date: Wed, 18 Sep 2013 11:04:32 +0200
Message-ID: <52396CA0.6030100@baylibre.com>
References: <20130913190811.24617.97699.stgit@localhost> <20130913190953.24617.46506.stgit@localhost> <1379399214.4223.123.camel@porter.coelho.fi> <1379399290.4223.124.camel@porter.coelho.fi> <20130918000203.GS9994@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:51503 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab3IRJEl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Sep 2013 05:04:41 -0400
Received: by mail-bk0-f41.google.com with SMTP id na10so2763190bkb.0
        for <linux-omap@vger.kernel.org>; Wed, 18 Sep 2013 02:04:40 -0700 (PDT)
In-Reply-To: <20130918000203.GS9994@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Luca Coelho <luca@coelho.fi>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, Paolo Pisati <p.pisati@gmail.com>, linux-omap@vger.kernel.org

Hi Tony,

On 18/09/2013 02:02, Tony Lindgren wrote:
> * Luca Coelho <luca@coelho.fi> [130916 23:35]:
>> On Tue, 2013-09-17 at 09:26 +0300, Luca Coelho wrote:
>>> Both patches look good to me, though I didn't have the time to retest
>>> them.
>>
>> Actually I don't even have a Blaze device anymore, so I can't really
>> test the second patch. :(
>
> OK no problem, I've tested it on panda es.

Do we have someone out-there that still own a Blaze?

Anyway, I'm about to send a DTS fix branch for -rc2, so I'll include 
these two patches.

Thanks,
Benoit


