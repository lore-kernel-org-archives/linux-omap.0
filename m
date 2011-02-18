From: Felipe Balbi <balbi@ti.com>
Subject: Re: watchdog pdev id set to -1
Date: Fri, 18 Feb 2011 12:56:35 +0200
Message-ID: <20110218105635.GB10489@legolas.emea.dhcp.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC3560870370061699@dbde02.ent.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:55121 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751094Ab1BRK4l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 05:56:41 -0500
Received: by bwz15 with SMTP id 15so676859bwz.5
        for <linux-omap@vger.kernel.org>; Fri, 18 Feb 2011 02:56:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870370061699@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Koyamangalath, Abhilash" <abhilash.kv@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

(your lines are over 80-characters, fix it)

On Fri, Feb 18, 2011 at 04:11:11PM +0530, Koyamangalath, Abhilash wrote:
> There this boot-time message (on both omap3 and am3517 evms atleast):
> [    1.904418] omap_device: omap_wdt.-1: new worst case activate
> latency 0: 6105
> 
> omap_init_wdt() initializes the id to -1 and then omap_device_build()
> is called with this value; this eventually calls
> platform_device_register() with a pdev having id as -1. I don't see
> any code that checks for this -1 and changes it to a non-erroneous
> value.
> 
> Perhaps there is a reason I've failed to notice?  Please comment.
> Else I'm planning to submit a patch which fixes this.

That's not an error value. If you have a -1 ID, you're only telling the
kernel "this is only omap_wdt platform_device I have", which means that
it will look in sysfs as:

/sys/devices/platform/omap_wdt/

if you have an ID >= 0, it will look as:

/sys/devices/platform/omap_wdt.0/
/sys/devices/platform/omap_wdt.1/
/sys/devices/platform/omap_wdt.2/

etc, that's all.

-- 
balbi
