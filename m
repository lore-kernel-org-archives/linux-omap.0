Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039431632E7;
	Sat, 30 May 2026 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780128101; cv=none; b=q27WR8xpKU5iRT7E8PBdTVRBO34Ql6zv3a9dUX0LI9pax3rB7nX2qGQRsfaWU6hV+VKYrgZf3GoTjxdidCM1PEugcsNZU3bnKDw6PocJyQCB2ixArqxjJZD/Yn1FaOpfmgCh3rNMx0rsnXfoCwOiigAJO/PupsUdC3/weQF4g0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780128101; c=relaxed/simple;
	bh=GuP85RoTQvpPVfuCewq6BaYo8BPTlIe6mupyEz3pAyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrk8+Aal36ZGE2+QncKv8ourHXdpyBfdtHt0l7pPcPTLkhGZQp9/5nEG3uZ20MTSCWRtQvEjpqK4u7znqYHV1Z5l7nX72j/MY4XYekLpvdBCOgCtyd+DErFSIBaJmoR7T/6YV2Swt8Zm/4Tg6M6y6TMFkV+egx40Y/BwYYO26aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=li6VMNQ9; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="li6VMNQ9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=k/4+sIfuD76gWiDJ7nlP7yp+chsnq/e4G6cSrxRXb34=; b=li6VMNQ9j3X0aS8gzad66Vf85n
	8/9sFXKfM76buhkjJBOIvU0spfJaPwxEQUcqd8BftHwP91s9GCME8eMvIzfI1Lt7r6nVpGdJ66iDe
	VQTczp+bu7b352vyRfxxRAp4qdDh1wEq2wLuoHcvIga9jC3sksErq5izvrriZqDSl9brKNl4UWxyt
	e4kWlsI3k0t47p++uIbrAFVcmMnAZs9j53J0uBkhrOQvP/WkZM5nFHsOquL06wjsg1Ll+F2LS//0E
	yGcPsxFcZfeb6cLSnWr4JXFeq7oS4WXUwE52A8qnKm4dcZYOt/IPv8Gzgqj/iSfhsajHJreq/ePK8
	X3+uTXlg==;
Date: Sat, 30 May 2026 10:00:48 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: airlied@gmail.com, daniel@ffwll.ch, u.kleine-koenig@pengutronix.de,
 arnd@arndb.de, laurent.pinchart@ideasonboard.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Tony
 Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Sebastian Reichel
 <sre@kernel.org>
Subject: Re: [RFC PATCH] drm: omapdrm: dsi: add refsel also for omap4
Message-ID: <20260530100048.7dd1b3e1@kemnade.info>
In-Reply-To: <48972ab0-e4ed-11b2-31fb-ad93695a4db1@ideasonboard.com>
References: <20230913065911.1551166-1-andreas@kemnade.info>
	<48972ab0-e4ed-11b2-31fb-ad93695a4db1@ideasonboard.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Sep 2023 15:11:08 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> On 13/09/2023 09:59, Andreas Kemnade wrote:
> > Some 3.0 source has it set behind a if (omap4).
> > Maybe it is helpful maybe not, at least in the omap4460
> > trm these bits are marked as reserved.
> > But maybe some dsi video mode panel starts magically working.  
> 
> Sorry, what does this mean? That this fixes something, or you are just 
> guessing?
> 
> I'm somewhat sure that the upstream driver used to work on omap4 sdp, 
> which has two DSI panels. But I can't even remember what omap4 version 
> it had.
> 

this thing is definitively not needed. I have dropped this patch from
my tree.

Regards,
Andreas

>   Tomi
> 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >   drivers/gpu/drm/omapdrm/dss/dsi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
> > index 60189a23506a1..e2f576cd9f63c 100644
> > --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> > +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> > @@ -4505,7 +4505,7 @@ static const struct dss_pll_hw dss_omap4_dsi_pll_hw = {
> >   	.has_stopmode = true,
> >   	.has_freqsel = false,
> >   	.has_selfreqdco = false,
> > -	.has_refsel = false,
> > +	.has_refsel = true,
> >   };
> >   
> >   static const struct dss_pll_hw dss_omap5_dsi_pll_hw = {  
> 
> 

