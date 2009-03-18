From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc8 regulator-next] regulator: init fixes (v4)
Date: Wed, 18 Mar 2009 14:14:14 -0700
Message-ID: <200903181414.14563.david-b@pacbell.net>
References: <200903111743.34708.david-b@pacbell.net> <200903181225.11444.david-b@pacbell.net> <20090318203317.GA6299@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:40396 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752604AbZCRVOR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2009 17:14:17 -0400
In-Reply-To: <20090318203317.GA6299@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, lkml <linux-kernel@vger.kernel.org>, OMAP <linux-omap@vger.kernel.org>

On Wednesday 18 March 2009, Mark Brown wrote:

> > That self-inconsistency doesn't seem to concern you much.
>
> I think it's more that I'm viewing the use count as being useful
> information which the API can take advantage of ("do any consumers
> actually want this on right now?").

In that case, I don't understand why you didn't like
the previous versions of this patch ... which just
forced the regulator off (at init time) if that count
was zero.


> I think we should be able to handle=20
> this without changing the use count and that this is preferable becau=
se
> otherwise we make more work with shared consumers, which should be th=
e
> simplest case.

That's what the earlier versions of this patch did,
but you rejected that approach ... patches against
both mainline (which is where the bug hurts TODAY),
and against regulator-next.

Also, I don't see why you'd think a shared consumer
would be the "simplest", given all the special rules
that you've already noted as only needing to kick in
for those cases.


> The trick is getting the non-shared regulators into sync with the
> internal status,

I don't see why that should need any tricks.  At
init time you have that state and the regulator;
and you know there are no consumers.  Put it into
a self-consistent state at that time ... done.

There are really only two ways to make that state
self-consistent.  And you have rejected both.


> ideally without doing things like bouncing supplies=20
> during init. =A0I think either using regulator_force_disable() or say=
ing

The force_disable() thing looks to me like an API design
botch.  As you said at one point, it has no users.  And
since the entire point is to bypass the entire usecount
scheme ... it'd be much better to remove it.


> that the consmer wants exclusive access on get and then bumping the u=
se
> count for it if the regulator is already enabled ought to cover it.
> I've not thought the latter option through fully, though.

The problem I have with your approach here is that you
have rejected quite a few alternative bugfixes applying
to a common (and simple!!) configuration, but you haven't
provided an alternative that can work for MMC init.

I'm really at a loss to see a way out here.

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
