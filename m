From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [GIT PULL] OMAP: minor PM cleanups for v3.3
Date: Thu, 26 Jan 2012 12:06:07 +0200
Message-ID: <CADMYwHxDH8xDW8ZqQQfH-jz7hHtwQC6Xd0ejuVHND2EimgcrPA@mail.gmail.com>
References: <87pqfxhc2v.fsf@ti.com> <20111209205455.GW31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:36342 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab2AZKG3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 05:06:29 -0500
Received: by werb13 with SMTP id b13so242577wer.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Jan 2012 02:06:27 -0800 (PST)
In-Reply-To: <20111209205455.GW31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Tony,

On Fri, Dec 9, 2011 at 10:54 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Kevin Hilman <khilman@ti.com> [111209 09:15]:
>> Tony,
>>
>> Please pull the following minor PM cleanups for v3.3.
>
> Thanks pulling into cleanup branch.

It looks like this pull request from Kevin didn't make it to mainline.

I can spot Kevin's "ARM: OMAP2+: PM: only register TWL with voltage
layer when device is present" in Linus' tree, but not the other 3
patches that this pull request contained (one of them was "ARM: OMAP:
omap_device: Expose omap_device_{alloc, delete, register}", which I
was just looking for).

Here's the original request:

http://patchwork.ozlabs.org/patch/130439/

Am I missing anything ?

Thanks,
Ohad.
