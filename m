From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: Current state of AM33xx patches
Date: Thu, 2 Aug 2012 22:20:03 +0200
Message-ID: <CD3817A1-B8A3-4E13-816F-58DC02C4D28F@dominion.thruhere.net>
References: <4FD5BA4C.9070706@gmail.com> <4FE9A00B.6010908@ti.com> <79CD15C6BA57404B839C016229A409A83EA5B7FD@DBDE01.ent.ti.com> <4FEC7394.9030208@gmail.com> <79CD15C6BA57404B839C016229A409A83EA5FBC1@DBDE01.ent.ti.com> <4FEDF54D.4030609@gmail.com> <alpine.DEB.2.00.1206291938180.2338@utopia.booyaka.com> <4FEEC7F2.8070507@gmail.com> <alpine.DEB.2.00.1207040403010.6760@utopia.booyaka.com> <79CD15C6BA57404B839C016229A409A83EA635DC@DBDE01.ent.ti.com> <4FF42761.2000701@gmail.com> <EB1619762EAF8B4E97A227FB77B7E0293E9C2548@DBDE01.ent.ti.com> <500CEF97.4050207@gmail.com> <EB1619762EAF8B4E97A227FB77B7E0293E9D04EB@DBDE01.ent.ti.com> <501159C3.3020109@gmail.com> <704C899A-606B-41A3-99E8-6D92C0EA5BC5@dominion.thruhere.net> <50116926.4060309@gmail.com> <587C7FB9-2DD3-48EE-B74D-BEBDF199BE23@dominion.thruh
 ere.net> <50118272.1050209@gmail.com> <9F9237B3-55BD-471B-ADD1-1A18F3644387@dominion.thruhere.net> <501A9D1C.8080305@gmail.com> <98DC2F80-9AD6-4A65-8FA8-3B2AABF72692@dominion.thruhere.net> <501ADB89.4030405@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39262 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399Ab2HBUUL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 16:20:11 -0400
Received: by eaac11 with SMTP id c11so1024372eaa.19
        for <linux-omap@vger.kernel.org>; Thu, 02 Aug 2012 13:20:06 -0700 (PDT)
In-Reply-To: <501ADB89.4030405@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: "N, Mugunthan V" <mugunthanvnm@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>, "Nori, Sekhar" <nsekhar@ti.com>, Jason Kridner <jkridner@gmail.com>, Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "Hernandez, Carlos" <ceh@ti.com>, "Maupin, Chase" <chase.maupin@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Kridner, Jason" <jdk@ti.com>


Op 2 aug. 2012, om 21:56 heeft Daniel Mack <zonque@gmail.com> het volgende geschreven:

> On 02.08.2012 17:37, Koen Kooi wrote:
>> But I still can't get it working:
>> 
>> root@beaglebone:~# dmesg | grep -i cpsw [   13.504425] net eth0:
>> initializing cpsw version 1.12 (0)
>> 
>> root@beaglebone:~# dmesg | grep -i phy [    0.000000] Booting Linux
>> on physical CPU 0 [    0.228496] nop_usb_xceiv phy.17: transceiver
>> type USB2 PHY already exists [   13.512056] libphy: PHY
>> davinci_mdio-0:00 not found [   13.517168] net eth0: phy
>> davinci_mdio-0:00 not found on slave 0 [   13.523516] libphy: PHY
>> davinci_mdio-0:01 not found [   13.528675] net eth0: phy
>> davinci_mdio-0:01 not found on slave 1
>> 
>> root@beaglebone:~# ifconfig -a | grep eth eth0      Link
>> encap:Ethernet  HWaddr 00:04:9F:01:1B:B8
> 
> Ok, I got it up and and running now on my board using the two
> davinci_mdio drivers and the hwmod addition I just posted.
> 
> With those applied on top of Mugunthan work, I can link my cpsw slave
> with the phy id "davinci_mdio.18-:04", but the 18 is just the global
> device counter which will change again once I add more devices. That
> still needs some cleanup.
> 
> Anyway, at least I can boot into my NFS root now :) Koen, can you try
> this on your board and see if that works for you as well?

[koen@Angstrom-F16-vm-rpm kernel]$ git diff
diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index ac7fab5..c33a05d 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -33,6 +33,11 @@
                };
        };
 
+       mdio: davinci_mdio@4a101000 {
+               compatible = "ti,davinci-mdio";
+               ti,hwmods = "davinci_mdio";
+       };
+
        mac: ethernet@4A100000 {
                compatible = "ti,cpsw";
                ti,hwmods = "cpgmac0";
@@ -49,19 +54,13 @@
                no_bd_ram = <0>;
                rx_descs = <64>;
                mac_control = <0x20>;
-               slaves = <2>;
+               slaves = <1>;
                slave@0 {
                        slave_reg_ofs = <0x208>;
                        sliver_reg_ofs = <0xd80>;
-                       phy_id = "davinci_mdio-0:00";
+                       phy_id = "davinci_mdio.21-:00";
                        mac-address = [00 04 9F 01 1B B8];
                };
-               slave@1 {
-                       slave_reg_ofs = <0x308>;
-                       sliver_reg_ofs = <0xdc0>;
-                       phy_id = "davinci_mdio-0:01";
-                       mac-address = [00 04 9F 01 1B B9];
-               };
        };
 };


leads to:

[   14.127177] net eth0: initializing cpsw version 1.12 (0)
[   14.135038] net eth0: phy found : id is : 0x7c0f1
[   17.871215] libphy: davinci_mdio.21-:00 - Link is Up - 100/Full

So you can add my Tested-by: to the patches if you want :)

regards,

Koen