From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RESEND/PATCH 5/6] USB: musb-gadget: complete request only if
 data is transfered over
Date: Wed, 15 Sep 2010 13:31:52 +0300
Message-ID: <20100915103152.GM3393@legolas.emea.dhcp.ti.com>
References: <20100914105402.GD7554@legolas.emea.dhcp.ti.com>
 <4C8FB60D.1080906@ru.mvista.com>
 <20100915065345.GC3393@legolas.emea.dhcp.ti.com>
 <4C909961.10001@ru.mvista.com>
 <20100915100553.GJ3393@legolas.emea.dhcp.ti.com>
 <4C909B2E.3000909@ru.mvista.com>
 <AANLkTi=A+1ThrRTNjWoFbXr-G1OUnpThEwG5rCgGirzC@mail.gmail.com>
 <4C909D87.2090901@ru.mvista.com>
 <20100915102256.GK3393@legolas.emea.dhcp.ti.com>
 <4C909F99.9050300@mvista.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35826 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996Ab0IOKcF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Sep 2010 06:32:05 -0400
Content-Disposition: inline
In-Reply-To: <4C909F99.9050300@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Ming Lei <tom.leiming@gmail.com>, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, "Gadiyar, Anand" <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>

Hi,

On Wed, Sep 15, 2010 at 05:27:37AM -0500, Sergei Shtylyov wrote:
>    IMHO, this fix as it is now is quite stupid. It's clear that the check is
>misplaced and will be removed once the ZLP fix is done. So why not do it once

your forgetting the fact that not always you need to send ZLP after
completing a packet_size-aligned transfer, so that check will have to
stay where it is.

>and for all? Is it so hard to do? FWIW, I NAK this patch as it is now.

ok, but I don't.

-- 
balbi
