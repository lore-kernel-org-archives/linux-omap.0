From: Ashwin Bihari <abihari@gmail.com>
Subject: Re: Kernel support of the Zoom OMAP35X Development kit
Date: Wed, 25 Mar 2009 13:53:45 -0400
Message-ID: <1f11a5490903251053v7f797a45i5509d1c965683e36@mail.gmail.com>
References: <49CA662B.6000104@balister.org>
	 <1f11a5490903251020o40ec542dyd44a2098c273a211@mail.gmail.com>
	 <20090325173341.GP8057@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:29029 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966AbZCYRxr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 13:53:47 -0400
Received: by yw-out-2324.google.com with SMTP id 5so139673ywb.1
        for <linux-omap@vger.kernel.org>; Wed, 25 Mar 2009 10:53:45 -0700 (PDT)
In-Reply-To: <20090325173341.GP8057@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Philip Balister <philip@balister.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Mar 25, 2009 at 1:33 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Ashwin Bihari <abihari@gmail.com> [090325 10:21]:
>> On Wed, Mar 25, 2009 at 1:13 PM, Philip Balister <philip@balister.org> wrote:
>> > I looked at the kit kernel and didn't see support for this board:
>> >
>> > http://www.logicpd.com/products/devkit/ti/zoom_omap3_development_kit
>> >
>> > What are my chances getting this board going with the Linux-omap git kernel?
>> >
>> > If that doesn't work, what boards give easy access to the GPMC pins and work
>> > with the linux-omap kernel?
>> >
>> > Philip
>> >
>>
>> Philip,
>>
>> We have support for the OMAP3530LV_SOM (the LogicPD DevKit in the
>> link) on 2.6.28-rc8. We have patches available against that particular
>> release of the Linux OMAP tree and that'll get you up to speed on the
>> SOM to do your work. Register yourself on the website and you should
>> get access to the patches there.
>
> How about send the board-*.c and other patches you have against the
> mainline kernel to this list so we can review them?
>
> Then let's queue them up for integration to the mainline kernel for
> the next merge window!
>
> Cheers,
>
> Tony
>

Tony,

We're trying to  move our stuff forward to the 2.6.29 tree and there's
probably more value in submitting patches against that as opposed to
2.6.28..

Regards

-- Ashwin
