From: Tony Lindgren <tony@atomide.com>
Subject: Re: omap35x mmc support
Date: Wed, 4 Mar 2009 10:34:00 -0800
Message-ID: <20090304183359.GO6784@atomide.com>
References: <dbdb2ea60903030751u773b8a82x1ec9b8a5886b0672@mail.gmail.com> <200903031559.26946.david-b@pacbell.net> <49AE4791.2080202@nokia.com> <dbdb2ea60903040600k5e6464d9o9fefd8ab2796680f@mail.gmail.com> <49AE8EEE.6020501@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55653 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757257AbZCDSeN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 13:34:13 -0500
Content-Disposition: inline
In-Reply-To: <49AE8EEE.6020501@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: twebb <taliaferro62@gmail.com>, David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>

* Adrian Hunter <adrian.hunter@nokia.com> [090304 06:25]:
> twebb wrote:
>>> For MMC3 this patch:
>>>
>>>   http://lkml.org/lkml/2009/1/27/101
>>>
>>> seems to be missing.
>>>
>>
>> Thanks.  Would this patch be applicable whether MMC3 is functioning as
>> SD or MMC or SDIO interface?
>
> Yes
>
>> And on a bit of a tangent (but relevant to the link you provided),
>> what's the logic behind so many OMAP24XX references being used in
>> OMAP34XX (and even 35xx) code?  I'm sure there's a good reason; but
>> being new to using an OMAP processor (35xx), I'm just curious what it
>> is.  It gets confusing, particularly without knowing the reasoning
>> behind it.
>
> It is just code reuse.  OMAP2 comes out so things are coded for OMAP2.
> Then OMAP3 comes out, and anything that is the same is reused.

Yeah from maintenance point of view we need to recycle code. Otherwise
we would already have something like six copies of the I2C controller,
four copies of the DMA controller, three different clock frameworks
and so on..

Tony
