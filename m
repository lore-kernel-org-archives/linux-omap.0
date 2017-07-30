From: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: device property: Fix usecount for of_graph_get_port_parent()
Date: Sun, 30 Jul 2017 22:31:06 +0200
Message-ID: <CAAj6DX1tQj5Umjj=cawqw1jD24zdvwfed-FyvQGJ=9TzWvHiyw@mail.gmail.com>
References: <20170728082315.GL10026@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170728082315.GL10026-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 28, 2017 at 10:23 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170727 23:02]:
>> * Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170727 15:19]:
>> > On Thu, Jul 27, 2017 at 4:44 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>> > > --- a/drivers/of/property.c
>> > > +++ b/drivers/of/property.c
>> > > @@ -708,6 +708,15 @@ struct device_node *of_graph_get_port_parent(struct device_node *node)
>> > >  {
>> > >         unsigned int depth;
>> > >
>> > > +       if (!node)
>> > > +               return NULL;
>> > > +
>> > > +       /*
>> > > +        * Preserve usecount for passed in node as of_get_next_parent()
>> > > +        * will do of_node_put() on it.
>> > > +        */
>> > > +       of_node_get(node);
>> >
>> > I think this messes up of_graph_get_remote_port_parent(). First it
>> > calls of_graph_get_remote_endpoint which returns the endpoint node
>> > with ref count incremented. Then you are incrementing it again here.
>>
>> Hmm OK looks like I missed that one. If we want to have
>> of_graph_get_port_parent not trash the node passed to it, we should
>> just change things there too:
>
> Found few more things to fix with git grep -C20 of_graph_get_port_parent,
> below is v2.
>
> Can you all prese review again and do some testing. I also fixed up
> audio-graph-scu-card but can't test that one.
>
> Regards,
>
> Tony
>
> 8< ------
> >From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Thu, 27 Jul 2017 01:30:16 -0700
> Subject: [PATCHv2] device property: Fix usecount for
>  of_graph_get_port_parent()
>
> Fix inconsistent use of of_graph_get_port_parent() where
> asoc_simple_card_parse_graph_dai() does of_node_get() before
> calling it while other callers do not. We can fix this by
> not trashing the node passed to of_graph_get_port_parent().
>
> Let's also make sure the callers have correct refcounts and remove
> related incorrect of_node_put() calls for of_for_each_phandle
> as that's done by of_phandle_iterator_next() except when
> we break out of the loop early.
>
> Let's fix both issues with a single patch to avoid kobject
> refcounts getting messed up more if two patches are merged
> separately.
>
> Otherwise strange issues can happen caused by memory corruption
> caused by too many kobject_del() calls such as:
>
> BUG: sleeping function called from invalid context at
> kernel/locking/mutex.c:747
> ...
> (___might_sleep)
> (__mutex_lock)
> (mutex_lock_nested)
> (kernfs_remove)
> (kobject_del)
> (kobject_put)
> (of_get_next_parent)
> (of_graph_get_port_parent)
> (asoc_simple_card_parse_graph_dai [snd_soc_simple_card_utils])
> (asoc_graph_card_probe [snd_soc_audio_graph_card])
>
> Fixes: 0ef472a973eb ("of_graph: add of_graph_get_port_parent()")
> Fixes: 2692c1c63c29 ("ASoC: add audio-graph-card support")
> Fixes: 1689333f8311 ("ASoC: simple-card-utils: add asoc_simple_card_parse_graph_dai()")
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/of/property.c                    | 17 +++++++++++++++--
>  sound/soc/generic/audio-graph-card.c     | 10 +++++-----
>  sound/soc/generic/audio-graph-scu-card.c | 15 +++++++++------
>  sound/soc/generic/simple-card-utils.c    |  8 +++-----
>  sound/soc/soc-core.c                     |  2 ++
>  5 files changed, 34 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -708,6 +708,15 @@ struct device_node *of_graph_get_port_parent(struct device_node *node)
>  {
>         unsigned int depth;
>
> +       if (!node)
> +               return NULL;
> +
> +       /*
> +        * Preserve usecount for passed in node as of_get_next_parent()
> +        * will do of_node_put() on it.
> +        */
> +       of_node_get(node);
> +
>         /* Walk 3 levels up only if there is 'ports' node. */
>         for (depth = 3; depth && node; depth--) {
>                 node = of_get_next_parent(node);
> @@ -728,12 +737,16 @@ EXPORT_SYMBOL(of_graph_get_port_parent);
>  struct device_node *of_graph_get_remote_port_parent(
>                                const struct device_node *node)
>  {
> -       struct device_node *np;
> +       struct device_node *np, *pp;
>
>         /* Get remote endpoint node. */
>         np = of_graph_get_remote_endpoint(node);
>
> -       return of_graph_get_port_parent(np);
> +       pp = of_graph_get_port_parent(np);
> +
> +       of_node_put(np);
> +
> +       return pp;
>  }
>  EXPORT_SYMBOL(of_graph_get_remote_port_parent);
>
> diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
> --- a/sound/soc/generic/audio-graph-card.c
> +++ b/sound/soc/generic/audio-graph-card.c
> @@ -224,9 +224,11 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
>
>         of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
>                 ret = asoc_graph_card_dai_link_of(it.node, priv, idx++);
> -               of_node_put(it.node);
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       of_node_put(it.node);
> +
>                         return ret;
> +               }
>         }
>
>         return asoc_simple_card_parse_card_name(card, NULL);
> @@ -239,10 +241,8 @@ static int asoc_graph_get_dais_count(struct device *dev)
>         int count = 0;
>         int rc;
>
> -       of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
> +       of_for_each_phandle(&it, rc, node, "dais", NULL, 0)
>                 count++;
> -               of_node_put(it.node);
> -       }
>
>         return count;
>  }
> diff --git a/sound/soc/generic/audio-graph-scu-card.c b/sound/soc/generic/audio-graph-scu-card.c
> --- a/sound/soc/generic/audio-graph-scu-card.c
> +++ b/sound/soc/generic/audio-graph-scu-card.c
> @@ -215,7 +215,6 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
>                 codec_ep = of_graph_get_remote_endpoint(cpu_ep);
>                 rcpu_ep  = of_graph_get_remote_endpoint(codec_ep);
>
> -               of_node_put(cpu_port);
>                 of_node_put(cpu_ep);
>                 of_node_put(codec_ep);
>                 of_node_put(rcpu_ep);
> @@ -232,8 +231,10 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
>
>                 ret = asoc_simple_card_parse_daifmt(dev, cpu_ep, codec_ep,
>                                                             NULL, &daifmt);
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       of_node_put(cpu_port);
>                         goto parse_of_err;
> +               }
>         }
>
>         dai_idx = 0;
> @@ -250,7 +251,6 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
>                         codec_ep = of_graph_get_remote_endpoint(cpu_ep);
>                         codec_port = of_graph_get_port_parent(codec_ep);
>
> -                       of_node_put(cpu_port);
>                         of_node_put(cpu_ep);
>                         of_node_put(codec_ep);
>                         of_node_put(codec_port);
> @@ -266,13 +266,17 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
>
>                                 /* Back-End (= Codec) */
>                                 ret = asoc_graph_card_dai_link_of(codec_ep, priv, daifmt, dai_idx++, 0);
> -                               if (ret < 0)
> +                               if (ret < 0) {
> +                                       of_node_put(cpu_port);
>                                         goto parse_of_err;
> +                               }
>                         } else {
>                                 /* Front-End (= CPU) */
>                                 ret = asoc_graph_card_dai_link_of(cpu_ep, priv, daifmt, dai_idx++, 1);
> -                               if (ret < 0)
> +                               if (ret < 0) {
> +                                       of_node_put(cpu_port);
>                                         goto parse_of_err;
> +                               }
>                         }
>                 }
>         }
> @@ -306,7 +310,6 @@ static int asoc_graph_get_dais_count(struct device *dev)
>                 codec_ep = of_graph_get_remote_endpoint(cpu_ep);
>                 codec_port = of_graph_get_port_parent(codec_ep);
>
> -               of_node_put(cpu_port);
>                 of_node_put(cpu_ep);
>                 of_node_put(codec_ep);
>                 of_node_put(codec_port);
> diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
> --- a/sound/soc/generic/simple-card-utils.c
> +++ b/sound/soc/generic/simple-card-utils.c
> @@ -263,6 +263,9 @@ static int asoc_simple_card_get_dai_id(struct device_node *ep)
>                         id = i;
>                 i++;
>         }
> +
> +       of_node_put(node);
> +
>         if (id < 0)
>                 return -ENODEV;
>
> @@ -282,11 +285,6 @@ int asoc_simple_card_parse_graph_dai(struct device_node *ep,
>         if (!dai_name)
>                 return 0;
>
> -       /*
> -        * of_graph_get_port_parent() will call
> -        * of_node_put(). So, call of_node_get() here
> -        */
> -       of_node_get(ep);
>         node = of_graph_get_port_parent(ep);
>
>         /* Get dai->name */
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -4113,6 +4113,8 @@ int snd_soc_get_dai_id(struct device_node *ep)
>         }
>         mutex_unlock(&client_mutex);
>
> +       of_node_put(node);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_get_dai_id);

Tested on Hikey board, and it fixes the issue reported in
https://patchwork.kernel.org/patch/9863961/
but I cannot test the part regarding audio-graph-scu-card

Tested-by: Antonio Borneo <borneo.antonio-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
