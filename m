From: jung songtan <jungsongtan@gmail.com>
Subject: Interval value set in RXINTERVAL register of MUSB?
Date: Tue, 12 Jan 2010 17:52:18 +0800
Message-ID: <c27069991001120152h7085aa5cu29121f12791f28aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f199.google.com ([209.85.221.199]:65258 "EHLO
	mail-qy0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939Ab0ALJ5b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 04:57:31 -0500
Received: by qyk37 with SMTP id 37so9286041qyk.18
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 01:57:30 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, linux-omap@vger.kernel.org

Hi Ajay and expert,

Can you correct me if my understanding has something wrong?


[Quote from usb 2.0 spec]
For full-/low-speed interrupt endpoints, the value of this field may
be from 1 to 255.
[Quote from usb 2.0 spec]

So, If a Low speed Interrupt IN endpoint, the endpoint->interval = 0x2.
Now I want to request data from the endpoint, I set RXINTERVAL = 0x2,
and start to request the data.(All the related register set as bellow)
If my understanding is correctly, one NAKTIMEOUT interrupt will happen
if the device responses NAK longer time than 2 frame, rigtht?

But in my case did not, the host pending on the request for the data,
and no TIMEOUT interrupt happen , can you tell me, where I am missed
or where am I wrong?

[Registers value ]

 RXCSR            0x20
 RXFUNCADDR 0x4
 RXHUBADDR   0x2
 RXHUBPORT   0x4
 RXMAXP          0x4
 RXINTERVAL   0x2

[Registers value ]
Thanks in advance,



-- 
K T Jung
