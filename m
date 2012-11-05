From: John Tobias <john.tobias.ph@gmail.com>
Subject: Re: hdmi on 4430 (kernel 3.4)
Date: Mon, 5 Nov 2012 14:11:29 -0800
Message-ID: <CACUGKYOrHUWvBzQkqNQ+mrCug9VfhvCMc8uLusvXozWxDHkEig@mail.gmail.com>
References: <32739C29-CEEA-481C-B070-1754E3CA94C8@studiofuga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43184 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933111Ab2KEWL3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 17:11:29 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so8796008iea.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Nov 2012 14:11:29 -0800 (PST)
In-Reply-To: <32739C29-CEEA-481C-B070-1754E3CA94C8@studiofuga.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Federico Fuga <ml@studiofuga.com>
Cc: linux-omap@vger.kernel.org

You need to contact your TI sales rep or tech support to sign an NDA
to get the HDMI documentation. Also, take note that your company
should be listed in HDMI.org in order the TI releases the said
document.

regards,

john

On Mon, Nov 5, 2012 at 1:59 PM, Federico Fuga <ml@studiofuga.com> wrote:
> Hi Everybody,
>
> I am working on a custom OMAP4430 board with HDMI support. I am using the latest omapzoom ubuntu-integration kernel (3.4.0-1487.6)
> I tested the same on the pandaboard with the same cpu, with the same result. Both are lacking the "HDMI Companion chip" (U6 on pandaboard with 4430), because on our custom board we don't need EDID support (we are using an HDMI to VGA chip converter), for testing purpose it was removed from the pandaboard.
> I am unable to make HDMI working.
> I was assured that this kernel is correctly working with HDMI on pandaboard, so I'd guess that the problem is due to the missing edid, but I am not 100% sure.
> For simplicity, I removed the DVI configuration on the panda board file, by removing the DVI display configuration, and changing the default device to HDMI.
> The hdmi interface seems to be configured correctly , the overlay/manager/display chain is correctly setup and enabled, but no signal is detected by the monitor, and the screen is black.
> No errors are present in the logs - I'll send a copy of it with omapdss.debug=y tomorrow, eventually.
> I wanted to check the HDMI registers, but I didn't find the hdmi registers table on the TRM.
> Does someone have some hint, comment or previous experience on that?
> Where can I find the hdmi registers list on the manual or other documentation?
> Note that as far as i know, the 2.6.35 kernel was working correctly (I can't check right now, unfortunately).
> Thank you.
>
> best regards
>
>
> Federico Fuga
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
