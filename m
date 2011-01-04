From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] arm: omap: select HAVE_SPARSE_IRQ
Date: Tue, 4 Jan 2011 13:52:08 +0200
Message-ID: <20110104115208.GB24553@legolas.emea.dhcp.ti.com>
References: <1294133966-20279-1-git-send-email-balbi@ti.com>
 <1294133966-20279-3-git-send-email-balbi@ti.com>
 <20110104095410.GA17298@n2100.arm.linux.org.uk>
 <20110104103432.GM2656@legolas.emea.dhcp.ti.com>
 <20110104114207.GA19293@n2100.arm.linux.org.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:48340 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751016Ab1ADLwM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 06:52:12 -0500
Received: by gxk24 with SMTP id 24so6307115gxk.32
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 03:52:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110104114207.GA19293@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi,

On Tue, Jan 04, 2011 at 11:42:07AM +0000, Russell King - ARM Linux wrote:
>On Tue, Jan 04, 2011 at 12:34:32PM +0200, Felipe Balbi wrote:
>> do you mean:
>
>Yes, but without the breakage caused by your mailer - posting patches

good, I'll re-send the series in a bit.

>with flowed formatting is a recipe for this kind of disaster:
>
>Content-Type: text/plain; charset=us-ascii; format=flowed
>
>You appear to be using mutt, so set:
>
>set text_flowed=no
>
>in your .muttrc to avoid this corruption.

sorry about that, fixed.

-- 
balbi
