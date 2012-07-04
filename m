From: Daniel Mack <zonque@gmail.com>
Subject: Re: Current state of AM33xx patches
Date: Wed, 04 Jul 2012 13:22:09 +0200
Message-ID: <4FF42761.2000701@gmail.com>
References: <4FD5BA4C.9070706@gmail.com> <CBFB6F19.95320%jkridner@gmail.com> <79CD15C6BA57404B839C016229A409A83EA5361A@DBDE01.ent.ti.com> <4FE326A8.8090807@gmail.com> <4FE8AB37.7030907@gmail.com> <4FE9A00B.6010908@ti.com> <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com> <4FEC7394.9030208@gmail.com> <79CD15C6BA57404B839C016229A409A83EA5FBC1@DBDE01.ent.ti.com> <4FEDF54D.4030609@gmail.com> <alpine.DEB.2.00.1206291938180.2338@utopia.booyaka.com> <4FEEC7F2.8070507@gmail.com> <alpine.DEB.2.00.1207040403010.6760@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA635DC@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47148 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771Ab2GDLWP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 07:22:15 -0400
Received: by bkwj10 with SMTP id j10so2513128bkw.19
        for <linux-omap@vger.kernel.org>; Wed, 04 Jul 2012 04:22:13 -0700 (PDT)
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA635DC@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Nori, Sekhar" <nsekhar@ti.com>, Jason Kridner <jkridner@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Hernandez, Carlos" <ceh@ti.com>, "Maupin, Chase" <chase.maupin@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kridner, Jason" <jdk@ti.com>, "N, Mugunthan V" <mugunthanvnm@ti.com>

On 04.07.2012 12:50, Hiremath, Vaibhav wrote:
> On Wed, Jul 04, 2012 at 15:37:31, Paul Walmsley wrote:
>> On Sat, 30 Jun 2012, Daniel Mack wrote:
>>
>>> Ok, thanks for the explaining this. For now, I'll add hwmod stubs for
>>> the components I need.
>>
>> Hmm.  Which drivers are you working on?  Vaibhav Hiremath has hwmod data 
>> for the AM33xx.  There might be some missing integration code to build the 
>> devices for the newer IP blocks, though.
>>
> 
> I would also be interested to know more here.
> 
> 
>>> Btw, has anyone yet worked on getting the MDIO/EMAC driver merged?
>>
>> Mainline has:
>>
>> drivers/net/ethernet/ti/davinci_emac.c
> 
> Not required for AM335X.
> 
>> drivers/net/ethernet/ti/davinci_mdio.c
>>
>> Those might work for you.
>>
> 
> Few more files,
> 
> drivers/net/ethernet/ti/cpsw.c
> drivers/net/ethernet/ti/davinci_cpdma.c
> 
> 
> Wanted to highlight one point,
> You still have to add platform device code to get it working.

Exactly. And a hwmod binding for DT. Do you have patches for that?


Daniel
