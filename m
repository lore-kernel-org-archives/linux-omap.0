From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH 11/11] OMAPDSS: DPI: use VPLL2 regulator if VDDS_DSI is
 not found
Date: Sun, 17 Nov 2013 02:06:27 +0100
Message-ID: <52881693.7090600@collabora.co.uk>
References: <1384608224-9452-1-git-send-email-javier.martinez@collabora.co.uk> <1384608224-9452-12-git-send-email-javier.martinez@collabora.co.uk> <20131116141853.GF10317@atomide.com> <5287908C.3040602@collabora.co.uk> <20131116154507.GL10317@atomide.com> <20131116160234.GB5104@earth.universe> <5287AB20.9070407@collabora.co.uk> <20131117002600.GA14253@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:60628 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab3KQBHY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 16 Nov 2013 20:07:24 -0500
In-Reply-To: <20131117002600.GA14253@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Sebastian,

On 11/17/2013 01:26 AM, Sebastian Reichel wrote:
> Hi Javier,
> 
> On Sat, Nov 16, 2013 at 06:28:00PM +0100, Javier Martinez Canillas wrote:
>> > The hack, as being sent by Javier, will result in the wrong
>> > regulator being used on the Nokia N900, which is using vaux1.
>> > It must depend on the machine.
>> 
>> I see, so this hack is not generic enough to be usable for all OMAP3 boards so I
>> think is better to just add the hack on the DTS.
>>
>> I was more found about adding a hack on dpi.c since the DTB is an stable ABI
>> while the dpi.c implementation is not.
> 
> I agree with this. My suggestion would be to get the vdds_dsi regulator name
> from platform data. This way each board can setup its own quirk until omapdss
> supports DT.
> 
>> But I guess is not that bad to change the DTS later once DSS DT
>> bindings are added to mainline.
> 
> As far as I know DT bindings are supposed to be as stable as
> possible.
> 

Indeed, although as far as I understood on the latest ARM kernel summit it was
decided that DT bindings (and DTS) can be changed in incompatible ways if it can
be reasonably argued that nobody will be affected by the change.

IMHO this is the case for IGEP boards since the vendor (ISEE) is still shipping
the boards using an old 2.6.37 forked kernel that uses board files.

So I think is reasonable to remove this DT hack later once we have omapdss + CDF
bindings in mainline since current users that choose to use the mainline kernel
instead of the vendor one have to be able to replace the stock kernel +
bootloader that comes with the boards anyways.

>> > At the same time the N900 device tree file uses V28 as
>> > regulator-name for vaux1 (which is the same one as legacy boot
>> > used). Nothing depends on this, but I don't think it's a
>> > good idea to use this property. Apparently it does not work
>> > if multiple drivers need the same regulator under different
>> > names.
>> > 
>> > -- Sebastian
>> > 
>> 
>> So, what do you think about the following patch instead?
>> 
>> [PATCH]
> 
> For Nokia N900 vaux1 is also used for si4713 radio chip, lis3lv02d
> accelerometer and battery cover sensor, so I don't like this hack.
>
> If vppl2 is only used for omapdss.dsi on IGEP boards it might be
> sensible to label it, though? So it might be ok there.
>

Yes, you can't use this hack for the N900 since other devices already use the
vaux1 regulator named as "V28" so you can't just rename it to "vdds_dsi".

But for IGEP boards vpll2 is only used for omapdss DPI so we don't have that issue.

Let's see what Tomi says that is the best way to handle this to have DVI working
with DT until the propers bindings land in mainline.

> -- Sebastian
> 

Thanks a lot for your feedback and best regards,
Javier

