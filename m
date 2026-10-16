Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D9C4219E9;
	Fri, 16 Oct 2026 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136427; cv=none; b=kjnxXzxQ6mAUQ8qAP5A/wg680gU/fyQt99fdS7aC5ACFI1u2o6Bk6XDsf9CtntyRRlnmXcI/sMQcK2V9BVjv6evZ/9smeUjkiUHWTL+EpTFW69cj6vywqkAMUY3AInGkJEOD1POMq3Vp3XrPAqLg3T+Q7d6YP8AdgnXOJluiD1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136427; c=relaxed/simple;
	bh=mofmNipM2hWNiXPFaH0c8qRsysHiI60VRYo4uMGBz40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sr7KG3Uf88VACDRxL+TVbuKzQBbVUzuDlcBl1yCpOyc7z6lEYp1b0xqQXfPZbIOjlUGmR69uedUwk/+wy1x5HGTKWAhaUViKSu84Dsn/U/rOyaG+kWPyXORV9hrNs1wpTWA9wtcGqX4kIdBWJrm/63j/Ff/PzvOwkBGvGSvkj/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyaFapeX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyaFapeX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F231F000C4;
	Fri, 16 Oct 2026 07:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792136424;
	bh=0pz30Arm3iXS3Q4cxaVxmL7XUFi944ujcvdwlwsKw8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SyaFapeXtzdEUqy3FqVnI0LIHeSv0YjGBcQpFcVTeDZARn/2Fc2p8NQj4ynUgVLua
	 7txCYI363gs516E6zngozBd30l3VtDvvgtuBHsi0hZ5Eo28hEyA9kEzct050FIs0LS
	 Kp8mp8RDsCwJLAUVU/e+i0Ji6Tm/VK6rGooiEYMDvtL0XXdEGCkCRmwgn7smZ8FxrJ
	 7unCgxsu6DrdjmCB3+r7i+kKSyCfoJNzlIWpoE6mxzJ0t0UgPPxzYKcWt7HBvFL3U+
	 7b/q4GsQR6kQgRi5wVDRyTTUVc9moaSIShG/Q1K6hHNRg5Hk1Xdf6Z1kgodSUjMqXT
	 MFpzm5BM+RMSw==
Date: Fri, 16 Oct 2026 08:40:19 +0100
From: Lee Jones <lee@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: mfd@lists.linux.dev, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	OMAP2+ SUPPORT <linux-omap@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] mfd: twl-core: Allocate modules with twl_private
Message-ID: <20261016074019.GB2093461@google.com>
References: <20260926013325.75073-1-rosenp@gmail.com>
 <179198497618.839288.9266863610003754798@kernel.org>
 <CAKxU2N_b-wxOuugVm7wzgh4RN9oUCNf1jnHYkKN0--MxHHA_tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N_b-wxOuugVm7wzgh4RN9oUCNf1jnHYkKN0--MxHHA_tQ@mail.gmail.com>

--- checkpatch.pl (3 issues) ---
Line 4: ERROR: Invalid commit separator - some tools may have problems applying this
Line 32: WARNING: please, no spaces at the start of a line
Line 41: WARNING: please, no spaces at the start of a line
----------------------------------

--- checkpatch.pl (2 issues) ---
Line 27: WARNING: please, no spaces at the start of a line
Line 36: WARNING: please, no spaces at the start of a line
----------------------------------

On Thu, 15 Oct 2026, Rosen Penev wrote:

> On Thu, Oct 15, 2026 at 5:05 AM Lee Jones <lee@kernel.org> wrote:
> >
> > On Fri, 25 Sep 2026, Rosen Penev wrote:
> >
> > > Use a flexible array member to allocate the twl_client array together
> > > with struct twl_private. This removes a separate devm_kcalloc() and
> > > keeps the module data tied to the main private structure.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> > >  v3: Capitalize Allocate.
> > >  v2: don't use twl_get_num_slaves().
> > >  drivers/mfd/twl-core.c | 16 ++++------------
> > >  1 file changed, 4 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> > > index f86df356d658..0b78fe30e047 100644
> > > --- a/drivers/mfd/twl-core.c
> > > +++ b/drivers/mfd/twl-core.c
> > > @@ -159,7 +159,7 @@ struct twl_private {
> > >       unsigned int twl_id;
> > >
> > >       struct twl_mapping *twl_map;
> > > -     struct twl_client *twl_modules;
> > > +     struct twl_client twl_modules[];
> > >  };
> > >
> > >  static struct twl_private *twl_priv;
> > > @@ -770,7 +770,9 @@ twl_probe(struct i2c_client *client)
> > >               goto out;
> > >       }
> > >
> > > -     twl_priv = devm_kzalloc(&client->dev, sizeof(struct twl_private),
> > > +     num_slaves = (id->driver_data & TWL6030_CLASS) ? 3 : 4;
> >
> > What's wrong with twl_get_num_slaves()?
> It relies on twl_priv already being allocated.

IMHO, this is too much hoop jumping to save on one pointer.  Code
cleanliness remains much more important here.  And don't even get me
started on that mess in include/linux/mfd/twl.h !

Just define TWL_MAX_SLAVES as 4 and have done:

        struct twl_client twl_modules[TWL_MAX_SLAVES];

> > > +     twl_priv = devm_kzalloc(&client->dev,
> > > +                             struct_size(twl_priv, twl_modules, num_slaves),
> > >                               GFP_KERNEL);
> > >       if (!twl_priv) {
> > >               status = -ENOMEM;
> > > @@ -787,16 +789,6 @@ twl_probe(struct i2c_client *client)
> > >               twl_regmap_config = twl4030_regmap_config;
> > >       }
> > >
> > > -     num_slaves = twl_get_num_slaves();
> > > -     twl_priv->twl_modules = devm_kcalloc(&client->dev,
> > > -                                      num_slaves,
> > > -                                      sizeof(struct twl_client),
> > > -                                      GFP_KERNEL);
> > > -     if (!twl_priv->twl_modules) {
> > > -             status = -ENOMEM;
> > > -             goto out;
> > > -     }
> > > -
> > >       for (i = 0; i < num_slaves; i++) {
> > >               struct twl_client *twl = &twl_priv->twl_modules[i];
> > >
> > > --
> > > 2.55.0
> > >
> >
> > --
> > Lee Jones

-- 
Lee Jones
