From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [PATCH v3 2/7] mfd: omap: control: core system
	control driver
Date: Tue, 3 Jul 2012 14:00:24 +0300
Message-ID: <CAGF5oy_gR0VRZFs3g+RQPF27pSnGnMOECtF1J6Tt4arFXdU6XQ@mail.gmail.com>
References: <4FEB4B46.9020904@dev.rtsoft.ru> <20120628045028.GC2471@besouro>
	<4FEC25CA.10105@dev.rtsoft.ru>
	<CAGF5oy9heLnjcHj4H=hMK9NAkrDoOocR-Lbv1Z4cQ4G1C5kSeQ@mail.gmail.com>
	<4FEC2E1D.5040309@dev.rtsoft.ru> <4FEC3154.9050103@dev.rtsoft.ru>
	<CAGF5oy85XSfBtV_WFwYyWDHYmBbLGHK_9c9XhTFs1CgnSfyMLA@mail.gmail.com>
	<CAGF5oy-50evWVX8+U6qe0wwA0UXJUAXxXXbwrEkebSVtT8vxRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAGF5oy-50evWVX8+U6qe0wwA0UXJUAXxXXbwrEkebSVtT8vxRA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Cc: balbi@ti.com, kishon@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello,

On Thu, Jun 28, 2012 at 1:55 PM, Valentin, Eduardo
<eduardo.valentin@ti.com> wrote:
> Hello again,
>
> On Thu, Jun 28, 2012 at 1:51 PM, Valentin, Eduardo
> <eduardo.valentin@ti.com> wrote:
>> Hello,
>>
>> On Thu, Jun 28, 2012 at 1:26 PM, Konstantin Baydarov
>> <kbaidarov@dev.rtsoft.ru> wrote:
>>> On 06/28/2012 02:12 PM, Konstantin Baydarov wrote:
>>>> The interface(design) of omap-control-core.c has already been discusse=
d many times :(
>>>> Eduardo, in his patch set, suggested following design:
>>>> - omap-control-core.c ioremaps SCM window and provide functions to rea=
d/write SCP register for bandgap and usb.
>>>>
>>>> IIRC, this approach didn't satisfy and it was suggested to have privat=
e read/write in bandgap and usb.
>>>>
>>>> So, my patch set introduces following design:
>>>> - omap-control-core.c don't provide read/write functions for bandgap a=
nd usb.
>>>> - bandgap and usb use their own private read/write functions
>>>> - Each omap-control-core.c, bandgap and usb drivers remap SCM window. =
It's OK because SCM window is statically mapped to the same virtual address=
. But the problem is that SMP memory window isn't protected. I'm not sure w=
hether it's possible to protect SCM window using this approach.
>>> I mean:
>>>
>>> - Each omap-control-core.c, bandgap and usb drivers remap SCM window. I=
t's OK because SCM window is statically mapped. So each call of ioremap in =
omap-control-core.c, bandgap and usb drivers returns the same virtual addre=
ss. But the problem is that SCM memory window isn't protected. I'm not sure=
 whether it's possible to protect SCM window using this approach(when each =
driver remaps the same IOMEM).
>>>
>>>>
>>>> Another possible design is:
>>>> - omap-control-core.c ioremaps and reserves SCM IOMEM window
>>>> - omap-control-core.c exports omap_control_get_base(virtual base addre=
ss is returned) to use in bandgap and usb_phy driver.
>>>> - Bandgap and usb phy uses their own private read/write function.
>>>> IIUC, this way was suggested by Tony.
>>
>> Well I understood slightly different :-)
>>
>> I think the point is not really where to put the access functions, but
>> to have each driver handling a separate part of the the io window. As
>> I said before, so that they don't access each other io area.
>>
>> If you have 1 io window, for the above mentioned constraint, you won't
>> protect anything. So, in that sense, it doesn't make much difference
>> if you have access functions in core, or in the children, as they are
>> all sharing the same io window. Of course, in case we put only 1 io
>> window, for me it is safer if that window is managed in only one
>> place, instead of several places.
>>
>> The question is then, can we split the io area into smaller windows
>> for each children? Considering the children registers are not
>> contiguous :-(. In theory we can put several entries in the 'reg' DT
>> property, but that becomes a bit messy as it will change depending on
>> OMAP version. Anyways, if we split the scm io window into several io
>> smaller areas/chunks, then it makes sense to have access functions in
>> each children.
>>
>>>>
>>>> I guess It's better to settle the design(interface) of omap-control-co=
re.c, bandgap and usb phy and then submit the next version of patch set.
>>>
>>
>> Agreed. Here. We need to decide how to have this design and stick to it.
>
> Once the design is agreed, the series can probably be split into
> parts, so we can have the scm core and its children worked separately

Just to be clear, what I was proposing is to have each driver taking
care of its own io window.

For instance, for BG, assuming we have a DT like this:

		ctrl_module_core: ctrl_module_core@4a002000 {
			compatible =3D "ti,omap4-control";
			ti,hwmods =3D "ctrl_module_core";
			#address-cells =3D <1>;
			#size-cells =3D <1>;
			ranges;
			bandgap: bandgap@4a002000 {
				 reg =3D <0x4a00232C 0x4 0x4a002378 0x18>;
				 compatible =3D "ti,omap4460-bandgap";
				 interrupts =3D <0 126 4>; /* talert */
				 ti,tshut-gpio =3D <86>; /* tshut */
			 };
			usb {
				compatible =3D "ti,omap4-usb-phy";
			};
		};

then, while probing, it can request those by simply:

	i =3D 0;
	do {
		void __iomem *chunk;

		res =3D platform_get_resource(pdev, IORESOURCE_MEM, i);
		if (!res)
			break;
		chunk =3D devm_request_and_ioremap(&pdev->dev, res);
		if (i =3D=3D 0)
			bg_ptr->base =3D chunk;
		if (!chunk) {
			dev_err(&pdev->dev,
				"failed to request the IO (%d:%pR).\n",
				i, res);
			return ERR_PTR(-EADDRNOTAVAIL);
		}
		i++;
	} while (res);

The driver needs to adapt its reg offsets, of course, it is doable and
with the current design it is just a matter of redefining the register
offsets.

But for the above to work, the core driver must not request the
complete IO area.

>
>>
>>
>> --
>>
>> Eduardo Valentin
>
>
>
> --
>
> Eduardo Valentin



--=20

Eduardo Valentin
