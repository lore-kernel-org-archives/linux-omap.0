From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Use of of_parse_phandle()/of_node_put()
Date: Thu, 14 Feb 2013 10:21:35 +0100
Message-ID: <511CAC9F.4010308@ti.com>
References: <F3DBB1B3EF102E4994C89758CFCA32412C6E52@DBDE01.ent.ti.com> <511BB6C2.3060105@ti.com> <CABYxbz6xEEVxL1BBM+Mb7net27d3zTD-6+uoS63LXXvifn_TNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47762 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756740Ab3BNJV5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Feb 2013 04:21:57 -0500
In-Reply-To: <CABYxbz6xEEVxL1BBM+Mb7net27d3zTD-6+uoS63LXXvifn_TNw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anil Kumar <anilk4.v@gmail.com>
Cc: Alsa Devel List <alsa-devel@alsa-project.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kumar, Anil" <anilkumar.v@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "jarkko.nikula@bitmer.com" <jarkko.nikula@bitmer.com>

On 02/13/2013 05:40 PM, Anil Kumar wrote:
> It looks issue is different here.
> I have done some testing here with patch[1]. In this patch i tried to
> get same "of_device" node pointer
> again and found refcount for this dt node is 1 [Result].
>=20
> As of_parse_phandle() says it "returns the device_node pointer with
> refcount incremented".
> But why refcount  value is 1 [Result] again ?

Documentation/kref.txt

>=20
> -----------------------------8---------------------
> Patch[1]:-
> diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl4=
030.c
> index fd98509..0828a5c 100644
> --- a/sound/soc/omap/omap-twl4030.c
> +++ b/sound/soc/omap/omap-twl4030.c
> @@ -297,6 +297,16 @@ static int omap_twl4030_probe(struct platform_de=
vice *pdev)
>                         dev_err(&pdev->dev, "McBSP node is not provid=
ed\n");
>                         return -EINVAL;
>                 }
> +               printk(KERN_ERR"refcount 0x%x",
> atomic_read(&dai_node->kref.refcount));
> +
> +               dai_node =3D of_parse_phandle(node, "ti,mcbsp", 0);
> +                if (!dai_node) {
> +                        dev_err(&pdev->dev, "McBSP node is not provi=
ded\n");
> +                        return -EINVAL;
> +                }
> +               printk(KERN_ERR"refcount 0x%x",
> atomic_read(&dai_node->kref.refcount));
> +
> +
>                 omap_twl4030_dai_links[0].cpu_dai_name  =3D NULL;
>                 omap_twl4030_dai_links[0].cpu_of_node =3D dai_node;
>=20
> [Result]:-
> root@DevKit8000:/# insmod snd-soc-omap-twl4030.ko
> [   95.718109] refcount 0x1
> [   95.720611] refcount 0x1 [   95.818054] omap-twl4030 sound.20:
> twl4030-hifi <-> 49022000.mcbsp mapping ok
>=20
>=20
> Thanks,
> Anil
> [...]
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
