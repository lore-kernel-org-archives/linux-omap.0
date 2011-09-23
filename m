From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/5 v11] mfd: omap: usb: Runtime PM support for EHCI and OHCI drivers
Date: Fri, 23 Sep 2011 11:44:42 -0700
Message-ID: <87ty83f691.fsf@ti.com>
References: <1316691479-1849-1-git-send-email-keshava_mgowda@ti.com>
	<CACVXFVOoHM14AqqH0CSpwNPef1QL+7MtgZOQZhYVSdgA=5KR4g@mail.gmail.com>
	<CAP05o4L5h5J7YBupH2KJJ5Bbmdq+a78Z_OORETtnLj59ZtSZJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:50598 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750736Ab1IWSot (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 14:44:49 -0400
In-Reply-To: <CAP05o4L5h5J7YBupH2KJJ5Bbmdq+a78Z_OORETtnLj59ZtSZJw@mail.gmail.com>
	(Keshava Munegowda's message of "Thu, 22 Sep 2011 19:06:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: Ming Lei <tom.leiming@gmail.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, b-cousson@ti.com, paul@pwsan.com, balbi@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com

"Munegowda, Keshava" <keshava_mgowda@ti.com> writes:

> On Thu, Sep 22, 2011 at 7:02 PM, Ming Lei <tom.leiming@gmail.com> wrote:
>> Hi,
>>
>> On Thu, Sep 22, 2011 at 7:37 PM, Keshava Munegowda
>> <keshava_mgowda@ti.com> wrote:
>>> From: Keshava Munegowda <Keshava_mgowda@ti.com>
>>>
>>> The Hwmod structures and Runtime PM features are implemented
>>> For EHCI and OHCI drivers of OMAP3 and OMAP4.
>>> The global suspend/resume of EHCI and OHCI
>>> is validated on OMAP3430 sdp board with these patches.
>>>
>>> These patches are re-based to Kevin's pm branch :
>>> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
>>
>> Is kernel.org up now? :-)
>>
>> thanks,
>> --
>> Ming Lei
>
>
> no!
>
> its kevin tree, which  i took it 3 weeks back. :-(
>

There shouldn't be any reason to base these patches on my tree.  You
should be using a current mainline.

Kevin
