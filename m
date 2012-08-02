From: Daniel Mack <zonque@gmail.com>
Subject: Re: Current state of AM33xx patches
Date: Thu, 02 Aug 2012 17:30:36 +0200
Message-ID: <501A9D1C.8080305@gmail.com>
References: <4FD5BA4C.9070706@gmail.com> <4FE326A8.8090807@gmail.com> <4FE8AB37.7030907@gmail.com> <4FE9A00B.6010908@ti.com> <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com> <4FEC7394.9030208@gmail.com> <79CD15C6BA57404B839C016229A409A83EA5FBC1@DBDE01.ent.ti.com> <4FEDF54D.4030609@gmail.com> <alpine.DEB.2.00.1206291938180.2338@utopia.booyaka.com> <4FEEC7F2.8070507@gmail.com> <alpine.DEB.2.00.1207040403010.6760@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA635DC@DBDE01.ent.ti.com> <4FF42761.2000701@gmail.com> <EB1619762EAF8B4E97A227FB77B7E0293E9C2548@DBDE01.ent.ti.com> <500CEF97.4050207@gmail.com> <EB1619762EAF8B4E97A227FB77B7E0293E9D04EB@DBDE01.ent.ti.com> <501159C3.3020109@gmail.com> <704C899A-606B-41A3-99E8-6D92C0EA5BC5@dominion.thruhere.net> <50116926.4060309@gmail
 .com> <587C7FB9-2DD3-48EE-B74D-BEBDF199BE23@dominion.thruhere.net> <50118272.1050209@gmail.com> <9F9237B3-55BD-471B-ADD1-1A18F3644387@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41529 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab2HBPao (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 11:30:44 -0400
Received: by bkwj10 with SMTP id j10so4312789bkw.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Aug 2012 08:30:43 -0700 (PDT)
In-Reply-To: <9F9237B3-55BD-471B-ADD1-1A18F3644387@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "N, Mugunthan V" <mugunthanvnm@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>, "Nori, Sekhar" <nsekhar@ti.com>, Jason Kridner <jkridner@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Hernandez, Carlos" <ceh@ti.com>, "Maupin, Chase" <chase.maupin@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kridner, Jason" <jdk@ti.com>

On 31.07.2012 21:29, Koen Kooi wrote:

> 2/3 of the way there:
> 
> http://patchwork.ozlabs.org/patch/174085/
> http://patchwork.ozlabs.org/patch/174086/
> 
> I keep failing to create a .dts that doesn't upset the dtc, so I don't have it working yet :(

Yes, that's because there are couple of sytax errors in the example
bindings. Mugunthan, could you repost these patches and at least copy
devicetree-discuss@lists.ozlabs.org and the ARM kernel mailing list? I
can't comment on the patches you sent to netdev@vger.kernel.org because
I'm not currently subscribed to that list.


Thanks,
Daniel

