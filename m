From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC 2/2] ASoC: simple-card: Move dai-link
 level properties away from dai subnodes
Date: Mon, 24 Mar 2014 11:38:59 +0200
Message-ID: <532FFD33.6040506@ti.com>
References: <cover.1395419906.git.jsarha@ti.com>	<0b1c0e2e6766c3a63f598c3b9435d4744b0e2835.1395419906.git.jsarha@ti.com>
 <20140323105412.4f312449@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20140323105412.4f312449@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, liam.r.girdwood@linux.intel.com, Li.Xiubo@freescale.com, peter.ujfalusi@ti.com, detheridge@ti.com, broonie@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 03/23/2014 11:54 AM, Jean-Francois Moine wrote:
> On Fri, 21 Mar 2014 18:47:23 +0200
> Jyri Sarha <jsarha@ti.com> wrote:
>
>> The properties like format, bitclock-master, frame-master,
>> bitclock-inversion, and frame-inversion should be common to the dais
>> connected with a dai-link. For bitclock-master and frame-master
>> properties to be unambiguous they need to indicate the mastering dai
>> node with a phandle.
>>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
[...]
>> -Required subnodes:
>> +Requred dai-link subnodes:
>
> Typo: 'Required'
>

Fixed. Thanks!

[...]
>> --- a/sound/soc/generic/simple-card.c
>> +++ b/sound/soc/generic/simple-card.c
>> @@ -8,6 +8,7 @@
>>    * it under the terms of the GNU General Public License version 2 as
>>    * published by the Free Software Foundation.
>>    */
>> +#define DEBUG
>
> Should be removed.
>

Removed. Thanks!

[...]
>> +	if (!bitclkmaster && !framemaster) {
>> +		/* Master setting not found from dai_link level, revert back
>> +		   to legacy DT parsing and take settings from codec node. */
>> +		dev_dbg(dev, "%s: Revert to legacy daifmt parsing\n",
>> +			__func__);
>> +		dai_props->cpu_dai.fmt = dai_props->codec_dai.fmt =
>> +			snd_soc_of_parse_daifmt(np, NULL, NULL, NULL) |
>> +			(daifmt & ~SND_SOC_DAIFMT_CLOCK_MASK);
>
> We are here each time there is no bitclock-master and no frame-master,
> i.e. each time for me. It could be simpler to keep the first 'daifmt'
> instead of parsing again.
>

Sorry, I missed this and comments bellow first time around. I'll make 
another patch set shortly.

Adding another check to test if we are parsing top level sound node 
would save you from the legacy mode parsing. I'll do that and update the
DT binding document accordingly.

[...]
>> +	if (multi) {
>> +		struct device_node *np = NULL;
>> +		int i;
>> +		for (i = 0; (np = of_get_next_child(node, np)); i++) {
>> +			dev_dbg(dev, "\tlink %d:\n", i);
>> +			ret = simple_card_dai_link_of(np, dev, dai_link + i,
>> +						      dai_props + i);
>
> I feel that my loop was quicker:
>

I was targeting for readability rather than speed. I doubt the 
difference is significant since most string processing is anyway taking 
most of the time anyway.

> 		struct device_node *np = NULL;
>
> 		for (;;) {
> 			np = of_get_next_child(node, np);
> 			if (!np)
> 				break;
> 			dev_dbg(dev, "\tlink %d:\n", dai_link - priv->snd_card.dai_link);
> 			ret = simple_card_dai_link_of(np, dev, dai_link++,
> 						      dai_props++);
>
>
>> +			of_node_put(np);
>> +			if (ret < 0)
>> +				return ret;
>
> The np reference count is updated in of_get_next_child(), so:
>
> 			if (ret < 0) {
> 				of_node_put(np);
> 				return ret;
> 			}
>

Oops, need to fix that. Thanks !

> Otherwise, it works for me.
>
> Tested-by: Jean-Francois Moine <moinejf@free.fr>
>

Best regards,
Jyri
