From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: [PATCH 00/12] usb: ehci-omap: add OMAP4 support
Date: Tue, 30 Nov 2010 23:53:11 +0530
Message-ID: <AANLkTi=hr3bz6xS8DB+ShE0E_HzFGhtCqi+1NqsWQQa5@mail.gmail.com>
References: <1290364814-4417-1-git-send-email-gadiyar@ti.com> <20101130174406.GB19977@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:43707 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755854Ab0K3SXe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Nov 2010 13:23:34 -0500
In-Reply-To: <20101130174406.GB19977@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@suse.de>

On Tue, Nov 30, 2010 at 11:14 PM, Greg KH <greg@kroah.com> wrote:
> On Mon, Nov 22, 2010 at 12:10:03AM +0530, Anand Gadiyar wrote:
>> This series adds support for the EHCI controller on
>> OMAP4 chips. (This enables the ethernet controller
>> on the Pandaboard - finally!).
>>
>> I'm sorry for the really long delay - I know this has
>> been in the works for a while.
>>
>> I've tested the series on an OMAP4 SDP and a Pandaboard.
>> I'll be testing OMAP3 tomorrow.
>>
>> Dependencies:
>> One patch depends on the mux framework patches by Benoit
>> - which are already in linux-next; however the series
>> compiles cleanly against current Linus' tree.
>>
>> What's pending:
>> - OHCI support
>> - Support for TLL and HSIC modes
>> - Factoring out code common to ehci-omap and ohci-omap3
>> - Conversion to use omap_device and the hwmod database
>> - Runtime PM support
>
> Do you want these to go in through the USB or OMAP tree? =A0Either is=
 fine
> with me.
>
> thanks,
>
> greg k-h
>

I reposted a v2 series splitting them up into two parts - one that coul=
d
potentially go via the USB tree [1], and the other that is platform cha=
nges
that touches only mach-omap2/* files and could go via the OMAP tree [2]=
=2E

The only other change is I added back patch descriptions to a couple
of patches that I missed out on in v1.

I'm okay with either option. Both series could also go via your tree if
it's okay with Tony.

- Anand

[1]<http://marc.info/?l=3Dlinux-usb&m=3D129105160923756&w=3D2>
[2] <http://marc.info/?l=3Dlinux-usb&m=3D129105160723737&w=3D2>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
