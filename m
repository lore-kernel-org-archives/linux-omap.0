From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP HSMMC problems with off-mode
Date: Thu, 09 Dec 2010 09:50:23 -0800
Message-ID: <87zkseal9c.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1012071101590.13430@utopia.booyaka.com>
	<4CFE9059.1080202@nokia.com>
	<AANLkTimKCBm0+NTgJWvyivBqv0DoQhwMbsU2uxruoDot@mail.gmail.com>
	<alpine.DEB.2.00.1012071548490.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62850 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab0LIRu1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 12:50:27 -0500
Received: by pwj3 with SMTP id 3so586803pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 09:50:27 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1012071548490.13430@utopia.booyaka.com> (Paul
	Walmsley's message of "Tue, 7 Dec 2010 15:56:37 -0700 (MST)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sawant@ti.com" <sawant@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>

Paul Walmsley <paul@pwsan.com> writes:

> Hi,
>
> On Tue, 7 Dec 2010, Chikkature Rajashekar, Madhusudhan wrote:
>
>> On Tue, Dec 7, 2010 at 1:51 PM, Adrian Hunter <adrian.hunter@nokia.c=
om> wrote:
>> >
>> > It is at least because omap_pm_get_dev_context_loss_count() is not
>> > implemented. =C2=A0Tero Kristo was looking at that recently.
>> >
>>=20
>> Yes. I agree that is the problem. In the .32 kernel I had hooked it =
to
>> "get_last_off_on_transaction_id" which helped.
>> But that functionality does not exist anymore. So something equivale=
nt
>> to tell the driver when the OFF was hit will make it work.
>
> OK, let's see if we can get that fixed in at least some trivial=20
> way for 2.6.38.  While working on this, I applied this trivial patch:
>
> diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/o=
map-pm-noop.c
> index e129ce8..781aa5f 100644
> --- a/arch/arm/plat-omap/omap-pm-noop.c
> +++ b/arch/arm/plat-omap/omap-pm-noop.c
> @@ -30,6 +30,8 @@ struct omap_opp *dsp_opps;
>  struct omap_opp *mpu_opps;
>  struct omap_opp *l3_opps;
> =20
> +static int dummy_context_loss_counter;
> +
>  /*
>   * Device-driver-originated constraints (via board-*.c files)
>   */
> @@ -303,7 +305,7 @@ int omap_pm_get_dev_context_loss_count(struct dev=
ice *dev)
>  	 * off counter.
>  	 */
> =20
> -	return 0;
> +	return dummy_context_loss_counter++;
>  }
> =20
> =20
>
> ... which causes drivers to believe that device context has been lost=
=20
> after each call to omap_pm_get_dev_context_loss_count().  Brutal, but=
=20
> effective for chasing out context save/restore bugs. =20

Tested-by: Kevin Hilman <khilman@deeprootsystems.com>

I verified that this, in combination with your other patch[1] results i=
n
working off-suspend with MMC on 34xx/n900, 35xx/beagle and 36xx/zoom3.

Paul, do you want to submit a formal patch for this for 2.6.38? if not,
I can add a changelog and queue this with other PM core changes for 2.6=
=2E38.

Kevin

[1] MMC: omap_hsmmc: enable interface clock before calling mmc_host_ena=
ble()
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
