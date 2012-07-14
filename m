From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC RESEND 1/4] arm/dts: OMAP: Add timer nodes
Date: Sat, 14 Jul 2012 09:01:21 -0500
Message-ID: <50017BB1.8010702@gmail.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com> <1342218413-30116-2-git-send-email-jon-hunter@ti.com> <5000D647.4090200@gmail.com> <alpine.DEB.2.00.1207140048210.3876@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50875 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab2GNOB1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Jul 2012 10:01:27 -0400
Received: by obbuo13 with SMTP id uo13so6487815obb.19
        for <linux-omap@vger.kernel.org>; Sat, 14 Jul 2012 07:01:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207140048210.3876@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Benoit Cousson <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, device-tree <devicetree-discuss@lists.ozlabs.org>

On 07/14/2012 01:56 AM, Paul Walmsley wrote:
> Hi
> 
> On Fri, 13 Jul 2012, Rob Herring wrote:
> 
>> I'm not sure this is really a good use of aliases. UARTs use aliases 
>> because it is important that the UART number to tty number is known and 
>> fixed. IIUC, as an example you are picking timer1 because it has 
>> properties X, Y and Z. If so, then you should describe those h/w 
>> properties within the timer nodes so you can pick which timer to use 
>> based on it's h/w properties.
> 
> Some GPTIMER blocks have input and output signals that can be routed to 
> external package balls.  So it's possible that some application may need 
> to request a specific timer ID, since that timer would be connected to a 
> specific off-chip device.

Yes, I understand that. So you should be describing which ones have i/o
and what they are connected to. The PWM binding is probably a starting
point.

Rob

> 
> 
> - Paul
> 


