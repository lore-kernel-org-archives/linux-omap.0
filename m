From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: DSS2 & V4L2
Date: Mon, 19 Apr 2010 07:18:41 -0600
Message-ID: <4BCC5831.4080909@mlbassoc.com>
References: <4BCC4CB0.7090607@mlbassoc.com> <7FBB6B9E-A996-46E8-945D-0DC04F06CF24@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:48774 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab0DSNSm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Apr 2010 09:18:42 -0400
In-Reply-To: <7FBB6B9E-A996-46E8-945D-0DC04F06CF24@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, hvaibhav@ti.com

On 04/19/2010 06:58 AM, Koen Kooi wrote:
>
> Op 19 apr 2010, om 14:29 heeft Gary Thomas het volgende geschreven:
>
>> I'm trying to get the DVSDK (3.01.00.03) working.  It uses
>> 2.6.32 + DSS2 + V4L2.
>>
>> What I'm having trouble with is how to configure/create/setup
>> a video overlay such that I get V4L2 device for the display.
>> In particular, what magic is required to create /dev/video1?
>
> The trick is usually "do not create>2 framebuffers". My understanding is that an overlay can either be a framebuffer or a v4l device, but not both.

That was it, thanks!

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
