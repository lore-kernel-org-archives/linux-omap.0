From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: Re: [PATCH v2 0/1] OMAP4: DSS: Add panel for Blaze Tablet boards
Date: Thu, 14 Feb 2013 02:07:28 +0200
Message-ID: <CAB=otbSX_O-zbHZuPWPSEU0D1s3uKfZfeatoguoRiwogS5tVHQ@mail.gmail.com>
References: <1360338220-12753-1-git-send-email-ruslan.bilovol@ti.com>
	<511B4C60.50404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <511B4C60.50404@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: andi@etezian.org, FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

On Wed, Feb 13, 2013 at 10:18 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi,
>
> On 2013-02-08 17:43, Ruslan Bilovol wrote:
>> Hi,
>>
>> This patch adds support for TC358765 DSI-to-LVDS transmitter
>> from Toshiba, that is used in OMAP4 Blaze Tablet development
>> platform. It was originally developed a long time ago and
>> was used internally survived few kernel migrations.
>> Different people worked in this driver during last two
>> years changing its sources to what each new version of
>> kernel expects.
>>
>> Current version is ported from internal kernel v3.4 to 3.8.0-rc6
>> Tested basic functioning under busybox.
>
> Thanks for updating the driver to a recent kernel.
>
> I didn't review the patch line by line, but with a brief look it looks
> fine. However, I'm not quite sure what to do with this patch.
>
> The problem is that the driver is a combined driver for the TC358765
> chip and the panel on Blaze Tablet, and we are very much trying to fix
> that design issue so that the drivers for the chip and panel could be
> separate, as they should.
>
> So I fear that if I now accept the patch, it'll increase my burden of
> managing the display drivers during this design rework. Furthermore, to
> my knowledge the Blaze Tablet is quite a rare board, and it's not even
> supported in the mainline kernel, so this driver wouldn't be usable by
> itself.

This patch is exactly a part of mainlining of the BlazeTablet board support :)
The goal is to have as much as possible support of this board in the
'vanilla' kernel.
The BlazeTablet mainlining is already ongoing (
https://patchwork.kernel.org/patch/2118281/ )
and I hope we will have some support of this board in near future.
The BlazeTablet's LCD panel support is very important thing for us to
have it in mainline because
without it the BlazeTablet becomes a 'black brick' and it is painful
for us to port this
driver against each new version of kernel.

>
> So if I'm right about the blaze tablet status, I'm inclined to say that
> I think this should be still kept out of tree.

Considering my information above, (and your information that design
rework will be started later), can we pick this driver for now in its
current state?

Regards,
Ruslan

>
>  Tomi
>
>
