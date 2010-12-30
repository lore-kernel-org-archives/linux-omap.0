From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] musb: am35x: fix compile error due to control apis
Date: Thu, 30 Dec 2010 16:06:01 +0300
Message-ID: <4D1C83B9.8070907@ru.mvista.com>
References: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com> <87hbe41kbd.fsf@gmail.com> <20101227092038.GB2301@legolas.emea.dhcp.ti.com> <877heriu1j.fsf@gmail.com> <20101230122738.GB3714@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53947 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab0L3NHG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Dec 2010 08:07:06 -0500
In-Reply-To: <20101230122738.GB3714@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Ben Gamari <bgamari.foss@gmail.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Hello.

On 30-12-2010 15:27, Felipe Balbi wrote:

>>> >Is this change slated to go into 2.6.37? As it stands it looks like
>>> >2.6.37 will be released with completely broken musb support on many boards
>>> >(including the BeagleBoard).

>>> yes, it is.

>> Are you sure? We are currently at -rc8 and yet this patch has yet to
>> make it into my tree.

> Yes. The patch is waiting for the merge window, check linux-next or
> Greg's usb-next branch.

    And yet he was asking you about 2.6.37. :-)

WBR, Sergei
