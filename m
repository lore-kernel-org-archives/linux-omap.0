From: =?UTF-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?=
	<freemangordon@abv.bg>
Subject: Re: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
Date: Wed, 6 Mar 2013 11:32:12 +0200 (EET)
Message-ID: <107742828.129755.1362562332955.JavaMail.apache@mail81.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: pdeschrijver@nvidia.com, pali.rohar@gmail.com, tony@atomide.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

=20




 >-------- =D0=9E=D1=80=D0=B8=D0=B3=D0=B8=D0=BD=D0=B0=D0=BB=D0=BD=D0=BE=
 =D0=BF=D0=B8=D1=81=D0=BC=D0=BE --------
 >=D0=9E=D1=82:  Aaro Koskinen=20
 >=D0=9E=D1=82=D0=BD=D0=BE=D1=81=D0=BD=D0=BE: Re: [PATCH] arm: omap: RX=
-51: ARM errata 430973 workaround
 >=D0=94=D0=BE: =D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=BE =D0=94=D0=B8=D0=BC=
=D0=B8=D1=82=D1=80=D0=BE=D0=B2=20
 >=D0=98=D0=B7=D0=BF=D1=80=D0=B0=D1=82=D0=B5=D0=BD=D0=BE =D0=BD=D0=B0: =
=D0=A1=D1=8A=D0=B1=D0=BE=D1=82=D0=B0, 2013, =D0=9C=D0=B0=D1=80=D1=82 2 =
01:51:39 EET
 >
 >
 >On Fri, Mar 01, 2013 at 12:09:12PM +0200, =D0=98=D0=B2=D0=B0=D0=B9=D0=
=BB=D0=BE =D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2 wrote:
 >> Unfortunately it is necessary, on RX-51 PPA/NOLO leaves IBE bit uns=
et.
 >
 >You sure? I think you need to explain this more - the commit message =
in
 >the original patch is empty/missing...
 >
 >A.
 >

Yes, I am sure, NOLO leaves IBE bit in ACR unset, I've verified that by=
 reading/printing the contents of ACR from both u-boot and the kernel i=
tself. With IBE bit unset, "mcr p15, 0, rX, c7, c5, 6" - flush BTAC/BTB=
 instruction(which is needed to workaround errata 430973) is a noop.

Yes, I am sure, IBE but must be set by using a call to PPA, on RX-51 se=
tting that bit from the kernel (as it is done in the "ARM errata: Stale=
 prediction on replaced interworking branch" kernel patch, see http://k=
erneltrap.org/mailarchive/git-commits-head/2009/5/3/5622724) does not w=
ork, see the comment at the end: "Note that setting specific bits in th=
e ACTLR register may not be available in non-secure mode.". This is exa=
ctly the case for RX-51. I've verified that too.

If you need anything else elaborated on, I'm fine, just ask :)


Regards,
Ivo
