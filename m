From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [DSPBRIGDE PATCH 6/6] dsp: bridge: beautify erro path
Date: Mon, 31 Aug 2009 14:50:30 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A5EF2E1F@dlee06.ent.ti.com>
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
 <5ec8ebd50908290018r670b6480pe311bb0812587d3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36964 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301AbZHaTuh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Aug 2009 15:50:37 -0400
In-Reply-To: <5ec8ebd50908290018r670b6480pe311bb0812587d3b@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>


Hi,

>-----Original Message-----
>From: Andy Shevchenko [mailto:andy.shevchenko@gmail.com]
>Sent: Saturday, August 29, 2009 2:19 AM
>To: Guzman Lugo, Fernando
>Cc: Felipe Balbi; Hiroshi DOYU; Ameya Palande; Linux OMAP Mailing List
>Subject: Re: [DSPBRIGDE PATCH 6/6] dsp: bridge: beautify erro path
>
>On Sat, Aug 29, 2009 at 1:31 AM, Guzman Lugo, Fernando<x0095840@ti.com>
>wrote:
>
>>>result = status, isn't is?
>>>or change status to result on previous lines.
>> Yes, we need to assigned status to result, in order to report the error,
>however I think we can get rid of result and use status instead, what do
>you think?
>
>As far as I see this is not the dsp status but just a word to collect
>errors. More logical in this piece of your code is to use result word
>instead of status.

Maybe you did not see far enough, but variable initStatus it the one use to store DSPBridge errors, the variable status is use to collect the status from calls to kernel functions. So I think we don't need two variables to collect error from kernel, so we should use one, it could be status or results it does not matters. What do you think?

Regards,
Fernando.

>
>--
>With Best Regards,
>Andy Shevchenko

