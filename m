From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
Date: Thu, 28 Mar 2013 15:37:24 +0530
Message-ID: <5154165C.4050604@ti.com>
References: <517283541.62064.1362124023621.JavaMail.apache@mail81.abv.bg> <20130306175120.GP11806@atomide.com> <201303062013.16302@pali> <201303241526.59275@pali> <20130327205606.GN10155@atomide.com> <20130328095011.GS30923@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130328095011.GS30923@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Nishanth Menon <nm@ti.com>, linux-kernel@vger.kernel.org, =?UTF-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgA==?= =?UTF-8?B?0L7Qsg==?= <freemangordon@abv.bg>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thursday 28 March 2013 03:20 PM, Russell King - ARM Linux wrote:
> On Wed, Mar 27, 2013 at 01:56:07PM -0700, Tony Lindgren wrote:
>> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [130324 07:31]:
>>> it is possible to upstream errata 430973 workaround for RX-51?
>>
>> I think we should make the SMC handling a generic function for ARM.
>>
>> AFAIK just the SMC call numbering is different for various
>> implementations. So the handler and passing of the parameters
>> seems like it should be generic.
>=20
> SMC calls vary greatly in how they are handled.  The only thing that'=
s
> generic is issuing the SMC call.  All the setup and what arguments ar=
e
> required are completely different from SoC to SoC.
>=20
> For example, some SoCs require arguments passed via memory.  Others l=
ike
> OMAP its via registers.

Exactly. As somebody said on the list, that code looks identical but
it is not. An SMC with barrier instruction is mostly common and nothing
more than that.

Regards,
Santosh
