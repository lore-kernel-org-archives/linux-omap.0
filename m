From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: omap35x mmc support
Date: Wed, 04 Mar 2009 16:23:42 +0200
Message-ID: <49AE8EEE.6020501@nokia.com>
References: <dbdb2ea60903030751u773b8a82x1ec9b8a5886b0672@mail.gmail.com>	 <200903031559.26946.david-b@pacbell.net> <49AE4791.2080202@nokia.com> <dbdb2ea60903040600k5e6464d9o9fefd8ab2796680f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61874 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbZCDOX7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 09:23:59 -0500
In-Reply-To: <dbdb2ea60903040600k5e6464d9o9fefd8ab2796680f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>

twebb wrote:
>> For MMC3 this patch:
>>
>>   http://lkml.org/lkml/2009/1/27/101
>>
>> seems to be missing.
>>
> 
> Thanks.  Would this patch be applicable whether MMC3 is functioning as
> SD or MMC or SDIO interface?

Yes

> And on a bit of a tangent (but relevant to the link you provided),
> what's the logic behind so many OMAP24XX references being used in
> OMAP34XX (and even 35xx) code?  I'm sure there's a good reason; but
> being new to using an OMAP processor (35xx), I'm just curious what it
> is.  It gets confusing, particularly without knowing the reasoning
> behind it.

It is just code reuse.  OMAP2 comes out so things are coded for OMAP2.
Then OMAP3 comes out, and anything that is the same is reused.

