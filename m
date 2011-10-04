From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 2/5 v12] arm: omap: usb: ehci and ohci hwmod structures
 for omap3
Date: Tue, 4 Oct 2011 17:27:23 +0530
Message-ID: <CAP05o4K71CuWqePZPa0wc7zRGaXdO4oYosCOSvybgqs0qZjx5Q@mail.gmail.com>
References: <1317361216-28248-1-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1109300107150.32653@utopia.booyaka.com>
	<CAP05o4LJ2P8DCri1Vf-opezP8eNX+Wghm9FBSYwy8Vrct8_YDw@mail.gmail.com>
	<877h4qj6fx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <877h4qj6fx.fsf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 30, 2011 at 10:47 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Munegowda, Keshava" <keshava_mgowda@ti.com> writes:
>
> [...]
>
>>>> +
>>>> +static struct omap_hwmod_ocp_if omap34xx_f_cfg__usb_tll_hs =3D {
>>>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbtll_ick",
>>>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>>>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OCPIF_SWSUP_IDLE,
>>>> +};
>>>
>>> Does this really need OCPIF_SWSUP_IDLE? =A0If so, then there is a h=
ardware
>>> bug, and some explanation is needed.
>>
>>
>> it was not allowing enter usbhs pw domain to enter to low power idle=
 mode; so
>> I add a comment here.
>>
>
> When you add this comment, please be sure it describes *why* the powe=
r
> domain was not hitting the target power state, and reference any
> relevant eerrata.

I will add the errata description and id

regards
keshava
