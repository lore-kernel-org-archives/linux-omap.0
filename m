From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: MUSB Host problems
Date: Wed, 10 Jun 2009 07:15:25 -0600
Message-ID: <4A2FB1ED.5090006@mlbassoc.com>
References: <4A2E9FD5.9090807@mlbassoc.com> <FCCFB4CDC6E5564B9182F639FC35608702F52BB6F3@dbde02.ent.ti.com> <4A2EA9CA.7070900@mlbassoc.com> <FCCFB4CDC6E5564B9182F639FC35608702F52BB72D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:4311 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754160AbZFJNP0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Jun 2009 09:15:26 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702F52BB72D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Pandita, Vikram wrote:
> 
>> -----Original Message-----
>> From: Gary Thomas [mailto:gary@mlbassoc.com]
>> Sent: Tuesday, June 09, 2009 1:28 PM
>> To: Pandita, Vikram
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: MUSB Host problems
>>
>> Pandita, Vikram wrote:
>>>> -----Original Message-----
>>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Gary
>>>> Thomas
>>>> Sent: Tuesday, June 09, 2009 12:46 PM
>>>> To: linux-omap@vger.kernel.org
>>>> Subject: MUSB Host problems
>>>>
>>>> I'm trying to get MUSB Host working on my 3530 platform (very
>>> Based on your description, its not MUSB but the USBHOST EHCI block that you want to get working.
>> Sorry, mistaken terminology.  Yes, I'm trying to get the host ECHI working.
>>
>>>> similar to the Beagle).  When I startup, I get this message:
>>>>  Clock usbhost_48m_fck didn't enable in 100000 tries
>>> This is bad
>> Why?  What does it mean?  How do I fix it?
> 
> The ehci driver on linux-omap works for Beagleboard and sdp.
> so this may not be a fatal problem
> 
>>>> What does this mean?  How do I fix it?
>>>>
>>>> Currently, the USB subsystem finds the various hubs (ports 0-2).
>>>> The OTG port (0) works great.  When I plug in a device to USB-1,
>>> Is this a full speed device?
>>>
>>>> it sees it, but immediately gives up :-(
>>>>    ehci-omap ehci-omap.0: GetStatus port 1 status 001803 POWER sig=j CSC CONNECT
>>>>    hub 1-0:1.0: port 1: status 0501 change 0001
>>>>    hub 1-0:1.0: state 7 ports 3 chg 0002 evt 0000
>>>>    hub 1-0:1.0: port 1, status 0501, change 0000, 480 Mb/s
>>>>    ehci-omap ehci-omap.0: port 1 full speed --> companion
>>> Looks like your device is getting recognized as a full speed.
>>> So EHCI cannot handle it.
>> Odd, this is a high speed device (USB 2.0).  I also tried a 2.0 hub, same result.
>> What could confuse it like this?
> 
> Is it PHY mode or TLL mode?
> If its PHY: then the transceiver used definitely matters.
> SDP has ISP1504 and
> Beagle board has SMSC phy
> 
> The 60Mhz clock is fed from omap into the Transceiver (Input clocking mode).
> Only few phy's in market support this.
>  
>>> You need to have OHCI driver built in which is not present in linux-omap code base.
>> Do, how does one use an arbitrary device on the EHCI port?  Must I use a 2.0 hub?
>>
>>>>    ehci-omap ehci-omap.0: GetStatus port 1 status 003801 POWER OWNER sig=j CONNECT
>>>>    hub 1-0:1.0: port 1 not reset yet, waiting 50ms
>>>>    ehci-omap ehci-omap.0: GetStatus port 1 status 003002 POWER OWNER sig=se0 CSC
>>>>    hub 1-0:1.0: unable to enumerate USB device on port 1
>>>>    hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0002
>>>>    hub 1-0:1.0: hub_suspend
>>>> Then it's dead.  Any ideas?
>> Note: this is unproven hardware, I'm mostly looking for ideas on
>> how to troubleshoot the problems.
> 
> Have one side working: 
> Say have EHCI working on SDP/Beagle and then connect your device to it.

As I said, unproven hardware.  It turns out the PHY was [hardware
strapping] set in the wrong mode.  Fixing this and all seems to work.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
