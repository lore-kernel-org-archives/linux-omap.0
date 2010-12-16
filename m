From: Nishanth Menon <nm@ti.com>
Subject: Re: BeagleBoard hangs at Bluetooth subsystem startup with 2.6.37-rc6
 mainline
Date: Thu, 16 Dec 2010 15:23:20 -0600
Message-ID: <4D0A8348.1020800@ti.com>
References: <BB0B74AC-F93E-4C02-A720-E74213EAE9BC@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:50221 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753305Ab0LPVXZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Dec 2010 16:23:25 -0500
Received: by mail-yw0-f48.google.com with SMTP id 7so2151884ywo.35
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 13:23:25 -0800 (PST)
In-Reply-To: <BB0B74AC-F93E-4C02-A720-E74213EAE9BC@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Elvis Dowson had written, on 12/16/2010 03:13 PM, the following:
> Hi,
>        I just updated to mainline linux kernel 2.6.37-rc6, and built a new omap3-console-image recipe based rootfs using OE.
> 
> I get the following error with Bluetooth. I've disabled bluetooth in the kernel and do not have a bluetooth device connected to the custom beagleboard platform. With earlier rootfs builds it used to progress beyond this stage, even though bluetooth wasn't detect.
> 
> Now it hangs at this point:
> 
> Starting syslogd/klogd: done
>  * Starting Avahi mDNS/DNS-SD Daemon: avahi-daemon                       [ ok ]
> Starting Bluetooth subsystem:
> Can't get port settings: Input/output error
> Can't initialize device: Input/output error
This belongs to OE ML - http://wiki.openembedded.net/index.php/Mailing_lists

-- 
Regards,
Nishanth Menon
