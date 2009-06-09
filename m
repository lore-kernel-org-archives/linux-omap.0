From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/3] OMAP3:WDT:Enable IVA, SECURE and minor bugfixes
Date: Tue, 09 Jun 2009 11:16:38 -0700
Message-ID: <87ws7lw9vd.fsf@deeprootsystems.com>
References: <1244495293-17244-1-git-send-email-ubh@ti.com>
	<87r5xtzcsg.fsf@deeprootsystems.com>
	<00695C9C8F8B4448856F48142B4AA201BD76FE8C@dnce02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:49214 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756349AbZFISQj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Jun 2009 14:16:39 -0400
Received: by pzk1 with SMTP id 1so187239pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 09 Jun 2009 11:16:41 -0700 (PDT)
In-Reply-To: <00695C9C8F8B4448856F48142B4AA201BD76FE8C@dnce02.ent.ti.com> (Ulrik Bech Hald's message of "Tue\, 9 Jun 2009 20\:02\:40 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hald, Ulrik Bech" <ubh@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Hald, Ulrik Bech" <ubh@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> Sent: Tuesday, June 09, 2009 9:45 AM
>> To: Hald, Ulrik Bech
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH 0/3] OMAP3:WDT:Enable IVA, SECURE and minor bugfixes
>> 
>> Ulrik Bech Hald <ubh@ti.com> writes:
>> 
>> > This patch series enables support for IVA and SECURE
>> > WDTs, available on omap34xx.
>> > For omap34xx devices the WDT will be accessible
>> > (when present) through:
>> > SECURE:	       /dev/watchdog1
>> > MPU:	       /dev/watchdog2
>> > IVA:	       /dev/watchdog3
>> >
>> > For devices older than omap34xx only MPU WDT is present
>> > and will be accessible through /dev/watchdog
>> 
>> I think you should make the MPU WDT the first one since it will always
>> be present.
>
> The reason, why I numbered them as above, is to make them match the OMAP34xx TRM WDT numbering scheme, where SECURE WDT=WDT1, MPU WDT=WDT2 and IVA WDT=WDT3. My thought was that it would introduce more confusion to change the numbers in /dev/ to something else, although I did consider your point.
> Do you still think I should change the numbers?

Yes.  Personally, I don't think the TRM should influence userspace
visible nodes in this case.

I would rather see the watchdog that exists on all platforms be the
first one.

Kevin

