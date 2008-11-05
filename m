From: "York, Jeffrey-P56387" <Jeff.York@gdc4s.com>
Subject: RE: FSUSB Register access
Date: Tue, 4 Nov 2008 18:03:05 -0700
Message-ID: <9D31108D62FAE54AA21AEF899D69931E0385AAF1@AZ25EXM04.gddsi.com>
References: <20081104160946.19071.44903.stgit@tubuntu> <20081104161038.19071.98198.stgit@tubuntu> <9D31108D62FAE54AA21AEF899D69931E0385A99E@AZ25EXM04.gddsi.com> <20081104222032.GD4010@frodo> <9D31108D62FAE54AA21AEF899D69931E0385AADF@AZ25EXM04.gddsi.com> <20081105005523.GE4010@frodo>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from az25ege01.gdc4s.com ([63.226.32.21]:39935 "EHLO
	az25ege01.gdc4s.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbYKEBDH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Nov 2008 20:03:07 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20081105005523.GE4010@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org

Balbi,

Thanks for your help.

See below for the answers.

-----Original Message-----
From: Felipe Balbi [mailto:me@felipebalbi.com] 
Sent: Tuesday, November 04, 2008 5:55 PM
To: York, Jeffrey-P56387
Cc: me@felipebalbi.com; linux-omap@vger.kernel.org
Subject: Re: FSUSB Register access

Hi,

On Tue, Nov 04, 2008 at 05:38:28PM -0700, York, Jeffrey-P56387 wrote:
> <JEFF SAYS:  I did this and I do see logging now.  It shows as
expected
> an external abort on non-linefetch when it tries to read from an FSUSB
> register.  As far as I can tell from the TI spec, I should only have
to
> enable the 48 MHz clock...  And I know it is enabled via a read from
the
> CM_IDLEST_CKGEN register.>

hmm.. yeah, looks like it's clock issue. Do you call:

clk_get();
clk_enable();

before reading the register ?? Although, if CM_IDLEST_CKGEN says it's
on, it should be.

<JEFF SAYS:  I do when trying to request the "usb_fck" and "usb_l4_ick".
Not sure what the code is doing for the 48 MHz clock.  That's done
somewhere else in the Mobilinux kernel.  Given that the register says
its on, I was assuming that clock was good.>


Anyways, try to clk_get() the correct clock and clk_enable() it before
reading the register.

Remember, also, to clk_disable() when you're not reading the register
and clk_put() when you don't need it anymore.

> what's the kernel version ?? This should be fixed a long time ago.
> <JEFF SAYS:  2.6.21>

If you can try the current linux-omap git tree, I'd be glad. Also, when
you post bug. Please, send the console output. It really helps us
finding issues and suggesting you what to do.

-- 
balbi
