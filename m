From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] musb: am35x: fix compile error due to control apis
Date: Thu, 30 Dec 2010 19:14:42 +0300
Message-ID: <4D1CAFF2.5040408@ru.mvista.com>
References: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com> <87hbe41kbd.fsf@gmail.com> <20101227092038.GB2301@legolas.emea.dhcp.ti.com> <877heriu1j.fsf@gmail.com> <20101230122738.GB3714@legolas.emea.dhcp.ti.com> <874o9vnw4h.fsf@gmail.com> <20101230160511.GB2236@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33946 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab0L3QQD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Dec 2010 11:16:03 -0500
In-Reply-To: <20101230160511.GB2236@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Ben Gamari <bgamari.foss@gmail.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hello.

Felipe Balbi wrote:

>>> Yes. The patch is waiting for the merge window, check linux-next or
>>> Greg's usb-next branch.

>> So I guess no working USB in 2.6.37 in that case?

> For am35x, I guess not. All in all, it was a change to omap's arch code
> which "broke" am35x in the first place. Well, the driver shouldn't be
> using that header anyway.

    This was a dubious decision, IMHO. It would have been better to accept the 
initial patch to make things compile in 2.6.37, and then do the big change for 
2.6.38...

WBR, Sergei
