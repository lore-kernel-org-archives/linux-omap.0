From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] musb: am35x: fix compile error due to control apis
Date: Thu, 30 Dec 2010 18:05:11 +0200
Message-ID: <20101230160511.GB2236@legolas.emea.dhcp.ti.com>
References: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com>
 <87hbe41kbd.fsf@gmail.com>
 <20101227092038.GB2301@legolas.emea.dhcp.ti.com>
 <877heriu1j.fsf@gmail.com>
 <20101230122738.GB3714@legolas.emea.dhcp.ti.com>
 <874o9vnw4h.fsf@gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:44329 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754515Ab0L3QFR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Dec 2010 11:05:17 -0500
Content-Disposition: inline
In-Reply-To: <874o9vnw4h.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, Dec 30, 2010 at 10:00:46AM -0500, Ben Gamari wrote:
>On Thu, 30 Dec 2010 14:27:38 +0200, Felipe Balbi <balbi@ti.com> wrote:
>> Yes. The patch is waiting for the merge window, check linux-next or
>> Greg's usb-next branch.
>>
>So I guess no working USB in 2.6.37 in that case?

For am35x, I guess not. All in all, it was a change to omap's arch code
which "broke" am35x in the first place. Well, the driver shouldn't be
using that header anyway.

-- 
balbi
