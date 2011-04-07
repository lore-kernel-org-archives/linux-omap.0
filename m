From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: What is missing from musb - linux-omap merge?
Date: Thu, 7 Apr 2011 18:31:41 +0530
Message-ID: <254aac705c536b59ed64c6db922c1124@mail.gmail.com>
References: <20110406162334.8dcb5a7d.jhnikula@gmail.com> <b84bb921d4bb8c258966c77406cc795b@mail.gmail.com>
 <20110407133452.afc188e1.jhnikula@gmail.com> <20110407113815.GA29038@legolas.emea.dhcp.ti.com>
 <4b3dcd4df940622c0f754669397c7482@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:54871 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751171Ab1DGNBy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Apr 2011 09:01:54 -0400
Received: by mail-fx0-f44.google.com with SMTP id 15so1624370fxm.3
        for <linux-omap@vger.kernel.org>; Thu, 07 Apr 2011 06:01:53 -0700 (PDT)
In-Reply-To: <4b3dcd4df940622c0f754669397c7482@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema Kalliguddi <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Jarkko Nikula <jhnikula@gmail.com>
Cc: OMAP Linux discussion <linux-omap@vger.kernel.org>

Hi,

>-----Original Message-----
>From: Hema Kalliguddi [mailto:hemahk@ti.com]
>Sent: Thursday, April 07, 2011 6:29 PM
>To: balbi@ti.com; Jarkko Nikula
>Cc: OMAP Linux discussion
>Subject: RE: What is missing from musb - linux-omap merge?
>
>>-----Original Message-----
>>From: Felipe Balbi [mailto:balbi@ti.com]
>>Sent: Thursday, April 07, 2011 5:08 PM
>>To: Jarkko Nikula
>>Cc: Hema Kalliguddi; OMAP Linux discussion; Felipe Balbi
>>Subject: Re: What is missing from musb - linux-omap merge?
>>
>>On Thu, Apr 07, 2011 at 01:34:52PM +0300, Jarkko Nikula wrote:
>>> Hi
>>>
>>> On Thu, 7 Apr 2011 14:38:06 +0530
>>> Hema Kalliguddi <hemahk@ti.com> wrote:
>>>
>>> > I tried the core retention with v2.6.39-rc1 with
>>OMAP3630Zoom3 board
>>> > and don't observe any issues. Core is transitioning to
>>retention without
>>> > any issue,
>>> > with or without musb driver loaded.
>>> >
>>> > But on OMAP3430SDP I am observing the crash when try to do
>>> > echo mem > /sys/power/state.
>>> >
>>> > Attached is the fix for this issue and core transitions to
>>retention.
>>> >
>>> Hmm.. suspend/resume are fine on Nokia N900 with and without
>>the patch.
>>> Patch also didn't fix the idle retention.
>>>
>>> > When you say retention is not working can you please
>carify what is
>>> > happening?
>>> > are you trying in idle path retention or suspend/resume?
>>> >
>>> Sorry not being verbose enough, I was testing the idle retention.
>>>
>>> For me it looks these differencies are explained by different
>>> bootloaders. As Kevin told they may leave MUSB in a wrong
>>state. Was it
>>> so that before hwmod conversion the musb did IP reset etc
>>and now this
>>> feature is missing? So I'm thinking is this problem a regression or
>>> missing feature after hwmod conversion?
>>
>Hwmod will take care of restting the ip if the SYSC_HAS_SOFTRESET
>sysc_flag
>is set. And it is being set in the hwmod structure of OMAP3.
>
>I tested both idle path and suspend/resume retention and works fine
>on OMAP3430SDP.

Tested with OMAP3630Zoom3 board not with 3430SDP.

>I am wondering what might be the problem with N900. Is it
>works if you do
>the
>ip reset in the musb driver?
>
>Regards,
>Hema
>
>>it's possibly a regression. I remember we had softreset before. Should
>>be fixed.
>>
>>--
>>balbi
>>
>
