Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2AE1632DD;
	Sun, 28 Jun 2026 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782666061; cv=none; b=he7T6n/oKFJAIdIUWxAdCdsl2dpyoClzywaxHrK6errlP9z2jCdPd0tUP/QmSepxQRmzzna/gHwqPMJe+Y4snqcAkBtCNM8snGa0UHgvTYqn3BzHvaaSYfRmzB5JEiW+pyd+YSi2MtY/gwU6yowjzOP9UTb29vXzLMnD41KP77o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782666061; c=relaxed/simple;
	bh=Ns+2E+8Yzeo2dbaI1Dx1JFsGBDPU9+HGPMo05hbaDXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWiumFyxsBHGgX26KWJU77v3oHzlM/TGxMLEkqZbaSqbopWSSiy7sDDyx74so5SqOqsoIhiv+Pmq3furmVU+A/Lz/bmuLAtx53iivMDmWY/9VVH+yZk72Ve7KTabEj9gHBbgkQOJYMCKKtWBMb+qQIhZH0rR2qB/kzM9k7tg1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=hs5ashEG; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="hs5ashEG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=lOa9hr9hGQ1OVWLjJuIi7OMpViAhrQPbKPwUJ+q4IOY=; t=1782666060; x=1783875660; 
	b=hs5ashEGwvUN+SPjSdKb+1+DFzBcTmPUuM/9ZHgkZVdh/jf1Lwv/BspeYVwkMnhQcR6NtPnPuIg
	+RijUpdz8ZD62+CDFoDbMTZbq1PniE0oYOySHcef6FqjQrgUhwnip1ZN3LDni1aXOFcF2CHHKo8NM
	Y8h0II9UTEjr22QMjz1kNNQoFaLJIPFjvxv+1HSLsRNfr9i6YeDSCtCxuwJ7JwYq6FVMnIBYTTXun
	L5VlEGwW28MJtGje32BH4LTMTPJDidZDQul3S7t4WJBfdZgtBN76jH7ulodacN3xCunLh1kZ8ywk5
	Hl1FQDyiVpDNiOC7sVbvZAqUZYg1RQPvb6RA==;
Date: Sun, 28 Jun 2026 19:00:41 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Tony Lindgren <tony@atomide.com>,
 Linux-OMAP <linux-omap@vger.kernel.org>, Marek Vasut <marex@denx.de>, "H.
 Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/omap: dsi: avoid sending bta sync all the time in
 writes
Message-ID: <20260628190041.4a30f769@kemnade.info>
In-Reply-To: <4cb8a90b-6345-47a8-b15a-a977a33af8b3@gmail.com>
References: <20260528-vm-upstr-v1-1-fb93ef8cbe47@kernel.org>
	<ec1a577b-12fb-402c-9ceb-3c1e8265a7e9@gmail.com>
	<20260528190234.4c00b740@kernel.org>
	<37f64c1c-9920-41a6-a8c0-7a84a30c884a@gmail.com>
	<20260528220603.6600d45b@kemnade.info>
	<20260528221912.1771daa4@kemnade.info>
	<4cb8a90b-6345-47a8-b15a-a977a33af8b3@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 09:26:23 +0300
Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> wrote:

> Hi,
> 
> with the following changes:
> 
> user@devuan:/media/user/7b76ddc8-44f5-47b5-af5b-e5e9b5ab39c3/user/linux_openpvrsgx$ 
> git diff drivers/gpu/drm/omapdrm/dss/dsi.c
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c 
> b/drivers/gpu/drm/omapdrm/dss/dsi.c
> index af27339c79f9..8ffcd95c3bc3 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -2199,7 +2199,7 @@ static int dsi_vc_write_common(struct 
> omap_dss_device *dssdev, int vc,
>          int r;
> 
>          if (mipi_dsi_packet_format_is_short(msg->type))
> -               r = dsi_vc_send_short(dsi, vc, msg);
> +               return dsi_vc_send_short(dsi, vc, msg);
>          else
>                  r = dsi_vc_send_long(dsi, vc, msg);
> 
> @@ -3247,21 +3247,6 @@ static int _dsi_update(struct dsi_data *dsi)

do you really need the change from above?
I think it should not be needed with the other changes.
Waiting on short packets seems to work here.

Regards,
Andreas
