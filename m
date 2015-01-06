From: =?windows-1252?Q?Peter_K=FCmmel?= <syntheticpp@gmx.net>
Subject: Re: 3.18.1->3.19-rc2: In-band Error seen by MPU
Date: Tue, 06 Jan 2015 14:04:04 +0100
Message-ID: <54ABDD44.9030100@gmx.net>
References: <20150101182053.GG582@fuloong-minipc.musicnaut.iki.fi> <20150102161911.GA3298@atomide.com> <54A6E408.1090908@gmx.net> <20150102201908.GK582@fuloong-minipc.musicnaut.iki.fi> <20150102204018.GF3298@atomide.com> <20150102223451.GL582@fuloong-minipc.musicnaut.iki.fi> <20150103000220.GE3279@atomide.com> <20150103121622.GN582@fuloong-minipc.musicnaut.iki.fi> <20150105154313.GA19336@saruman> <54ABC618.8070906@gmx.net> <20150106115250.GA27539@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:64990 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465AbbAFNEZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Jan 2015 08:04:25 -0500
In-Reply-To: <20150106115250.GA27539@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: balbi@ti.com, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Russell King <rmk+kernel@arm.linux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>



Am 06.01.2015 um 12:52 schrieb Sebastian Reichel:
> Hi,
>
> On Tue, Jan 06, 2015 at 12:25:12PM +0100, Peter K=FCmmel wrote:
>> Am 05.01.2015 um 16:43 schrieb Felipe Balbi:
>>> Just booted AM335x with CONFIG_PREEMPT and haven't seen any problem=
=2E
>>> Perhaps this is something related to another OMAP3-only driver?
>>> Perhaps HSI/SSI ?
>>
>> I see a ssi error directly before the IN-Band error:
>>
>> [    0.339935] platform 48058000.ssi-controller: Cannot lookup hwmod=
 'ssi'
>> [    0.346893] In-band Error seen by MPU  at address 0
>> [    0.346923] ------------[ cut here ]------------
>
> mh I guess your board's dts included omap36xx.dtsi or omap34xx.dtsi.
> Since ssi controller is not available on DM3xxx/AM3xxx (AFAIK) it
> should be disabled for those SoCs:
>
> &ssi {
>      status =3D "disabled";
> };

Indeed, I include omap36xx.dtsi.
Disabling ssi removes ssi the error.
But the In-Band error is still there, so not related to ssi.


I also see these errors:

omap_hwmod: mcbsp2_sidetone using broken dt data from mcbsp
omap_hwmod: mcbsp3_sidetone using broken dt data from mcbsp
omap_hwmod: mcbsp2: cannot be enabled for reset (3)

and

irq: no irq domain found for /ocp/pinmux@48002030 !

Could these errors also be fixed by the dts.

Peter

>
>  From what I can see the following in-tree .dts files should be
> fixed, too:
>
> * am3517_mt_ventoux.dts
>    Currently includes "omap34xx.dtsi" instead of "am3517.dtsi".
>
> Apart from that the following boards seem to use omap36xx.dtsi
> include, but are actually DM37xx, so they should disable the
> ssi block:
>
> * omap3-igep.dtsi
> * omap3-lilly-a83x.dtsi
> * omap3-overo-storm.dtsi
>
> I will prepare a patch for that later.
>
> -- Sebastian
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
