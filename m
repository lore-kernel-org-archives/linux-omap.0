From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Revert "ARM: RX-51: Enable isp1704 power on/off"
Date: Wed, 14 Dec 2011 01:02:09 +0200
Message-ID: <CAMP44s3Gmx1M40Dae-RR3+i=vv-d0Ls6h3YToRuUnMTFoqeSCQ@mail.gmail.com>
References: <1323105820-25946-1-git-send-email-felipe.contreras@nokia.com>
	<1323105820-25946-3-git-send-email-felipe.contreras@nokia.com>
	<CAMP44s3Szzm9iXxghXfNCBjKyUw-nRrG1aEeweKnRCidaxmxEA@mail.gmail.com>
	<4EDF5231.6080309@bitmer.com>
	<CAMP44s0a6hcORZn8wDxHUJKxs=wjAmkhRfiT9kEA_MoDYeAmfg@mail.gmail.com>
	<4EE5A8A0.2010206@bitmer.com>
	<CAMP44s1Zz7CqxRM6PeNT3GN9GbCLy+0smgk6_-9kSjghY33Xuw@mail.gmail.com>
	<20111213225308.GB10066@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111213225308.GB10066@legolas.emea.dhcp.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, Felipe Contreras <felipe.contreras@nokia.com>, linux-main <linux-kernel@vger.kernel.org>, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, Heikki Krogerus <heikki.krogerus@nokia.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 14, 2011 at 12:53 AM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Dec 13, 2011 at 11:19:52PM +0200, Felipe Contreras wrote:
>> On Mon, Dec 12, 2011 at 9:09 AM, Jarkko Nikula <jarkko.nikula@bitmer=
=2Ecom> wrote:
>> > Indeed yes. I checked that in 3.0 it still works but not in 3.1 so=
 some
>> > non isp1704_charger change has broke it as there hasn't been chang=
es on it.
>>
>> Actually it's broken in 3.0 as well, try this configuration:
>>
>> =C2=A0 =C2=A0 =C2=A0 # CONFIG_USB_MUSB_HOST is not set
>> =C2=A0 =C2=A0 =C2=A0 # CONFIG_USB_MUSB_PERIPHERAL is not set
>> =C2=A0 =C2=A0 =C2=A0 CONFIG_USB_MUSB_OTG=3Dy
>> =C2=A0 =C2=A0 =C2=A0 CONFIG_USB_GADGET_MUSB_HDRC=3Dy
>> =C2=A0 =C2=A0 =C2=A0 CONFIG_USB_MUSB_HDRC_HCD=3Dy
>>
>> =C2=A0 =C2=A0 =C2=A0 CONFIG_USB_GADGET_SELECTED=3Dy
>> =C2=A0 =C2=A0 =C2=A0 # CONFIG_USB_GADGET_FUSB300 is not set
>> =C2=A0 =C2=A0 =C2=A0 # CONFIG_USB_GADGET_OMAP is not set
>> =C2=A0 =C2=A0 =C2=A0 # CONFIG_USB_GADGET_R8A66597 is not set
>> =C2=A0 =C2=A0 =C2=A0 # CONFIG_USB_GADGET_PXA_U2O is not set
>> =C2=A0 =C2=A0 =C2=A0 # CONFIG_USB_GADGET_M66592 is not set
>> =C2=A0 =C2=A0 =C2=A0 # CONFIG_USB_GADGET_DUMMY_HCD is not set
>>
>> I will try to find where the issues started to happen, but it's a bi=
t
>> difficult because all this USB Kconfig stuff is completely messed up=
=2E
>>
>> *Sigh*
>
> patches are welcome

The were not last times:
http://mid.gmane.org/1288656853-4625-1-git-send-email-felipe.contreras@=
gmail.com
http://mid.gmane.org/1287482608-11320-1-git-send-email-felipe.contreras=
@gmail.com

But I'll try again... Once I'm done with this endless bisect =3D/

Cheers.

--=20
=46elipe Contreras
