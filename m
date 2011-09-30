From: "Munegowda, Keshava" <keshava_mgowda@ti.com>
Subject: Re: [PATCH 2/5 v12] arm: omap: usb: ehci and ohci hwmod structures
 for omap3
Date: Fri, 30 Sep 2011 16:03:23 +0530
Message-ID: <CAP05o4+VPcMXn8hB6f2buyET1tR+KZu1tMm=xh5DKrrjsuomnw@mail.gmail.com>
References: <1317361216-28248-1-git-send-email-keshava_mgowda@ti.com>
	<alpine.DEB.2.00.1109300107150.32653@utopia.booyaka.com>
	<alpine.DEB.2.00.1109300156140.12185@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1109300156140.12185@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, khilman@ti.com, b-cousson@ti.com, gadiyar@ti.com, sameo@linux.intel.com, parthab@india.ti.com, tony@atomide.com, johnstul@us.ibm.com, vishwanath.bs@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 30, 2011 at 1:32 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> a few more comments
>
> On Fri, 30 Sep 2011, Paul Walmsley wrote:
>
>> On Fri, 30 Sep 2011, Keshava Munegowda wrote:
>>
>> > +static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usb_host_hs =3D =
{
>> > + =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
>> > + =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_host_hs_hwmod,
>> > + =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_ick",
>> > + =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usb_host_hs_addrs,
>> > + =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA,
>> > +};
>> > +
>> > +static struct omap_hwmod_ocp_if omap34xx_usb_host_hs__ick =3D {
>
> This is missing master, slave, and addr fields. =A0But see the commen=
t
> below.
>
>> > + =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbhost_ick",
>> > + =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> > + =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OCPIF_SWSUP_IDLE,
>>
>> Does this really need OCPIF_SWSUP_IDLE? =A0If so, then there is a ha=
rdware
>> bug, and some explanation is needed.
>
> Could you describe why there are two struct omap_hwmod_ocp_if records
> here? =A0It seems to me that these should just be combined into one s=
truct
> omap_hwmod_ocp_if record? =A0Looking at the clock3xxx_data.c file, th=
e
> usbhost_ick struct clk has l4_ick as its parent, so l4_ick shouldn't =
need
> to be mentioned explicitly?


Thanks ! I will do this.



=2E.
>
>> > +static struct omap_hwmod_ocp_if omap34xx_f_cfg__usb_tll_hs =3D {
>> > + =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "usbtll_ick",
>> > + =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU,
>> > + =A0 .flags =A0 =A0 =A0 =A0 =A0=3D OCPIF_SWSUP_IDLE,
>> > +};
>>
>> Does this really need OCPIF_SWSUP_IDLE? =A0If so, then there is a ha=
rdware
>> bug, and some explanation is needed.
>>
>> > +
>> > +static struct omap_hwmod_ocp_if omap34xx_l4_cfg__usb_tll_hs =3D {
>> > + =A0 .master =A0 =A0 =A0 =A0 =3D &omap3xxx_l4_core_hwmod,
>> > + =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap34xx_usb_tll_hs_hwmod,
>> > + =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_ick",
>> > + =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap34xx_usb_tll_hs_addrs,
>> > + =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA,
>> > +};
>
> Same problem here. =A0Seems like omap34xx_l4_cfg__usb_tll_hs and
> omap34xx_f_cfg__usb_tll_hs should be combined into one record.

Thanks ! I will do this.
