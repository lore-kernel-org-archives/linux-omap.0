From: Daniel Mack <zonque@gmail.com>
Subject: Re: Current state of AM33xx patches
Date: Thu, 26 Jul 2012 16:52:51 +0200
Message-ID: <501159C3.3020109@gmail.com>
References: <4FD5BA4C.9070706@gmail.com> <CBFB6F19.95320%jkridner@gmail.com> <79CD15C6BA57404B839C016229A409A83EA5361A@DBDE01.ent.ti.com> <4FE326A8.8090807@gmail.com> <4FE8AB37.7030907@gmail.com> <4FE9A00B.6010908@ti.com> <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com> <4FEC7394.9030208@gmail.com> <79CD15C6BA57404B839C016229A409A83EA5FBC1@DBDE01.ent.ti.com> <4FEDF54D.4030609@gmail.com> <alpine.DEB.2.00.1206291938180.2338@utopia.booyaka.com> <4FEEC7F2.8070507@gmail.com> <alpine.DEB.2.00.1207040403010.6760@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA635DC@DBDE01.ent.ti.com> <4FF42761.2000701@gmail.com> <EB1619762EAF8B4E97A227FB77B7E0293E9C2548@DBDE01.ent.ti.com> <500CEF97.4050207@gmail.com> <EB1619762EAF8B4E97A227FB77B7E0293E9D04EB@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49632 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab2GZOw6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 10:52:58 -0400
Received: by wgbdr13 with SMTP id dr13so1887534wgb.1
        for <linux-omap@vger.kernel.org>; Thu, 26 Jul 2012 07:52:57 -0700 (PDT)
In-Reply-To: <EB1619762EAF8B4E97A227FB77B7E0293E9D04EB@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "N, Mugunthan V" <mugunthanvnm@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>, "Nori, Sekhar" <nsekhar@ti.com>, Jason Kridner <jkridner@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Hernandez, Carlos" <ceh@ti.com>, "Maupin, Chase" <chase.maupin@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kridner, Jason" <jdk@ti.com>

On 23.07.2012 18:36, N, Mugunthan V wrote:
>> On 05.07.2012 19:45, N, Mugunthan V wrote:

>>> I am working on DT support for cpsw and will be submitting the patch by
>>> July 20, 2012
>>
>> Just curious - have you made any progress on that yet?
>>
>  
> I have got the runtime PM support accepted to net-next, will be working on 
> and submitting DT support by this week.

I got these updates now via mainline, thanks for your work. Could you
give me some board code sniplet that makes that driver work for you? I'm
asking because I fail to see the "fck" clock that the driver requires.

I'm based on Linus' tree in the middle of the merge window, plus the
am335x-upstream-staging branch of
git://github.com/hvaibhav/am335x-linux.git - anything else I need to have?

Once I have network up and running, I can finally boot into a shell :)


Thanks,
Daniel
