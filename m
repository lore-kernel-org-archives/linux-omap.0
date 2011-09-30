From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/5 v12] arm: omap: usb: ehci and ohci hwmod structures for omap3
Date: Fri, 30 Sep 2011 10:17:22 -0700
Message-ID: <877h4qj6fx.fsf@ti.com>
References: <1317361216-28248-1-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1109300107150.32653@utopia.booyaka.com>
	<CAP05o4LJ2P8DCri1Vf-opezP8eNX+Wghm9FBSYwy8Vrct8_YDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP05o4LJ2P8DCri1Vf-opezP8eNX+Wghm9FBSYwy8Vrct8_YDw@mail.gmail.com>
	(Keshava Munegowda's message of "Fri, 30 Sep 2011 16:02:06 +0530")
Sender: linux-kernel-owner@vger.kernel.org
To: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

"Munegowda, Keshava" <keshava_mgowda@ti.com> writes:

[...]

>>> +
>>> +static struct omap_hwmod_ocp_if omap34xx_f_cfg__usb_tll_hs =3D {
>>> + =C2=A0 =C2=A0 .clk =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D "=
usbtll_ick",
>>> + =C2=A0 =C2=A0 .user =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D OCP_US=
ER_MPU,
>>> + =C2=A0 =C2=A0 .flags =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D OCPIF_=
SWSUP_IDLE,
>>> +};
>>
>> Does this really need OCPIF_SWSUP_IDLE? =C2=A0If so, then there is a=
 hardware
>> bug, and some explanation is needed.
>
>
> it was not allowing enter usbhs pw domain to enter to low power idle =
mode; so
> I add a comment here.
>

When you add this comment, please be sure it describes *why* the power
domain was not hitting the target power state, and reference any
relevant eerrata.

Thanks,

Kevin
