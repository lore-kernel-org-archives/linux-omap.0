From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Thu, 1 Nov 2012 03:51:18 -0400
Message-ID: <CAORVsuXHxqhcTHv8Y=8gw4N+0+rx+N91bh971zK-TmcsrTu5nQ@mail.gmail.com>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
	<alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
	<CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
	<20121025101212.GD21217@arwen.pp.htv.fi>
	<20121026201539.GD29548@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
	<20121029200032.GD30152@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
	<20121030123254.GD29095@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
	<20121030125419.GG29095@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com>
	<CAORVsuWqoqrza-qrJskpMTj=2MW6JxNEhVzjWVXkM1mpqVO8cQ@mail.gmail.com>
	<87fw4u3oh5.fsf@deeprootsystems.com>
	<CAORVsuUWD3gHh1NcMLeGwZ=hF=UiOG2VyJkADZNcGVr1g1TFgQ@mail.gmail.com>
	<alpine.DEB.2.00.1211010242001.6693@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61094 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab2KAHvT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Nov 2012 03:51:19 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3242890iea.19
        for <linux-omap@vger.kernel.org>; Thu, 01 Nov 2012 00:51:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1211010242001.6693@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Felipe Balbi <balbi@ti.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Paul,

On Wed, Oct 31, 2012 at 10:44 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Wed, 31 Oct 2012, Jean Pihet wrote:
>
>> Paul,
>> Could you please check with the 2 calls to PM QoS from the I2C code
>> commented out? This will rule out the PM QoS impact.
>
> Will be happy to do a test run for you, after the boot log from your local
> test run is posted:
>
> http://marc.info/?l=linux-arm-kernel&m=135167153510814&w=2

As said earlier [1] the test has been done already. I did check the
boot messages and tried to read/write the RTC. All test were
successfull and the only difference in the logs was the absence of the
I2C timeout messages.
I can redo the tests and provide a log but that will not happen before Saturday.

[1] http://marc.info/?l=linux-omap&m=135161909714517&w=2

Regards,
Jean

>
>
> - Paul
