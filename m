From: Anil Kumar <anilk4.v@gmail.com>
Subject: Re: Use of of_parse_phandle()/of_node_put()
Date: Wed, 13 Feb 2013 22:10:14 +0530
Message-ID: <CABYxbz6xEEVxL1BBM+Mb7net27d3zTD-6+uoS63LXXvifn_TNw@mail.gmail.com>
References: <F3DBB1B3EF102E4994C89758CFCA32412C6E52@DBDE01.ent.ti.com>
	<511BB6C2.3060105@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:59206 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934262Ab3BMQk1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 11:40:27 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so1403740iaf.0
        for <linux-omap@vger.kernel.org>; Wed, 13 Feb 2013 08:40:26 -0800 (PST)
In-Reply-To: <511BB6C2.3060105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alsa Devel List <alsa-devel@alsa-project.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kumar, Anil" <anilkumar.v@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "jarkko.nikula@bitmer.com" <jarkko.nikula@bitmer.com>

Hi,

On Wed, Feb 13, 2013 at 9:22 PM, Peter Ujfalusi <peter.ujfalusi@ti.com>=
 wrote:
> On 02/13/2013 07:04 AM, Kumar, Anil wrote:
>> Hi  Peter,
>>
>> Just trying to understand.
>>
>> In omap-twl4030.c file probe function :-
>>
>> dai_node =3D of_parse_phandle(node, "ti,mcbsp", 0);
>>                 if (!dai_node) {
>>                         dev_err(&pdev->dev, "McBSP node is not provi=
ded\n");
>>                         return -EINVAL;
>>                 }
>>
>> Here  =93of_parse_phandle()=94  is used to get  =93of_device=94 node=
 pointer.
>> of_parse_phandle() suggest to use of_node_put()  on it when done.
>>
>> It looks when code request for an =93of_device=94 node, kernel  main=
tains
>> =93refcount=94 for this.
>> It check =93refcount=94  before giving pointer of of_device node and=
  WARN_ON()
>> in case of refcount  > 0 and increase it on success.
>>
>> Should this code need to use of_node_put() on the requested =93of_de=
vice=94 when done
>> so that this can be get  again ?
>
> Hrm, one thing or sure we should not call it of_node_put() while we h=
ave the
> card loaded since the node is used runtime by the core.
>
> However when we unload the machine driver it might be needed, but not=
 sure
> about this. None of the existing machine drivers doing it (tegra, sam=
sung,
> omap, etc).
> But if it is needed it might be better to be done by the core?
>

It looks issue is different here.
I have done some testing here with patch[1]. In this patch i tried to
get same "of_device" node pointer
again and found refcount for this dt node is 1 [Result].

As of_parse_phandle() says it "returns the device_node pointer with
refcount incremented".
But why refcount  value is 1 [Result] again ?

-----------------------------8---------------------
Patch[1]:-
diff --git a/sound/soc/omap/omap-twl4030.c b/sound/soc/omap/omap-twl403=
0.c
index fd98509..0828a5c 100644
--- a/sound/soc/omap/omap-twl4030.c
+++ b/sound/soc/omap/omap-twl4030.c
@@ -297,6 +297,16 @@ static int omap_twl4030_probe(struct platform_devi=
ce *pdev)
                        dev_err(&pdev->dev, "McBSP node is not provided=
\n");
                        return -EINVAL;
                }
+               printk(KERN_ERR"refcount 0x%x",
atomic_read(&dai_node->kref.refcount));
+
+               dai_node =3D of_parse_phandle(node, "ti,mcbsp", 0);
+                if (!dai_node) {
+                        dev_err(&pdev->dev, "McBSP node is not provide=
d\n");
+                        return -EINVAL;
+                }
+               printk(KERN_ERR"refcount 0x%x",
atomic_read(&dai_node->kref.refcount));
+
+
                omap_twl4030_dai_links[0].cpu_dai_name  =3D NULL;
                omap_twl4030_dai_links[0].cpu_of_node =3D dai_node;

[Result]:-
root@DevKit8000:/# insmod snd-soc-omap-twl4030.ko
[   95.718109] refcount 0x1
[   95.720611] refcount 0x1 [   95.818054] omap-twl4030 sound.20:
twl4030-hifi <-> 49022000.mcbsp mapping ok


Thanks,
Anil
[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
