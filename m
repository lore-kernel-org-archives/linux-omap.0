From: Anca Emanuel <anca.emanuel@gmail.com>
Subject: Re: [PATCH] musb: am35x: fix compile error due to control apis
Date: Thu, 30 Dec 2010 17:24:05 +0200
Message-ID: <AANLkTinE9Dgz9nCFv-1d=DdF22OEXSYn16s7krxo3CGp@mail.gmail.com>
References: <1291399965-19623-1-git-send-email-ajay.gupta@ti.com>
	<87hbe41kbd.fsf@gmail.com>
	<20101227092038.GB2301@legolas.emea.dhcp.ti.com>
	<877heriu1j.fsf@gmail.com>
	<20101230122738.GB3714@legolas.emea.dhcp.ti.com>
	<874o9vnw4h.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57072 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428Ab0L3PYG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Dec 2010 10:24:06 -0500
In-Reply-To: <874o9vnw4h.fsf@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ben Gamari <bgamari.foss@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On Thu, Dec 30, 2010 at 5:00 PM, Ben Gamari <bgamari.foss@gmail.com> wrote:
> On Thu, 30 Dec 2010 14:27:38 +0200, Felipe Balbi <balbi@ti.com> wrote:
>> Yes. The patch is waiting for the merge window, check linux-next or
>> Greg's usb-next branch.
>>
> So I guess no working USB in 2.6.37 in that case?

You can ask Greg to make an pull request, or mail Linus directly.
It is an driver, and Linus will accept patches that makes drivers work.
