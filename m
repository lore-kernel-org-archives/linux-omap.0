From: Michael Trimarchi <michael@panicking.kicks-ass.org>
Subject: hub 2-0:1.0: port 2 disabled by hub (EMI?), re-enabling...
Date: Fri, 20 Nov 2009 22:25:34 +0100
Message-ID: <4B07094E.8020707@panicking.kicks-ass.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ms01.sssup.it ([193.205.80.99]:53535 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754365AbZKTVZd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Nov 2009 16:25:33 -0500
Received: from [193.205.82.7] (HELO gandalf.sssup.it)
  by sssup.it (CommuniGate Pro SMTP 4.1.8)
  with ESMTP-TLS id 55300366 for linux-omap@vger.kernel.org; Fri, 20 Nov 2009 22:05:13 +0100
Received: from [10.30.3.179] ([10.30.3.179])
	by gandalf.sssup.it (8.12.10/8.12.10) with ESMTP id nAKLPYeI028292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 22:25:38 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

I'm working on a overo board + a palo43 daughter board. I connect a camera to hit with the following result:

hub 2-0:1.0: port 2 disabled by hub (EMI?), re-enabling...                      
usb 2-2: USB disconnect, address 16                                             
gspca: disconnect complete 
usb 2-2: new high speed USB device using ehci-omap and address 16               
usb 2-2: New USB device found, idVendor=05a9, idProduct=a538                    
usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0               
usb 2-2: Product: OV538 USB camera-013008-1                                     
usb 2-2: Manufacturer: OmniVision Application Team                              
usb 2-2: configuration #1 chosen from 1 choice                                  
gspca: probing 05a9:a538                                                        
ov538: sensor is ov7691                                                         
gspca: probe ok  

every time...
This sometimes happen and simetimes in some boot is ok. But when I start some transaction
I have similar problem write packet on the usb device. Can you have any idea?

Michael
