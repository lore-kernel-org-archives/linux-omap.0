From: David Anders <x0132446@ti.com>
Subject: Re: BeagleBoard stops at booting kernel with 2.6.37-rc5
Date: Thu, 16 Dec 2010 14:32:39 -0600
Message-ID: <4D0A7767.6070209@ti.com>
References: <D76728EE-7818-4236-83E9-B32045714912@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55923 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756484Ab0LPUcl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 15:32:41 -0500
In-Reply-To: <D76728EE-7818-4236-83E9-B32045714912@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Elvis,

please enable "earlyprintk" in your kernel config and add "earlyprintk" 
to your boot args. this will provide a more detailed boot log even if 
the tty is incorrect.

Dave

On 12/16/2010 02:19 PM, Elvis Dowson wrote:
> Hi,
>          I'm working with linux mainline 2.6.37-rc5 and my custom beagleboard based platform stops at booting the kernel. Is there a fix for this?
>
> reading uImage
>
> 2432692 bytes read
> Booting from mmc ...
> ## Booting kernel from Legacy Image at 82000000 ...
>     Image Name:   Linux-2.6.37-rc5
>     Image Type:   ARM Linux Kernel Image (uncompressed)
>     Data Size:    2432628 Bytes =  2.3 MB
>     Load Address: 80008000
>     Entry Point:  80008000
>     Verifying Checksum ... OK
>     Loading Kernel Image ... OK
> OK
>
> Starting kernel ...
>
> Uncompressing Linux... done, booting the kernel.
>
>
> Elvis Dowson
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>    

