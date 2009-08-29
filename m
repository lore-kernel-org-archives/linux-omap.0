From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [DSPBRIGDE PATCH 6/6] dsp: bridge: beautify erro path
Date: Sat, 29 Aug 2009 10:18:41 +0300
Message-ID: <5ec8ebd50908290018r670b6480pe311bb0812587d3b@mail.gmail.com>
References: <1250850219-25545-1-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-2-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-3-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-4-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-5-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-6-git-send-email-felipe.balbi@nokia.com>
	 <1250850219-25545-7-git-send-email-felipe.balbi@nokia.com>
	 <496565EC904933469F292DDA3F1663E602A5EF29FB@dlee06.ent.ti.com>
	 <5ec8ebd50908281413j139f01a8q25c9e9c4339e5a25@mail.gmail.com>
	 <496565EC904933469F292DDA3F1663E602A5EF2A6D@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:58656 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbZH2HSk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Aug 2009 03:18:40 -0400
Received: by ey-out-2122.google.com with SMTP id 25so550655eya.19
        for <linux-omap@vger.kernel.org>; Sat, 29 Aug 2009 00:18:41 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602A5EF2A6D@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <x0095840@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Sat, Aug 29, 2009 at 1:31 AM, Guzman Lugo, Fernando<x0095840@ti.com> wrote:

>>result = status, isn't is?
>>or change status to result on previous lines.
> Yes, we need to assigned status to result, in order to report the error, however I think we can get rid of result and use status instead, what do you think?

As far as I see this is not the dsp status but just a word to collect
errors. More logical in this piece of your code is to use result word
instead of status.

-- 
With Best Regards,
Andy Shevchenko
