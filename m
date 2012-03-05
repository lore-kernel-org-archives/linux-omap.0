From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: Ethernet problems on AM3517, possible regression?
Date: Mon, 05 Mar 2012 13:38:53 +0200
Message-ID: <4F54A5CD.4070603@compulab.co.il>
References: <1330488712.31452.YahooMailNeo@web125205.mail.ne1.yahoo.com> <1330536469.53752.YahooMailNeo@web125203.mail.ne1.yahoo.com> <1330621988.48456.YahooMailNeo@web125202.mail.ne1.yahoo.com> <1330643793.82609.YahooMailNeo@web125204.mail.ne1.yahoo.com> <4F5338CB.5000804@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:43518
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756780Ab2CELjE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 06:39:04 -0500
In-Reply-To: <4F5338CB.5000804@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: CF Adad <cfadad@rocketmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On 03/04/12 11:41, Igor Grinberg wrote:
> Hi,
> 
> On 03/02/12 01:16, CF Adad wrote:
>> We have both a CompuLab CM-T3517 and a Technexion TAM-3517 at the shop.  Both boards provide dual Ethernet support in an identical fashion.  One port uses the onboard EMAC tied to an SMSC LAN87xx series PHY.  The other is the old trusty SMSC LAN911X hooked up to the GPMC.
>>
>> Both boards support both interfaces when loaded with their respective TI PSP-based images.  These unfortunately date clear back to 2.6.37 or even 2.6.32 however.  When upgrading to the 3.x series linux-omap kernel, we noticed we could get one or the other of these to work, _but not both simultaneously_.  If both are enabled in code, neither work.
>>
>> Even when we can get one or the other working, we seem to be having some problems with autonegotiation and MAC addressing.  MAC addresses on the SMSC are still random.  On the EMAC port, as you can see from our code below, we have put a patch in that is letting us establish a fixed MAC address.  However, I'm not sure this is a proper method to use at this point.
>>
>> We suspect issues are known to exist with the Ethernet ports as the CM-T3517 has mainlined Linux support, and its latest board file does not show any configuration for either Ethernet interface.  Support from the previous kernel versions has apparently been removed, despite patches being applied to it as recently as mid-last year:  http://lists.infradead.org/pipermail/linux-arm-kernel/2011-May/050430.html
>>
>> We also suspect this is being caused by an address conflict of some sort between the two ports.  We are using a linux-omap kernel, version 3.2.0-rc6 that is a month or two old now.  We've been monitoring this list, and have noted that some changes have been checked in for SMSC, but have not been able to update our kernel source as we were in the midst of a heavy debugging exercise that ended late last evening.  We plan to migrate to the latest HEAD soon.  Neverthelss, we've not seen any of these board files update.  So, we're assuming there are still known issues here.
>>
>> I have attached the relevant sections of the board file we've created 
>> for the TAM-3517 (the one we've played with the most) below.  It is based off the 
>> older board files from the TI PSP and various configurations we have seen in similar hardware
>>  board files (overo, am3517_evm, cm-t3517, etc.)  If you note the 
>> configurable defines at the top, we've tied various combinations of code
>>  with no success to date.
>>
>>
>> Would you folks please take a look?  Any help would be appreciated.  Thanks!
> 
> The below two patches are needed to make the AM3517 EMAC work on CM-T3517:
> 
> http://www.spinics.net/lists/linux-omap/msg65642.html
> http://www.spinics.net/lists/linux-omap/msg65643.html
> 
> Hopefully, Tony will be kind enough to apply those for 3.4

Also, this one is needed for EMAC to function on any OMAP board:
http://www.spinics.net/lists/linux-omap/msg62161.html

It looks from the thread, that it has been already taken by Paul,
so hopefully, it will be in 3.4


-- 
Regards,
Igor.
