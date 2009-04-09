From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: 2.6.29 and SDP3430 [needs CSL2008q3]
Date: Thu, 09 Apr 2009 07:51:20 -0500
Message-ID: <49DDEF48.5040903@gmail.com>
References: <782515bb0904082345j2a44da65s909a6834bab07330@mail.gmail.com> <20090409100343.71d34c16.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:23622 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933683AbZDIMvZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Apr 2009 08:51:25 -0400
Received: by yx-out-2324.google.com with SMTP id 31so626721yxl.1
        for <linux-omap@vger.kernel.org>; Thu, 09 Apr 2009 05:51:23 -0700 (PDT)
In-Reply-To: <20090409100343.71d34c16.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>

Jarkko Nikula said the following on 04/09/2009 02:03 AM:
> On Thu, 9 Apr 2009 08:45:00 +0200
> ext Nishanth Menon <menon.nishanth@gmail.com> wrote:
>
>   
>> just messing around with tony's master branch on SDP3430, just did a
>> defconfig and a build with  2007q3-51 codesourcery compiler, I see it
>> hang around:
>>
>>     
> Kernels built with this compiler stuck into delay loop calibration.
> No idea why, but 2008q3-66 was working for me.
>   

Thanks guys..(though I wonder why exactly wont 2007q3 no longer work..
some sort of compiler bug which got fixed later??)..
Regards,
Nishanth Menon
