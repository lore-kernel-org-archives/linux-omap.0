From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: Current state of AM33xx patches
Date: Thu, 2 Aug 2012 17:37:51 +0200
Message-ID: <98DC2F80-9AD6-4A65-8FA8-3B2AABF72692@dominion.thruhere.net>
References: <4FD5BA4C.9070706@gmail.com> <4FE326A8.8090807@gmail.com> <4FE8AB37.7030907@gmail.com> <4FE9A00B.6010908@ti.com> <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com> <4FEC7394.9030208@gmail.com> <79CD15C6BA57404B839C016229A409A83EA5FBC1@DBDE01.ent.ti.com> <4FEDF54D.4030609@gmail.com> <alpine.DEB.2.00.1206291938180.2338@utopia.booyaka.com> <4FEEC7F2.8070507@gmail.com> <alpine.DEB.2.00.1207040403010.6760@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA635DC@DBDE01.ent.ti.com> <4FF42761.2000701@gmail.com> <EB1619762EAF8B4E97A227FB77B7E0293E9C2548@DBDE01.ent.ti.com> <500CEF97.4050207@gmail.com> <EB1619762EAF8B4E97A227FB77B7E0293E9D04EB@DBDE01.ent.ti.com> <501159C3.3020109@gmail.com> <704C899A-606B-41A3-99E8-6D92C0EA5BC5@dominion.thruhere.net> <50116926.4060309@gmail
 .com> <587C7FB9-2DD3-48EE-B74D-BEBDF199BE23@dominion.thruhere.net> <50118272.1050209@gmail.com> <9F9237B3-55BD-471B-ADD1-1A18F3644387@dominion.thruhere.net> <501A9D1C.8080305@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64089 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab2HBPh5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 11:37:57 -0400
Received: by eeil10 with SMTP id l10so2435713eei.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Aug 2012 08:37:55 -0700 (PDT)
In-Reply-To: <501A9D1C.8080305@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "N, Mugunthan V" <mugunthanvnm@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>, "Nori, Sekhar" <nsekhar@ti.com>, Jason Kridner <jkridner@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Hernandez, Carlos" <ceh@ti.com>, "Maupin, Chase" <chase.maupin@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kridner, Jason" <jdk@ti.com>


Op 2 aug. 2012, om 17:30 heeft Daniel Mack <zonque@gmail.com> het volgende geschreven:

> On 31.07.2012 21:29, Koen Kooi wrote:
> 
>> 2/3 of the way there:
>> 
>> http://patchwork.ozlabs.org/patch/174085/
>> http://patchwork.ozlabs.org/patch/174086/
>> 
>> I keep failing to create a .dts that doesn't upset the dtc, so I don't have it working yet :(
> 
> Yes, that's because there are couple of sytax errors in the example
> bindings.

Not only that, it's actually missing params and other params are wrong. See my non-constructive rant in the commit message: http://dominion.thruhere.net/koen/angstrom/beaglebone/0001-beaglebone-add-broken-cpsw-DT.patch

But I still can't get it working:

root@beaglebone:~# dmesg | grep -i cpsw
[   13.504425] net eth0: initializing cpsw version 1.12 (0)

root@beaglebone:~# dmesg | grep -i phy 
[    0.000000] Booting Linux on physical CPU 0
[    0.228496] nop_usb_xceiv phy.17: transceiver type USB2 PHY already exists
[   13.512056] libphy: PHY davinci_mdio-0:00 not found
[   13.517168] net eth0: phy davinci_mdio-0:00 not found on slave 0
[   13.523516] libphy: PHY davinci_mdio-0:01 not found
[   13.528675] net eth0: phy davinci_mdio-0:01 not found on slave 1

root@beaglebone:~# ifconfig -a | grep eth
eth0      Link encap:Ethernet  HWaddr 00:04:9F:01:1B:B8  

> Mugunthan, could you repost these patches and at least copy
> devicetree-discuss@lists.ozlabs.org and the ARM kernel mailing list? I
> can't comment on the patches you sent to netdev@vger.kernel.org because
> I'm not currently subscribed to that list.


Same here, I'm only on l-o, but I guess I'll need to subscribe dt-discuss in the near future :)

regards,

Koen