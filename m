From: Mohamed Thalib H <hmthalib@gmail.com>
Subject: Re: Is there boot logo support for OMAP3530?
Date: Thu, 05 May 2011 15:32:15 +0530
Message-ID: <4DC275A7.5000701@gmail.com>
References: <4DC1155E.4050109@gmail.com> <2CD7187C-26DA-4C63-B854-4127547C519D@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37649 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488Ab1EEKCR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 06:02:17 -0400
Received: by pwi15 with SMTP id 15so912859pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 03:02:17 -0700 (PDT)
In-Reply-To: <2CD7187C-26DA-4C63-B854-4127547C519D@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: linux-omap@vger.kernel.org

Hi Elvis,

Thanks for the information..

On Wednesday 04 May 2011 04:44 PM, Elvis Dowson wrote:
> Hi,
>
> On May 4, 2011, at 12:59 PM, Mohamed Thalib H wrote:
>> Is boot logo not supported in OMAP3530?
> There are two ways you can add a boot logo to your target platform (Overo or BeagleBoard), one is to modify u-boot so that a boot logo is display immediately after powering on the system. The other is to add the boot logo to the kernel, in which case you have run 'make menuconfig', go to Device Drivers ->  Graphics ->  OMAP 2/3 display subysystem and somewhere in those options, you will see a boot logo option.
>
> I prefer the u-boot option. The standard Overo distribution images have the linux boot option (you'll see a penguin on boot)
I was missing some options in the kernel config. after setting those I 
can see the penguin on boot.
> To embed your logo within u-boot, you will need to modify the Denx u-boot sources. v2010.06 works from the denx git repo. I had some issues with v2011.03 with the Overo.
>
> http://git.denx.de/?p=u-boot.git;a=summary
>
> What you will need to do is to use the linux gimp program to open a boot logo image file and save it as a C header file.
>
> After that, you can copy the *header_data array to the logo.h file for the target board; and adjust the beagle/overo_width and beagle/overo_height values to correctly reflect to your logo image size.
Thanks for this pointer, I really need this since the logo can be shown 
very earlier.
> Elvis Dowson
Best Regards,
Mohamed Thalib H
