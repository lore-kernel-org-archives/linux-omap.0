From: David Hagood <david.hagood@gmail.com>
Subject: Re: Anyone built the kernel drivers for the PowerVR under
 linux-omap-2.6?
Date: Tue, 03 Mar 2009 06:27:25 -0600
Message-ID: <1236083245.7924.26.camel@surfer>
References: <c6ef7709f9373651496b2a32ca42f571.squirrel@localhost>
	 <1D24AF54-A1B5-4BFD-BBB3-09E1BB1F0A7F@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:41137 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZCCM1c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Mar 2009 07:27:32 -0500
Received: by wa-out-1112.google.com with SMTP id v33so1480685wah.21
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2009 04:27:29 -0800 (PST)
In-Reply-To: <1D24AF54-A1B5-4BFD-BBB3-09E1BB1F0A7F@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Tue, 2009-03-03 at 08:32 +0100, Koen Kooi wrote:
> In OpenEmbedded we have patches to a) get it to compile b) pick up  
> symbols so they actually insert and c) build against Tomi's DSS2
> 
> regards,

For various reasons I am not using OpenEmbedded, and while I had looked
at the OpenEmbedded pages I didn't immediately see how to apply what OE
had done to my setup.

It would be nice to have an explanation of what is needed that was a
little less "apply this opaque magic" and more "these are the steps
needed, in our environment this automates those steps."

I would also assert that it would be better in the long term if the
upstream maintainers (in this case TI) would correct the problems
themselves rather than requiring somebody like OE to work around them.


