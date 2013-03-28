From: =?UTF-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?=
	<freemangordon@abv.bg>
Subject: Re: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
Date: Thu, 28 Mar 2013 07:30:07 +0200 (EET)
Message-ID: <24838523.73311.1364448607026.JavaMail.apache@mail82.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pali.rohar@gmail.com, nm@ti.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

 Tony,

Who do you expect to make that code merge? Do you expect us to mechanic=
ally merge RX51 PPA API patch with the existing generic OMAP PPA API co=
de putting #ifdefs all over the place? Not that it is impossible, but t=
he only real piece of HW I have here is n900, so I just can't be sure t=
he code will still work on the other platforms besides RX51, once the c=
ode modified. Please, advice on how to proceed.

Regards,
Ivo

 >-------- =D0=9E=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=B0=D0=BB=D0=BD=D0=BE=
 =D0=BF=D0=B8=D1=81=D0=BC=D0=BE --------
 >=D0=9E=D1=82:  Tony Lindgren=20
 >=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE: Re: [PATCH] arm: omap: RX=
-51: ARM errata 430973 workaround
 >=D0=94=D0=BE: Pali Roh=C3=A1r=20
 >=D0=98=D0=B7=D0=BF=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=BE =D0=BD=D0=B0: =
=D0=A1=D1=80=D1=8F=D0=B4=D0=B0, 2013, =D0=9C=D0=B0=D1=80=D1=82 27 23:12=
:09 EET
 >
 >
 >* Pali Roh=C3=A1r  [130327 14:09]:
 >> On Wednesday 27 March 2013 21:56:07 Tony Lindgren wrote:
 >> > * Pali Roh=C3=A1r  [130324 07:31]:
 >> > > it is possible to upstream errata 430973 workaround for
 >> > > RX-51?
 >> >=20
 >> > I think we should make the SMC handling a generic function for
 >> > ARM.
 >> >=20
 >> > AFAIK just the SMC call numbering is different for various
 >> > implementations. So the handler and passing of the parameters
 >> > seems like it should be generic.
 >> >=20
 >>=20
 >> Not only, look at freemangordon's email:=20
 >> https://lkml.org/lkml/2013/3/1/62
 >
 >Seem like you may need some SoC specific wrapper to the
 >generic function to deal with the params. But still seems
 >like we can have an ARM generic smc funtion.
 >
 >Regards,
 >
 >Tony
 >
