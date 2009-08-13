From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: What does the DSPBRIDGE do?
Date: Thu, 13 Aug 2009 12:41:46 +0300
Message-ID: <4A83DFDA.3000405@nokia.com>
References: <436C2ED5-B3D9-419D-88C1-9CDE693E8F30@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:41630 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbZHMJnj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 05:43:39 -0400
In-Reply-To: <436C2ED5-B3D9-419D-88C1-9CDE693E8F30@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Elvis Dowson <elvis.dowson@mac.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

ext Elvis Dowson wrote:
> Hi,
>     I was wondering what the DSPBRIDGE does?
> 
It is an interface between ARM core and DSP core. You can use the bridge
to load firmware into DSP, control its execution and allow data communication,
e.g. MP3 stream input and PCM data output.

> I've used TI code composer studio in the past, and was wondering if that 
> compiler is required to compile programs for the DSP available on the TI 
> OMAP 3530.
> 
> In terms of compiler infrastructure, can the current arm gcc tools be 
> used for both the arm core and the dsp part? Or do you need to use TI 
> CCS for the dsp part?
> 
you need separate compiler (i.e. CCS) to build code for DSP (i.e. CODECs). DSP 
will have C5000 or C6000 core (C64x in case of 3530) and not ARM core.

ARM gcc is used only to build the Linux DSPbridge driver.

> Best regards,
> 
> Elvis
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
