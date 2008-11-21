From: pavan_savoy@indiatimes.com
Subject: Re: Place-Holder for a driver
Date: Sat, 22 Nov 2008 02:20:38 +0530 (IST)
Message-ID: <1782749650.243661227300638226.JavaMail.root@mbv7.indiatimes.com>
References: <20081121203435.GH31944@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from omta1.indiatimes.com ([203.199.93.122]:35737 "HELO
	omta1.indiatimes.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1751838AbYKUUww (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 15:52:52 -0500
In-Reply-To: <20081121203435.GH31944@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org

Hi,

The drivers/bluetooth folder as I've observed has mostly the transport layer of bluetooth devices. Say an USB driver or an Serial Line discipline driver or PCMCIA.

My thought was based on something like hp-wmi laptop input driver for wireless LAN, Bluetooth devices on the laptop.

So it is logical ?

regards,
Pavan


----- Original Message -----
From: Felipe Balbi <me@felipebalbi.com>
To: pavan savoy <pavan_savoy@indiatimes.com>
Cc: linux-omap@vger.kernel.org
Sent: Sat, 22 Nov 2008 02:04:35 +0530 (IST)
Subject: Re: Place-Holder for a driver

On Sat, Nov 22, 2008 at 01:34:37AM +0530, pavan_savoy@indiatimes.com wrote:
> Hi,
> 
> The OMAP Zoom2 board has a bluetooth chip which needs to be enabled to be used. When running on Android, the Bluetooth service of Android uses the rfkill sysfs entry to turn on bluetooth.
> 
> So I linked the Bluetooth enable GPIO to the sys-fs entry, Now the question is where should/does this driver fit in ?
> 
> I've thought of drivers/misc, Any suggestions are welcome.

how about drivers/bluetooth ??

-- 
balbi



--
The New Maruti A-Star is here. View pics, videos, read expert opinion and more on ZigWheels.com
http://images.zigwheels.com/b2cam/a_star.html
