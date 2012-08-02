From: Daniel Mack <zonque@gmail.com>
Subject: Re: Current state of AM33xx patches
Date: Thu, 02 Aug 2012 19:19:16 +0200
Message-ID: <501AB694.5090304@gmail.com>
References: <4FD5BA4C.9070706@gmail.com> <4FE9A00B.6010908@ti.com> <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com> <4FEC7394.9030208@gmail.com> <79CD15C6BA57404B839C016229A409A83EA5FBC1@DBDE01.ent.ti.com> <4FEDF54D.4030609@gmail.com> <alpine.DEB.2.00.1206291938180.2338@utopia.booyaka.com> <4FEEC7F2.8070507@gmail.com> <alpine.DEB.2.00.1207040403010.6760@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA635DC@DBDE01.ent.ti.com> <4FF42761.2000701@gmail.com> <EB1619762EAF8B4E97A227FB77B7E0293E9C2548@DBDE01.ent.ti.com> <500CEF97.4050207@gmail.com> <EB1619762EAF8B4E97A227FB77B7E0293E9D04EB@DBDE01.ent.ti.com> <501159C3.3020109@gmail.com> <704C899A-606B-41A3-99E8-6D92C0EA5BC5@dominion.thruhere.net> <50116926.4060309@gmail.com> <587C7FB9-2DD3-48EE-B74D-BEBDF199BE23@dominion.thruh
 ere.net> <50118272.1050209@gmail.com> <9F9237B3-55BD-471B-ADD1-1A18F3644387@dominion.thruhere.net> <501A9D1C.8080305@gmail.com> <98DC2F80-9AD6-4A65-8FA8-3B2AABF72692@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:56835 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495Ab2HBRTX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 13:19:23 -0400
Received: by bkwj10 with SMTP id j10so4360406bkw.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Aug 2012 10:19:21 -0700 (PDT)
In-Reply-To: <98DC2F80-9AD6-4A65-8FA8-3B2AABF72692@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>, "N, Mugunthan V" <mugunthanvnm@ti.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>, "Nori, Sekhar" <nsekhar@ti.com>, Jason Kridner <jkridner@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Hernandez, Carlos" <ceh@ti.com>, "Maupin, Chase" <chase.maupin@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kridner, Jason" <jdk@ti.com>

On 02.08.2012 17:37, Koen Kooi wrote:
> Not only that, it's actually missing params and other params are
> wrong. See my non-constructive rant in the commit message:
> http://dominion.thruhere.net/koen/angstrom/beaglebone/0001-beaglebone-add-broken-cpsw-DT.patch
>
>  But I still can't get it working:
> 
> root@beaglebone:~# dmesg | grep -i cpsw [   13.504425] net eth0:
> initializing cpsw version 1.12 (0)
> 
> root@beaglebone:~# dmesg | grep -i phy [    0.000000] Booting Linux
> on physical CPU 0 [    0.228496] nop_usb_xceiv phy.17: transceiver
> type USB2 PHY already exists [   13.512056] libphy: PHY
> davinci_mdio-0:00 not found [   13.517168] net eth0: phy
> davinci_mdio-0:00 not found on slave 0 [   13.523516] libphy: PHY
> davinci_mdio-0:01 not found [   13.528675] net eth0: phy
> davinci_mdio-0:01 not found on slave 1

That is because the davinci_mdio driver is not yet probed from DT. I
hooked up bindings to that driver and also had to augment the clock
definitions, but that's giving me an "external abort on non-linefetch"
at boot time. Most probably because there's something missing in the
clock setup. Not sure whether I should debug that any further or if
anyone has patches for that.

Mugunthan, how did you test your DT bindings? Could you push your entire
tree somewhere maybe for others to have a look at it? I have no problem
helping you in any way, I just want to know where we currently are.


Thanks for you work,
Daniel
