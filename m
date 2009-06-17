From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: Re: [PATCH] TWL4030: Reset header file to mainline
Date: Wed, 17 Jun 2009 17:11:37 +0300
Message-ID: <20090617141137.GJ6374@everest>
References: <1245238182-11697-1-git-send-email-amit.kucheria@verdurent.com> <4A38F387.1050502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f212.google.com ([209.85.220.212]:47212 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764316AbZFQORp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 10:17:45 -0400
Received: by fxm8 with SMTP id 8so338264fxm.37
        for <linux-omap@vger.kernel.org>; Wed, 17 Jun 2009 07:17:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A38F387.1050502@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: linux-omap@vger.kernel.org

On 09 Jun 17, Eugeny S. Mints wrote:
> Amit Kucheria wrote:
>> Reset twl4030.h to what is upstream. Patches to restore twl4030_power
>> functionality will follow directly to lkml.
>>
>>   
> development against upstream is great. But what will be left for
> this mail list if we send all patches directly to lkml?

I think the idea is that (and Tony should correct me here if I'm wrong)
core OMAP code is handled here while peripheral drivers will all go
directly to their respective susbsystem maintainers upstream.

-- 
-------------------------------------------------------------------------
Amit Kucheria,				 Kernel Developer, Verdurent
-------------------------------------------------------------------------
