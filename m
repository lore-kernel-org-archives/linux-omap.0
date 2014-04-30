From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 3/7] phy: omap-usb2: Use generic clock names "wkupclk"
 and "refclk"
Date: Wed, 30 Apr 2014 10:20:26 -0500
Message-ID: <CAGo_u6oAJZvUBvOWMtkn8pEXO1Q=A+CrQ1kcWGWLobFza65sbA@mail.gmail.com>
References: <1398693687-13967-1-git-send-email-rogerq@ti.com>
	<1398693687-13967-4-git-send-email-rogerq@ti.com>
	<20140428160347.GG30292@saruman.home>
	<535F59CF.6050002@ti.com>
	<20140429161420.GH633@saruman.home>
	<20140429161616.GI633@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:62275 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbaD3PU2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Apr 2014 11:20:28 -0400
In-Reply-To: <20140429161616.GI633@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, george.cherian@ti.com, linux-omap <linux-omap@vger.kernel.org>, dt list <devicetree@vger.kernel.org>, linux-usb@vger.kernel.org

On Tue, Apr 29, 2014 at 11:16 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Apr 29, 2014 at 11:14:20AM -0500, Felipe Balbi wrote:
>> On Tue, Apr 29, 2014 at 10:50:39AM +0300, Roger Quadros wrote:
>> > +Nishant
>> >
>> > Hi,
>> >
>> > On 04/28/2014 07:03 PM, Felipe Balbi wrote:
>> > > Hi,
>> > >
>> > > On Mon, Apr 28, 2014 at 05:01:23PM +0300, Roger Quadros wrote:
>> > >> As clocks might be named differently on multiple platforms, use a generic
>> > >> name in the driver and allow device tree node to specify the platform
>> > >> specific clock name.
>> > >>
>> > >> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> > >> ---
>> > >>  drivers/phy/phy-omap-usb2.c | 8 ++++----
>> > >>  1 file changed, 4 insertions(+), 4 deletions(-)
>> > >>
>> > >> diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
>> > >> index a2205a8..fb5e515 100644
>> > >> --- a/drivers/phy/phy-omap-usb2.c
>> > >> +++ b/drivers/phy/phy-omap-usb2.c
>> > >> @@ -275,16 +275,16 @@ static int omap_usb2_probe(struct platform_device *pdev)
>> > >>          if (IS_ERR(phy_provider))
>> > >>                  return PTR_ERR(phy_provider);
>> > >>
>> > >> -        phy->wkupclk = devm_clk_get(phy->dev, "usb_phy_cm_clk32k");
>> > >> +        phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
>> > >
>> > > doesn't this patch cause a regression ? I mean, you're changing the
>> > > clock name before fixing DTS. Also, that DTS has been in a major version
>> > > of the kernel, so we need to maintain compatibility with it. How about:
>> >
>> > I'm changing the DTS in Patch 4, but I prefer to do it in this patch
>> > to prevent synchronization issues in -next.
>> >
>> > About backward compatibility, I agree with you but at the same time I
>> > don't think anyone using TI SoCs burns the DTB to ROM and needs
>> > backward compatibility. We supply our BSPs/SDKs with the updated DTBs.
>> > Do you feel strict backward compatibility is worth the effort for TI
>> > specific blocks?
>>
>> dunno, but it would, at least, avoid "synchronization issues with
>> linux-next" :-)
>
> and the bisectability issue.

I agree - we cannot drop backward compatibility for DTBs
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=2a9330010bea5982a5c6593824bc036bf62d67b7
"
+
+ 3) Bindings can be augmented, but the driver shouldn't break when given
+ the old binding. ie. add additional properties, but don't change the
+ meaning of an existing property. For drivers, default to the original
+ behaviour when a newly added property is missing.
"
Regards,
Nishanth Menon
