From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v11 08/14] usb: otg: add OTG/dual-role core
Date: Tue, 21 Jun 2016 17:47:47 +0300
Message-ID: <874m8mmwdo.fsf@linux.intel.com>
References: <575E672E.5070603@ti.com> <87h9coxq04.fsf@linux.intel.com> <5767C1B9.2060805@ti.com> <878ty0qd7q.fsf@linux.intel.com> <20160621063936.GB5108@shlinux2> <87d1nbovp7.fsf@linux.intel.com> <20160621080209.GC5108@shlinux2> <87mvmfneeq.fsf@linux.intel.com> <20160621091437.GE5108@shlinux2> <87fus6n2iz.fsf@linux.intel.com> <20160621131205.GG5108@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160621131205.GG5108@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Roger Quadros <rogerq@ti.com>, peter.chen@freescale.com, yoshihiro.shimoda.uh@renesas.com, tony@atomide.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com, mathias.nyman@linux.intel.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, jun.li@freescale.com, grygorii.strashko@ti.com, robh@kernel.org, nsekhar@ti.com, b-liu@ti.com, joe@perches.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Peter Chen <hzpeterchen@gmail.com> writes:
>> >> >> >> >>> + * @otg_dev: OTG controller device, if needs to be used wi=
th OTG core.
>> >> >> >> >>=20
>> >> >> >> >> do you really know of any platform which has a separate OTG =
controller?
>> >> >> >> >>=20
>> >> >> >> >
>> >> >> >> > Andrew had pointed out in [1] that Tegra210 has separate bloc=
ks for OTG, host
>> >> >> >> > and gadget.
>> >> >> >> >
>> >> >> >> > [1] http://article.gmane.org/gmane.linux.ports.tegra/22969
>> >> >> >>=20
>> >> >> >> that's not an OTG controller, it's just a mux. No different tha=
n Intel's
>> >> >> >> mux for swapping between XHCI and peripheral-only DWC3.
>> >> >> >>=20
>> >> >> >> frankly, I would NEVER talk about OTG when type-C comes into pl=
ay. They
>> >> >> >> are two competing standards and, apparently, type-C is winning =
when it
>> >> >> >> comes to role-swapping.
>> >> >> >>=20
>> >> >> >
>> >> >> > In fact, OTG is mis-used by people. Currently, if the port is du=
al-role,
>> >> >> > It will be considered as an OTG port.
>> >> >>=20
>> >> >> That's because "dual-role" is a non-standard OTG. Seen as people r=
eally
>> >> >> didn't care about OTG, we (linux-usb folks) ended up naturally ref=
erring
>> >> >> to "non-standard OTG" as "dual-role". Just to avoid confusion.
>> >> >
>> >> > So, unless we use OTG FSM defined in OTG spec, we should not mention
>> >> > "OTG" in Linux, right?
>> >>=20
>> >> to avoid confusion with the terminology, yes. With that settled, let's
>> >> figure out how you can deliver what your marketting guys are asking of
>> >> you.
>> >>=20
>> >
>> > Since nxp SoC claims they are OTG compliance, we need to pass usb.org
>> > test. The internal bsp has passed PET test, and formal compliance test
>> > is on the way (should pass too).=20
>> >
>> > The dual-role and OTG compliance use the same zImage, but different
>> > dtb.
>>=20
>> okay, that's good to know. Now, the question really is: considering we
>> only have one user for this generic OTG FSM layer, do we really need to
>> make it generic at all? I mean, just look at how invasive a change that
>> is.
>
> If the chipidea is the only user for this roger's framework, I don't
> think it is necessary. In fact, Roger introduces this framework, and
> the first user is dwc3, we think it can be used for others. Let's

Right, we need to look at the history of dwc3 to figure out why the
conclusion that dwc3 needs this was made.

Roger started working on this framework when Power on Reset section of
databook had some details which weren't always clear and, for safety, we
always had reset asserted for a really long time. It was so long (about
400 ms) that resetting dwc3 for each role swap was just too much.

Coupled with that, the OTG chapter wasn't very clear either on
expections from Host and Peripheral side initialization in OTG/DRD
systems.

More recent version of dwc3 databook have a much better description of
how and which reset bits _must_ be asserted and which shouldn't be
touched unless it's for debugging purposes. When I implemented that, our
=2D>probe() went from 400ms down to about 50us.

Coupled with that, the OTG chapter also became a lot clearer to the
point that it states you just don't initialize anything other than the
OTG block, and just wait for OTG interrupt to do whatever it is you need
to do.

This meant that we could actually afford to do full reinitialization of
dwc3 on role swap (it's now only 50us anyway) and we knew how to swap
roles properly.

(The reason for needing soft-reset during role swap is kinda long. But
in summary dwc3 shadows register writes to both host and peripheral
sides)

> just discuss if it is necessary for dual-role switch.

fair. However, if we have a single user we don't have a Generic
layer. There's not enough variance to come up with truly generic
architecture for this.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaVOTAAoJEIaOsuA1yqRE6MQP/iGUsfq+XtyOlsvLwMWRCalo
EUN+YFglzPCXhaNk/8QLSoT/409u7q8nVVaMfMRN0WSxWNZzeWo2cxtJmgpQEx94
SyVuWC/9jSz5VrwIZB3zt16EWivxH1/J1srGnKDAHw2KbHtqk/41WKtKC5yJaR2z
D+0qg38mjezioEQymdifp6rwzhbuTTXMLcr30pOPgKbrOUPKn0JBRgFVoYaRSZMj
w/LBDKBHGEgo4yAtHg+7jscWh9YolrinVY4RVpJ98tB366YSk0IXjaDY6PmGsZfS
LyYa+guYSH70nDxLD33I1WcfvPPbKOi3cFk78r60mu4YNHCCRnCrociYBXwMg4Fd
WpFOs1+iYdAl57lnk5whPy3tQz96k9kVPrGBop7NEx9G97jmpsA2+rfcDFqyHSwm
Y9Y5/Rj8t6kex5NNe44oeGYAdFkkBExCYfpDX750j7Np18iBD7AIUjH+OP0RmsIU
rjBtrbcYsIDQxG+Orzzv7/tIrJ6wh1XNaoMBH0EH4LO2OBTIh2aPFMy2z4MCMmbh
0LDBogRiRorD4b02+6aQSEvh/Ww6hP4XisHeJxObvx5SfgFpvkYsE9UYrvw4nDIY
gZKEcF5WSrbCgivZ4j2eNuYM+oxWDo2XOAr1Ia1dWuEdALj9puupSEywHZnxVIK4
LHsNrPiWUpG/ilZWTp0s
=962d
-----END PGP SIGNATURE-----
--=-=-=--
