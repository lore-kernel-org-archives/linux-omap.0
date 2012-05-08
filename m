From: Anatolij Gustschin <agust@denx.de>
Subject: Re: OMAP3 EVM kernel
Date: Tue, 8 May 2012 16:14:16 +0200
Message-ID: <20120508161416.4c5343cf@wker>
References: <1F1FC0DBF7F44B49B17A82F8FDE9635C1E2909@EXCH2.compunet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:56024 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437Ab2EHOO3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 10:14:29 -0400
In-Reply-To: <1F1FC0DBF7F44B49B17A82F8FDE9635C1E2909@EXCH2.compunet.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Crowe <michael.crowe@compunetix.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

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

Your kernel is probably booting, but without serial console output. What
does U-Boot pass as the serial console parameter? If something like "console=ttySx"
then it might be the issue. With this recent kernel try passing "console=ttyOx"
instead (where 'x' is the UART number).

HTH,
Anatolij
