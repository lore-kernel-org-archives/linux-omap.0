From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [RESEND/PATCH 5/6] USB: musb-gadget: complete request only if
 data is transfered over
Date: Wed, 15 Sep 2010 14:41:39 +0400
Message-ID: <4C90A2E3.9020300@mvista.com>
References: <20100914105402.GD7554@legolas.emea.dhcp.ti.com> <4C8FB60D.1080906@ru.mvista.com> <20100915065345.GC3393@legolas.emea.dhcp.ti.com> <4C909961.10001@ru.mvista.com> <20100915100553.GJ3393@legolas.emea.dhcp.ti.com> <4C909B2E.3000909@ru.mvista.com> <AANLkTi=A+1ThrRTNjWoFbXr-G1OUnpThEwG5rCgGirzC@mail.gmail.com> <4C909D87.2090901@ru.mvista.com> <20100915102256.GK3393@legolas.emea.dhcp.ti.com> <4C909F99.9050300@mvista.com> <20100915103152.GM3393@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39324 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab0IOKnU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 06:43:20 -0400
In-Reply-To: <20100915103152.GM3393@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Ming Lei <tom.leiming@gmail.com>, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, "Gadiyar, Anand" <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>

Hello.

On 15-09-2010 14:31, Felipe Balbi wrote:

>> IMHO, this fix as it is now is quite stupid. It's clear that the check is
>> misplaced and will be removed once the ZLP fix is done. So why not do it once

> your forgetting the fact that not always you need to send ZLP after
> completing a packet_size-aligned transfer,

    So what?

> so that check will have to stay where it is.

    I don't see how these two are connected at all.

 >> and for all? Is it so hard to do? FWIW, I NAK this patch as it is now.

 > ok, but I don't.

    Well, you're the maintainer.

WBR, Sergei
