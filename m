From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/2] drivers: cleanup Kconfig stuff
Date: Tue, 2 Nov 2010 21:46:47 +0200
Message-ID: <AANLkTik6G25x3t9W01e_LRNVRv99CbWY3GFU93mz1wEg@mail.gmail.com>
References: <1288656853-4625-1-git-send-email-felipe.contreras@gmail.com>
	<1288656853-4625-3-git-send-email-felipe.contreras@gmail.com>
	<20101102131146.GA21476@opensource.wolfsonmicro.com>
	<AANLkTim6E+e=D88C8g+YDVwS1D5JPeXvVRw-JVoVxh2i@mail.gmail.com>
	<20101102141208.GU31158@pengutronix.de>
	<AANLkTikwGBij05h1GgW0dpvcJedmcOQ1HWCaxaBdhZta@mail.gmail.com>
	<20101102143949.GH21476@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101102143949.GH21476@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-usb <linux-usb@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Greg KH <greg@kroah.com>, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>, David Brownell <dbrownell@users.sourceforge.net>, Greg Kroah-Hartman <gregkh@suse.de>, Hao Wu <hao.wu@intel.com>, Alan Cox <alan@linux.intel.com>, Mike Rapoport <mike@compulab.co.il>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 2, 2010 at 4:39 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Nov 02, 2010 at 04:18:18PM +0200, Felipe Contreras wrote:
>> 2010/11/2 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
>
>> > Well, all platforms that have TWL4030_CORE will get REGULATOR_TWL4=
030 by
>> > default, too. =C2=A0(TWL4030_CORE doesn't depend on something omap=
ish.)
>
>> Yes, I think TWL4030_CORE should depend on OMAP3, but I think some
>> people might not like that. That's why I wanted to make that a
>> separate patch.
>
> It did originally but that dependency was removed to allow build
> coverage for non-OMAP users.

I'm not sure removing that dependency is worth it. There's probably a
lot of code in the kernel that can be built without meeting the
specified dependencies. Maybe there should be a way to differentiate
soft from hard dependencies for this particular use-case. But I guess
for now the lack of dependency should be ok.

--=20
=46elipe Contreras
