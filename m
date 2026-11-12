Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484314;
	b=oUyI7AV/0sbhqnkRESzHlU68K4GVeN6c6CkGoC+snpKjpmEu+3OBJ8smt8s+mQDxMs/w
	 l3UungVFufExQyR8gsKgCAfJd444cddW+HtCY87iTSVCelpSRSgaa/h46T9sWXP1ZrRgg
	 NdVZ9k0g250knXVW5jYjhWJXcH7kmA8OTeNNBQ33pyfpYXU2fYqzwsCpqwVjqrwPm/72V
	 Ye+YNR9lZyHXGzoY9B7q426tUbhkT/lFXKkqCTg/6iBFjGvKlipPE7fG9CfwgyoUYLaxi
	 7+jk9yAEXYIufwPTA1T2EPJXX7uMgxtHhavDzcOGhobw0hgzEIJL1WtxiExMVYFGlUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484314;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6R6toNBIUivUY49SbPVzsOWR13YYc6Q05DyfYkrwtKU=;
	b=WNbqrB+rnZj0z1sr88uYhEM2x7Vl6d/kkj1nlSselBPc+0C9TY/PP7ApW8tVrNSo2t1Y
	 9TJOTQLXMqvkG5R4pkhBvDYQhWQwpTx1pOcTrorO/1smp6yJiRz0C35rPfIiHGHHt/FE2
	 tbbpynKZ9pc3rTmOflEe2EZu+aXwNJHKl16MIeMmVtBuhnIQfwXy5vaomqnvrC5WfLO/k
	 6UXuspguBwqNk9eyGEDor+z00fbPuT5DbNDWWfb9wfOKD5jmGXTsfpqXjY+Ss7MxwdfLr
	 uOAT+hzcSUIWjEex+dvvPpTYK/kjRSU6mrAp02rxuUhr7sNfGgNoBZREErTENrnI7Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=TtVbtc7c;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D3606A321;
	Thu, 12 Nov 2026 11:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 567D3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=TtVbtc7c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=6R6toNBIUivUY49SbPVzsOWR13YYc6Q05DyfYkrwtKU=; t=1794484314; x=1795693914; 
	b=TtVbtc7ceYK43A0qJYJPRllpoZEHlClOLnU1qDM+3OKrKNiEqLQfJ5ItSD2GjEdgg/e5j4mjGDW
	9taxb613RS3QK05Z0lLzeGCvTxcBxNAlGe+6Phmty7W9InoWZbVyLp/xSjExaAPKPqzVS0w94Vw9K
	edc4+/mwrKfPyCMIrYY//bJt4ZJNW7GFCWgt0hcdaekwuKi7UIHBqgV6cUmzYjBFNn7s1qHEqUnSM
	WJUGrWUftUqu+b9VonZsf6+dh974YNp4yEQC7KqYHK0eLAfXbkJpR7LofIJfgFYGsjWSbFIVcCPzC
	yb23yKCinffAXtEpd34PMIZ71oQfPJ5JUenQ==;
Date: Thu, 12 Nov 2026 12:51:48 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>,
 <dri-devel@lists.freedesktop.org>, <linux-omap@vger.kernel.org>,
 <hns@goldelico.com>, <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Subject: Re: [PATCH] drm/omap: dss: fix handling deferrals
Message-ID: <20261112125148.23235dec@kemnade.info>
In-Reply-To: <DMSHYXQ01R6O.3F13LZ51TUPCP@bootlin.com>
References: <20261111-gta04-drm-regression-fix-v1-1-1de27d5ba46a@kemnade.info>
	<33f63eaf-42a0-4b3f-a21c-3752436d07b4@ideasonboard.com>
	<DMSHYXQ01R6O.3F13LZ51TUPCP@bootlin.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 16:46:51 +0100
"Luca Ceresoli" <luca.ceresoli@bootlin.com> wrote:

> Hello Andreas,
> 
> On Wed Nov 11, 2026 at 3:56 PM CET, Tomi Valkeinen wrote:
> > Hi,
> >
> > On 11/11/2026 14:22, Andreas Kemnade wrote:  
> >> Forward the error given by of_drm_get_bridge_by_endpoint() if it is
> >> EPROBE_DEFER to ensure output gets initialized later when available.
> >>
> >> On GTA04/OMAP3 no display was found, but it appeared after doing
> >> rmmod omapdrm ; modprobe omapdrm
> >>
> >> Fixes: b7e9b93fc8ecf ("drm/omap: dss: don't create a panel_bridge")  
> 
> Ouch, sorry about breaking this driver. To my excuse the old code removed
> by b7e9b93fc8ecf was (ans still is) pretty obscure.
> 
> >> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >> ---
> >>   drivers/gpu/drm/omapdrm/dss/output.c | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
> >> index 36d37deac8026..220ed7e003080 100644
> >> --- a/drivers/gpu/drm/omapdrm/dss/output.c
> >> +++ b/drivers/gpu/drm/omapdrm/dss/output.c
> >> @@ -24,6 +24,11 @@ int omapdss_device_init_output(struct omap_dss_device *out,
> >>
> >>   	bridge = of_drm_get_bridge_by_endpoint(out->dev->of_node, out->of_port, 0);
> >>   	if (IS_ERR(bridge)) {
> >> +		if (PTR_ERR(bridge) == -EPROBE_DEFER) {
> >> +			ret = PTR_ERR(bridge);
> >> +			goto error;
> >> +		}
> >> +  
> > Shouldn't we just return PTR_ERR(bridge) here? The error label will call
> > omapdss_device_cleanup_output(), which cleans up things set up later in
> > this function.  
> 
> Indeed.
> 
> 
> Additionally, by looking at the omapdss_device_init_output() code right
> now, the goto-based error management appears:
> 
>  1. unnecessarily complicated: only one goto for only one line of rollback
>     code
> 
>  2. potentially wrong, or at least doing too much, because
>     omapdss_device_cleanup_output() does two things:
> 
>       a. drm_bridge_put(out->next_bridge): but when goto is invoked the
>          out->next_bridge pointer has not been touched yet
>          (I assume we should not touch the refcount in this case)
> 
>       b. drm_bridge_put(out->bridge): unneeded because the goto is inside
>          an 'if (!out->bridge)', thus there is no reference at all to put
> 
> Do you agree with these findings?
> 
of_drm_get_bridge_by_endpoint never returns NULL (indicated by Sashiko).
So we have dead code there anyways. So the patch is dead code elimination
and not fixing bugs.

Regards,
Andreas
