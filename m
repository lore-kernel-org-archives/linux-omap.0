From: Michael Trimarchi <michael@panicking.kicks-ass.org>
Subject: Re: hub 2-0:1.0: port 2 disabled by hub (EMI?), re-enabling...
Date: Fri, 20 Nov 2009 23:11:12 +0100
Message-ID: <4B071400.8010600@panicking.kicks-ass.org>
References: <4B07094E.8020707@panicking.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ms01.sssup.it ([193.205.80.99]:41856 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754515AbZKTWLJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Nov 2009 17:11:09 -0500
Received: from [193.205.82.7] (HELO gandalf.sssup.it)
  by sssup.it (CommuniGate Pro SMTP 4.1.8)
  with ESMTP-TLS id 55300938 for linux-omap@vger.kernel.org; Fri, 20 Nov 2009 22:50:49 +0100
Received: from [10.30.3.179] ([10.30.3.179])
	by gandalf.sssup.it (8.12.10/8.12.10) with ESMTP id nAKMBDeI028591
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 23:11:13 +0100
In-Reply-To: <4B07094E.8020707@panicking.kicks-ass.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Michael Trimarchi wrote:
> Hi all,
> 
> I'm working on a overo board + a palo43 daughter board. I connect a 
> camera to hit with the following result:
> 
> hub 2-0:1.0: port 2 disabled by hub (EMI?), 
> re-enabling...                      usb 2-2: USB disconnect, address 
> 16                                             gspca: disconnect 
> complete usb 2-2: new high speed USB device using ehci-omap and address 
> 16               usb 2-2: New USB device found, idVendor=05a9, 
> idProduct=a538                    usb 2-2: New USB device strings: 
> Mfr=1, Product=2, SerialNumber=0               usb 2-2: Product: OV538 
> USB camera-013008-1                                     usb 2-2: 
> Manufacturer: OmniVision Application Team                              
> usb 2-2: configuration #1 chosen from 1 
> choice                                  gspca: probing 
> 05a9:a538                                                        ov538: 
> sensor is ov7691                                                         
> gspca: probe ok 
> every time...
> This sometimes happen and simetimes in some boot is ok. But when I start 
> some transaction
> I have similar problem write packet on the usb device. Can you have any 
> idea?

Ok I use isoc transfer to the sensor and I use a 2.6.29 kernel openembedded tree.

# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_OMAP_EHCI_PHY_MODE=y
# CONFIG_OMAP_EHCI_TLL_MODE is not set
CONFIG_USB_EHCI_ROOT_HUB_TT=y

Is there a part of the support patched where I can check?

Michael

> 
> Michael
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

