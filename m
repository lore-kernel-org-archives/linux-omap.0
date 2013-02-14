From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Use of of_parse_phandle()/of_node_put()
Date: Thu, 14 Feb 2013 10:26:41 +0100
Message-ID: <511CADD1.9060104@ti.com>
References: <F3DBB1B3EF102E4994C89758CFCA32412C6E52@DBDE01.ent.ti.com> <511BB6C2.3060105@ti.com> <CABYxbz6xEEVxL1BBM+Mb7net27d3zTD-6+uoS63LXXvifn_TNw@mail.gmail.com> <CABYxbz7_9cwgswHq2Pq3BWx-8-c0tkJNW8z16u45+pAJV6YS0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58003 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756741Ab3BNJ1A (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Feb 2013 04:27:00 -0500
In-Reply-To: <CABYxbz7_9cwgswHq2Pq3BWx-8-c0tkJNW8z16u45+pAJV6YS0w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anil Kumar <anilk4.v@gmail.com>
Cc: "Kumar, Anil" <anilkumar.v@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "jarkko.nikula@bitmer.com" <jarkko.nikula@bitmer.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Alsa Devel List <alsa-devel@alsa-project.org>

On 02/13/2013 06:02 PM, Anil Kumar wrote:
> ------------8---------------
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index b7e84a7..9000f4a 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1044,6 +1044,13 @@ static void soc_remove_dai_links(struct
> snd_soc_card *card)
>                         soc_remove_link_dais(card, dai, order);
>         }
>=20
> +       /* release cpu_of_node */
> +       if(card->dai_link) {
> +               int i;
> +               for(i =3D 0; i < card->num_links; i++)
> +                       of_node_put(card->dai_link[i].cpu_of_node);

and the same for codec_of_node and platform_of_node for that matter.

Mark: what do you think? Does it make sense to do this in the core or s=
hould
we let the machine drivers to take care of this?

> +       }
> +
>=20

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
