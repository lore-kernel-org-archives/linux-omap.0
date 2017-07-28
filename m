From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] device property: Fix usecount for
 of_graph_get_port_parent()
Date: Thu, 27 Jul 2017 23:01:27 -0700
Message-ID: <20170728060127.GH10026@atomide.com>
References: <20170727094405.19778-1-tony@atomide.com>
 <CAL_JsqJ9Xmbws8gBRCxn2Nt=tj1HLnF-MGvnW+oOourvgbm9Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJ9Xmbws8gBRCxn2Nt=tj1HLnF-MGvnW+oOourvgbm9Nw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh+dt@kernel.org> [170727 15:19]:
> On Thu, Jul 27, 2017 at 4:44 AM, Tony Lindgren <tony@atomide.com> wrote:
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -708,6 +708,15 @@ struct device_node *of_graph_get_port_parent(struct device_node *node)
> >  {
> >         unsigned int depth;
> >
> > +       if (!node)
> > +               return NULL;
> > +
> > +       /*
> > +        * Preserve usecount for passed in node as of_get_next_parent()
> > +        * will do of_node_put() on it.
> > +        */
> > +       of_node_get(node);
> 
> I think this messes up of_graph_get_remote_port_parent(). First it
> calls of_graph_get_remote_endpoint which returns the endpoint node
> with ref count incremented. Then you are incrementing it again here.

Hmm OK looks like I missed that one. If we want to have
of_graph_get_port_parent not trash the node passed to it, we should
just change things there too:

struct device_node *of_graph_get_remote_port_parent(
		const struct device_node *node)
{
	struct device_node *np, *pp;

	/* Get remote endpoint node. */
	np = of_graph_get_remote_endpoint(node);

	pp = of_graph_get_port_parent(np);
	of_node_put(np);

	return pp;
}
EXPORT_SYMBOL(of_graph_get_remote_port_parent);

Does that make sense to you?

> > diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
> > --- a/sound/soc/generic/audio-graph-card.c
> > +++ b/sound/soc/generic/audio-graph-card.c
> > @@ -224,7 +224,6 @@ static int asoc_graph_card_parse_of(struct graph_card_data *priv)
> >
> >         of_for_each_phandle(&it, rc, node, "dais", NULL, 0) {
> >                 ret = asoc_graph_card_dai_link_of(it.node, priv, idx++);
> > -               of_node_put(it.node);
> >                 if (ret < 0)
> >                         return ret;
> 
> I think you need a put here.

Do you mean on error it should be as below, right?

	ret = asoc_graph_card_dai_link_of(it.node, priv, idx++);
	if (ret < 0) {
		of_node_put(it.node);
		return ret;
	}

Regards,

Tony
