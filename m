From: "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/3] drivers: cleanup Kconfig stuff
Date: Wed, 20 Oct 2010 11:47:56 +0300
Message-ID: <AANLkTikd1v1RwHuU+mL4NoRcPuJQcjrOQUh_sXdQPC3Y@mail.gmail.com>
References: <1287482608-11320-1-git-send-email-felipe.contreras@gmail.com>
	<1287482608-11320-4-git-send-email-felipe.contreras@gmail.com>
	<20101019103234.GI31170@legolas.emea.dhcp.ti.com>
	<AANLkTinXzMQXoyyu+anSCvSuE9w3FWAP5HswDS0kfpzE@mail.gmail.com>
	<20101019111613.GJ31170@legolas.emea.dhcp.ti.com>
	<AANLkTikkMphKa2DGGtWxy-3LpFX0kn92UEYPj==Euzok@mail.gmail.com>
	<20101019115236.GL31170@legolas.emea.dhcp.ti.com>
	<AANLkTim3NsgjC3Nh8VCCrx4cV1Y+kn38=30=en0KCft6@mail.gmail.com>
	<6ea089ac75d4d15d88698468eacb7fe3@secure211.sgcpanel.com>
	<AANLkTinYM5aavk9_jcTTymff=OY+Yyv8T6C+dmMih0p_@mail.gmail.com>
	<20101019234414.GB30991@atomide.com>
	<87fww1u3fw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87fww1u3fw.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, balbi@ti.com, linux-usb@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 20, 2010 at 3:13 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Tony Lindgren <tony@atomide.com> writes:
>> So if you have something that's needed on almost every omap,
>> you can select it there.
>
> One thing I don't like about this is that there is currently no way t=
o
> 'select' as a module.
>
> In order to get to a minimal kernel, in theory, we don't need regulat=
or,
> i2c, MFD, or twl4030* built in. =C2=A0They should all be built as mod=
ules.
> Yes, there are some assumptions made today that some of these things =
are
> built in, and then are used from init code, but that is broken.
>
> If someone is looking for a good omap-kernel-janitors project, I woul=
d
> suggest getting to a *really* minimal OMAP2+ kernel with everything
> possible built as modules to be a very good project.

Yes, one use-case would be to select things as modules by default only
if ARCH_OMAP2PLUS_TYPICAL is selected.

But not everyone needs many of these things, I expect to be able to do
ARCH_OMAP2PLUS_TYPICAL=3Dn, and manually enable USB stuff
USB_MUSB_HDRC=3Dy, without having to know the dependencies myself.

That was the idea: simplify the defconfigs so that they are truly
minimal (they boot), and then people can add whatever they need (like
USB).

--=20
=46elipe Contreras
