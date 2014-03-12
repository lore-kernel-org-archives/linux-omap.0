From: Richard Lee <superlibj8301@gmail.com>
Subject: Re: [alsa-devel] [PATCH RFC v2 0/2] Fix simple-card *-master DT
 parameter handling
Date: Wed, 12 Mar 2014 13:00:02 +0800
Message-ID: <CAHPCO9FmL__LmUyMRhsy2mnPNAV0h--aMY=GBJjL9TBrAqWSFw@mail.gmail.com>
References: <cover.1394451329.git.jsarha@ti.com>
	<877g80rzgg.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:54129 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaCLFAE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 01:00:04 -0400
In-Reply-To: <877g80rzgg.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, peter.ujfalusi@ti.com, broonie@kernel.org, bcousson@baylibre.com

 On Wed, Mar 12, 2014 at 9:13 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>
> Hi Jyri
>
>> Since RFC:
>> - fixed commit msg typo
>> - added include/sound/soc.h changes too
>>
>> The sematics of bitclock-master and frame-master DT parameters
>> should depend on whether they are found from a cpu-dai or codec
>> sub-node.
>>
>> - bitclock-master in cpu-dai node means Codec-Bitclock-Slave
>> - frame-master in cpu-dai node means Codec-Frame-Slave
>> - bitclock-master in codec node means Codec-Bitclock-Master
>> - frame-master in codec node means Codec-Frame-Master
>>
>> For example in a cpu-dai mode bitclock-master parameter should produce
>> SND_SOC_DAIFMT_CBS_* daifmt flags and a codec node
>> SND_SOC_DAIFMT_CBM_* flags.
>
> SND_SOC_DAIFMT_xxx comment indicates "codec clk/FRM" indeed.
> but does this "codec" means "codec chip" ??
> I'm not sure.
>
> but anyway, if my understanding is correct,
>
>         simple-audio-card,cpu {
>                 ...
>                 bitclock-master;
>                 frame-master;
>         };
>
>         simple-audio-card,codec {
>                 ...
>                 bitclock-master;
>                 frame-master;
>         };
>
> This will be
> cpu   : SND_SOC_DAIFMT_CBS_CFS
> codec : SND_SOC_DAIFMT_CBM_CFM
>

Yes, That's also what my understanding of this patches.

But, IMO, if you want the CPU DAI be CBS_CFS and CODEC be CBM_CFM,
you could just do it like this:
         simple-audio-card,cpu {
                 ...
         };

         simple-audio-card,codec {
                 ...
                 bitclock-master;
                 frame-master;
         };

and vice versa.

Thanks,

(I could find this mails in my Freescale acount, so I will reply it here.)

--
Best Regards,
Xiubo


> but, it is un-understandable/confusable for me,
> and it breaks our sound card.
>
>         ${LINUX}/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
>         ${LINUX}/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
>
> I guess you want like this ?
>
>         codec-bitclock-master;
>         codec-frame-master;
>
>         simple-audio-card,cpu {
>                 ...
>         };
>
>         simple-audio-card,codec {
>                 ...
>         };
>
> # And I guess [1/2] and [2/2] should be 1 patch.
> # otherwise, it breaks git-bisect :P
>
>
> Best regards
> ---
> Kuninori Morimoto
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
