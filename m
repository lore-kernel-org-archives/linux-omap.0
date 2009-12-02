From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] power_supply: Add driver for TWL4030/TPS65950 BCI
 charger
Date: Thu, 3 Dec 2009 00:31:56 +0200
Message-ID: <20091202223156.GA14921@nokia.com>
References: <1259333060-24277-1-git-send-email-notasas@gmail.com>
 <20091202173321.GA23738@nokia.com>
 <6ed0b2680912021234x6b5e6058p6d50d5cd20ecf019@mail.gmail.com>
 <20091202204946.GB25682@nokia.com>
 <6ed0b2680912021329g372bd0a4vb5b4a80244960f95@mail.gmail.com>
 <20091202215442.GA30658@oksana.dev.rtsoft.ru>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755848AbZLBWcY@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091202215442.GA30658@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: ext Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Madhusudhan Chikkature <madhu.cr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Wed, Dec 02, 2009 at 10:54:42PM +0100, ext Anton Vorontsov wrote:
>As for the default USB VBUS current value, it could be Kconfig
>option (something alike to USB_GADGET_VBUS_DRAW) and/or module
>parameter, or hw default, or hardcoded for now. Either will
>work.

cannot be Kconfig, it's mandated by usb battery charging spec 1.x to be 
100mA for 100ms, then if you don't enumerate, you have to cut charging.

>
>-- 
>Anton Vorontsov
>email: cbouatmailru@gmail.com
>irc://irc.freenode.net/bd2

-- 
balbi
