From: linux@johnea.net
Subject: Re: Which git to clone for testing prior to submitting bugs?
Date: Mon, 01 Oct 2012 14:16:01 -0700
Message-ID: <506A0811.1050400@johnea.net>
References: <50648AA2.2010004@johnea.net> <CAOCHtYitbhOMv+YBaYgdTuYZQpZ_VLoP=QKVS=spmqPxEUkATA@mail.gmail.com> <5064A173.5000909@johnea.net> <CAOCHtYh2DofNoLx1W6ZWy4aKNpQx10P9AbmWbj1yeY1G=ixHPg@mail.gmail.com> <CAOCHtYiido11MG55m601CX2isYJ2oFcubgJ7Wkng=HnkT_DdcQ@mail.gmail.com> <5064B41D.9030709@johnea.net> <CAOCHtYjjczpQ0oJ4zgrExdF7C-OAsfzMLwAEfdExkFG2uiUKgw@mail.gmail.com> <5065F13E.8070306@johnea.net> <CAOCHtYg3zrqO+3Rk6P8K7iit7uO9g4_YHQ870TXbmuEPZEyQ0Q@mail.gmail.com> <5065FE7C.9070503@johnea.net> <5069AF54.3000001@johnea.net> <CAOCHtYh4nCU0nBSk2XtbH3ZW4-J2EQoG61f4fOKsz66981ud6w@mail.gmail.com> <5069CB71.4030106@johnea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from johnea.net ([70.167.123.7]:56055 "EHLO mail.johnea.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904Ab2JAVQE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Oct 2012 17:16:04 -0400
Received: from [192.168.1.143] (wsip-70-166-88-164.sd.sd.cox.net [70.166.88.164])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.johnea.net (Postfix) with ESMTPSA id 96D9C73F188B
	for <linux-omap@vger.kernel.org>; Mon,  1 Oct 2012 14:16:02 -0700 (PDT)
In-Reply-To: <5069CB71.4030106@johnea.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On 10/01/2012 09:57 AM, linux@johnea.net wrote:
> On 10/01/2012 09:50 AM, Robert Nelson wrote:
>> You guys are very close... Your "config-3.5.4-archarm-3" config just
>> needed one more change:
>>
>> CONFIG_PANEL_TFP410=m ->   CONFIG_PANEL_TFP410=y
>

That did it! We've got X running on BeagleboardxM DVI with 3.5.4.

We're also starting testing of 3.6.0 this afternoon, since it's official now. Although the main thing for my application was having buddy=spidev and working DVI video in the same kernel, which we now have with 3.5.4.

Thank you again Robert for your patient support!

johnea
