From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RESEND/PATCH 5/6] USB: musb-gadget: complete request only if
 data is transfered over
Date: Tue, 14 Sep 2010 09:56:04 +0300
Message-ID: <20100914065604.GD2601@legolas.emea.dhcp.ti.com>
References: <1283873014-32511-1-git-send-email-tom.leiming@gmail.com>
 <1283873014-32511-6-git-send-email-tom.leiming@gmail.com>
 <4C8E18AD.8000502@ru.mvista.com>
 <AANLkTinei3u1OZ-eBiUTDF=PDjwxLcL6rBpt7iNQJgHJ@mail.gmail.com>
 <4C8E4882.6040600@ru.mvista.com>
 <4C8E50CC.3080705@ru.mvista.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38514 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389Ab0ING4V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Sep 2010 02:56:21 -0400
Content-Disposition: inline
In-Reply-To: <4C8E50CC.3080705@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Ming Lei <tom.leiming@gmail.com>, "greg@kroah.com" <greg@kroah.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, "Balbi, Felipe" <balbi@ti.com>, "Gadiyar, Anand" <gadiyar@ti.com>, Mike Frysinger <vapier@gentoo.org>

Hi,

On Mon, Sep 13, 2010 at 11:26:52AM -0500, Sergei Shtylyov wrote:
> Oops, I've been too fast and haven't realized that the check done here
> _is_ actually wrong. It causes ZLP send to trigger too fast in the DMA
> case. So please fix this patch. Felipe, please drop it for now.

patch is not even touching that part of the code, not even
reading/writing TXCSR_TXPKTRDY bit care to explain please.

-- 
balbi
