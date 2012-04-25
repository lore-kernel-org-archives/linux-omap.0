From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Tue, 24 Apr 2012 19:03:26 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204241857260.24864@utopia.booyaka.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com> <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-608425141-1335315806=:24864"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32871 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757063Ab2DYBD1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 21:03:27 -0400
In-Reply-To: <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>, Afzal Mohammed <afzal@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-608425141-1335315806=:24864
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello Vaibhav, Afzal, Vaibhav,

On Tue, 3 Apr 2012, Vaibhav Hiremath wrote:

> AM33XX clock implementation is different than any existing OMAP
> family of devices. Although DPLL module is similar to OMAP4
> device, but the usage is very much different than OMAP4.
> AM33XX has different peripheral set and each module gets
> integrated to the clock framework differently than OMAP
> family of devices.
>=20
> This patch adds full Clock tree data for AM33XX family
> of devices and also integrates it into existing OMAP framework.

What do you think about the possibility of removing all of the leaf clocks
that have AM33XX_MODULEMODE_SWCTRL as their .enable_bit, assuming there=20
are no .fixed_div or .clksel* fields associated with the clocks?

In theory, I don't think they are needed.  The drivers should be using=20
runtime PM, and that should enable and disable the module via the hwmod=20
code, rather than the clock code.

Of course some clocks would still be needed for the main_clk fields for=20
the hwmods, but the hwmods should be able to use the leaf clock's parent=20
clocks for that.

That would save quite a few lines of data.  And I think Beno=EEt is plannin=
g=20
to do that for OMAP4+.

What do you think?


- Paul
--155748971-608425141-1335315806=:24864--
