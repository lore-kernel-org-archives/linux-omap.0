From: Michael Crowe <michael.crowe@compunetix.com>
Subject: RE: OMAP3 EVM kernel
Date: Tue, 8 May 2012 18:10:16 +0000
Message-ID: <1F1FC0DBF7F44B49B17A82F8FDE9635C1E36BA@EXCH2.compunet.local>
References: <1F1FC0DBF7F44B49B17A82F8FDE9635C1E2909@EXCH2.compunet.local>
 <20120508161416.4c5343cf@wker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exch1.compunetix.com ([198.144.40.9]:48613 "EHLO
	exch1.compunetix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2EHSKS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 14:10:18 -0400
In-Reply-To: <20120508161416.4c5343cf@wker>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Thank you...you are correct, Sir.  I changed the console to ttyO0 and now have output.  I am having issues trying to mount the RFS that is on the MMC card but have not fully investigated that issue yet.

I would still really like to see a OMAP3_EVM .config file if anyone has one available.

Thanks,
--Mike


-----Original Message-----
From: Anatolij Gustschin [mailto:agust@denx.de] 
Sent: Tuesday, May 08, 2012 10:14 AM
To: Michael Crowe
Cc: linux-omap@vger.kernel.org
Subject: Re: OMAP3 EVM kernel

On Tue, 8 May 2012 13:36:47 +0000
Michael Crowe <michael.crowe@compunetix.com> wrote:
...                                                                              
> 3944336 bytes read                                                               
> ## Booting kernel from Legacy Image at 80200000 ...                              
>    Image Name:   Linux-3.4.0-rc2+                                                
>    Image Type:   ARM Linux Kernel Image (uncompressed)                           
>    Data Size:    3944272 Bytes =  3.8 MB                                         
>    Load Address: 80008000                                                        
>    Entry Point:  80008000                                                        
>    Verifying Checksum ... OK                                                     
>    Loading Kernel Image ... OK                                                   
> OK                                                                               
>                                                                                  
> Starting kernel ...                                                              
>                                                                                  
> Uncompressing Linux... done, booting the kernel.

Your kernel is probably booting, but without serial console output. What does U-Boot pass as the serial console parameter? If something like "console=ttySx"
then it might be the issue. With this recent kernel try passing "console=ttyOx"
instead (where 'x' is the UART number).

HTH,
Anatolij
