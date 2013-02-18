From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: Re: [PATCH v2 0/1] OMAP4: DSS: Add panel for Blaze Tablet boards
Date: Mon, 18 Feb 2013 16:30:41 +0200
Message-ID: <CAB=otbRAj41dFMe_i+LDGbi29kMV0C-tw-HXyz7iF4m4R+5R+Q@mail.gmail.com>
References: <1360338220-12753-1-git-send-email-ruslan.bilovol@ti.com>
	<511B4C60.50404@ti.com>
	<CAB=otbSX_O-zbHZuPWPSEU0D1s3uKfZfeatoguoRiwogS5tVHQ@mail.gmail.com>
	<511CAD5D.2050502@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <511CAD5D.2050502@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: andi@etezian.org, FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tomi,

On Thu, Feb 14, 2013 at 11:24 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2013-02-14 02:07, Ruslan Bilovol wrote:
>
>> This patch is exactly a part of mainlining of the BlazeTablet board support :)
>> The goal is to have as much as possible support of this board in the
>> 'vanilla' kernel.
>> The BlazeTablet mainlining is already ongoing (
>> https://patchwork.kernel.org/patch/2118281/ )
>> and I hope we will have some support of this board in near future.
>> The BlazeTablet's LCD panel support is very important thing for us to
>> have it in mainline because
>> without it the BlazeTablet becomes a 'black brick' and it is painful
>> for us to port this
>> driver against each new version of kernel.
>
> Ok, good to hear you're pushing it to mainline. However, you should
> mentally prepare for it being a black brick =(.
>
> Tony said he's not adding new board files, only DT from now on. The
> display subsystem driver and the panel drivers do not work with DT yet,
> and it will still take some time for that to realize.
>
> Thus adding this driver would help nothing, as it couldn't be used. And
> after the DSS and the panel drivers are made to work with DT (which is a
> big job, needing large rewrites of the drivers), there's a rework that
> has to be done with this driver to make it compatible with the new DSS
> model.
>
> So, I'm still inclined to say that we shouldn't merge this.

Thanks for explanation.

Do you have some plan when DSS will be ready to port this driver?
(3.10, 3.11 or later)?

Best regards,
Ruslan

>
>  Tomi
>
>
