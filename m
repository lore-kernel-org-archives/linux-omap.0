From: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 14/17] ARM: dts: Add missing gpu node and binding for
 omap4
Date: Tue, 29 Aug 2017 15:27:31 +0300
Message-ID: <5efc9078-5886-5826-834e-facd67ddfbe5@ti.com>
References: <20170828211918.11573-1-tony@atomide.com>
 <20170828211918.11573-15-tony@atomide.com>
 <20170829090034.ytepjfv2jkkd2b3z@earth>
 <201708291135.v7TBZCHH020827@dflxv15.itg.ti.com>
 <20170829121041.dweciryplio5i4jr@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170829121041.dweciryplio5i4jr@earth>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

=EF=BB=BF
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 29/08/17 15:10, Sebastian Reichel wrote:

>> Do we even want to add SGX to the .dts? We don't have proper drivers for
>> SGX. If we ever do, who knows what kind of DT data they need. I know the
>> DT data for SGX in TI's kernel tree has changed at least once.
>=20
> I don't think reg or interrupts will be removed, so the properties
> added by Tony look pretty safe?. I guess if we ever have a driver

Oh, and one more thing about the regs. I believe SGX consists of
multiple register blocks. But as it's not documented in any public docs,
there's just that single block in the DT data. I'm not sure if single
block or multiple blocks would be the right approach, but then, I guess
we can always live with just a single block and if needed split the
blocks inside the driver.

 Tomi

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
