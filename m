From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: What does the DSPBRIDGE do?
Date: Thu, 13 Aug 2009 12:49:33 +0300
Message-ID: <4A83E1AD.5020303@nokia.com>
References: <436C2ED5-B3D9-419D-88C1-9CDE693E8F30@mac.com> <4A83C3AD.6000908@nt.tu-darmstadt.de> <9B5783D4-1503-4B19-8126-721EA0714BC6@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:44101 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771AbZHMJuv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 05:50:51 -0400
In-Reply-To: <9B5783D4-1503-4B19-8126-721EA0714BC6@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Elvis Dowson <elvis.dowson@mac.com>
Cc: Vladimir Pantelic <pan@nt.tu-darmstadt.de>, Linux OMAP Users <linux-omap@vger.kernel.org>

Hi Elvis,

ext Elvis Dowson wrote:
> Hi Vladimir,
> 	
> On Aug 13, 2009, at 11:41 AM, Vladimir Pantelic wrote:
> 
>> Elvis Dowson wrote:
>>> Hi,
>>> 	I was wondering what the DSPBRIDGE does?
>> it allows the arm to load/run code on the dsp
> 
> And this code would be compiled and linked using the ti dsp compiler?  
> what role will the arm gcc compiler play, when using ti dsp compiler?
> 
> Are there some examples this?
> 
> Best regards,
> 
> Elvis
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

I guess you need TI compiler only for compiling Codes which run on DSP, rest of
the stuff can be compiled using arm-gcc.

Cheers,
Ameya.
