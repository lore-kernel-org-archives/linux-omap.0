From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 0/5] OMAP: RX51: Add LCD Panel Support for N900
Date: Wed, 07 Apr 2010 08:38:12 +0300
Message-ID: <1270618692.2447.39.camel@tubuntu.research.nokia.com>
References: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com>
	 <87pr2datft.fsf@small.ssi.corp> <4BBB03F2.5050706@nokia.com>
	 <87iq84cnzg.fsf@small.ssi.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54719 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab0DGFiw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 01:38:52 -0400
In-Reply-To: <87iq84cnzg.fsf@small.ssi.corp>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Arnaud Ebalard <arno@natisbad.org>
Cc: "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

On Tue, 2010-04-06 at 22:41 +0200, ext Arnaud Ebalard wrote:

> 
> For the records, just in case someone wants to do the same, I had to
> use: 
> 
>    /sbin/getty 115200 tty0 -n -l /bin/sh
> 
> I also had to set CONFIG_KEYBOARD_TWL4030 to get the keyboard
> working. Any reason for that option not be enabled by default in
> rx51_defconfig?
> 
> Additionally, after something like 25 seconds, the screen goes black and
> the device stops. Any clue? Can be panel realted?

I'm guessing here, but it could be the HW watchdog kicking in if by
"device stops" you mean that serial etc also stops. Although it should
reboot, not stop...

 Tomi


