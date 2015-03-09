From: Bin Liu <binmlist@gmail.com>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Mon, 9 Mar 2015 16:17:29 -0500
Message-ID: <CADYTM3aBoUvBTe4f75s84J+rGzpvh53syadmcRP=ydRdQ5DTVQ@mail.gmail.com>
References: <20150309205157.GE5140@atomide.com>
	<CADYTM3bEQ1mFTusuFQAMYfgOrhNM4=8a7_5=Nh5kHQKO3r1v6A@mail.gmail.com>
	<20150309211306.GC22341@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38793 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbbCIVRa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2015 17:17:30 -0400
In-Reply-To: <20150309211306.GC22341@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Tony Lindgren <tony@atomide.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-usb <linux-usb@vger.kernel.org>, Brian Hutchinson <b.hutchman@gmail.com>

On Mon, Mar 9, 2015 at 4:13 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Mon, Mar 09, 2015 at 04:11:28PM -0500, Bin Liu wrote:
>> Hi,
>>
>> On Mon, Mar 9, 2015 at 3:51 PM, Tony Lindgren <tony@atomide.com> wrote:
>> > Add a minimal driver for dm816x USB. Otherwise we can just use
>> > the existing musb_am335x and musb_dsps on dm816x.
>>
>> dm816x has the almost identical usbss as that in am335x, we should be
>> able to adopt musb_am335x and musb_dsps for dm816x, and dm814x too?
>
> Tony's using the same musb glue layers, this is just a phy driver,
> right ?

Can the current am335x phy driver be adopted too? I remember it is
under drivers/usb/phy/.

Regards,
-Bin.

>
> --
> balbi
