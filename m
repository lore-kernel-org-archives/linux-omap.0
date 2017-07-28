From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] device property: Fix usecount for of_graph_get_port_parent()
Date: Fri, 28 Jul 2017 17:58:17 -0500
Message-ID: <CAL_Jsq+1Gnq_BC=CkxhgGk1zOS12w4jde3R48t0Df1N0+W5JvQ@mail.gmail.com>
References: <20170727094405.19778-1-tony@atomide.com> <CAL_JsqJ9Xmbws8gBRCxn2Nt=tj1HLnF-MGvnW+oOourvgbm9Nw@mail.gmail.com>
 <20170728060127.GH10026@atomide.com> <20170728082315.GL10026@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170728082315.GL10026-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 28, 2017 at 3:23 AM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
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
> From tony Mon Sep 17 00:00:00 2001
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

LGTM. I'm assuming this will go thru ALSA tree.

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
