Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF723FFF8C;
	Tue,  7 Jul 2026 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783427580; cv=none; b=kv/+8k0X5R443xGD2W+zYHvscb4VvTL6fprtqnaIjSM3p7QqyH23U+otMQw/FXaf5V2avqkcDfA6DD97Cl7MGNabnPjWjwN6YNd6vqATNKEQneMCAjJoj4jWCFc5RmSgXwTb60AxcNFqHPQDcBhrt9gcfaIAT6ziJFpcg5C72ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783427580; c=relaxed/simple;
	bh=jjBM9uBg4GNRJAA5jD9ZbVotfoOzWeYAB0imw5MTdIk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MsufLgOdtKb3P6AlcO8H9mLz6FpAMa0q0gOk+La7fsS0w2R2qs9+Vm4XKD0Ov1MAy2DEL7G3f9s7XZ6XQ3B3bdOnTGhUpgB4whB6kQclt5s5i5KsDkYhHGKnHlHJHwcQrsQeJAzohoRK4GqWPqraQ1nVAcpXjE53CUeLk9vVZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=ZeWlRbob; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ZeWlRbob"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=WhKnRiGBppKNpN86Hrh1BNfq/F8SUBk6UDvxQS7rtwE=; t=1783427579; x=1784637179; 
	b=ZeWlRbobYriXf4b8YciyeYjCsLBeSQ+I1oFounRqs8PDkCuc0ZLdxln6pej6OAYPs0dqjObivhz
	aiQM46xnqHxGfRW7ra8QBkUV7rT8Ko4ZlwGzunqoy7wXeQab5XfVVDfzDBIwYJ740VW9juLvQQ6tw
	vbonoqMBK6vaPDrx1gVJl8DEPBJWwoDMQVxINAPP8KM8xVDafjfc1W8wZ2LaSipCbZ+3q1acTnVN4
	YEyIC08Hgoc2GQ5HGahpKLMqcTq4LnhAVqG7+M9IwHvWAP7B+EngVmmiSistLfc96PaFOc4xK5nAi
	3wVZuyXt37Le/5Z71ZbJOFnH3edojQArn6xg==;
Date: Tue, 7 Jul 2026 14:32:54 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: sashiko-bot@kernel.org, Helge Deller <deller@gmx.de>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sashiko-bot@kernel.org, Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH] fb: omap2: dsi: do not copy isr table
Message-ID: <20260707143254.76bbb791@kemnade.info>
In-Reply-To: <20260702160541.340B11F000E9@smtp.kernel.org>
References: <20260702-fbomap-uaf-fix-v1-1-6417edf9d3e7@kemnade.info>
	<20260702160541.340B11F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 02 Jul 2026 16:05:40 +0000
sashiko-bot@kernel.org wrote:

> [Severity: High]
> This isn't a bug introduced by this patch, but it appears the identical
> use-after-free vulnerability you are fixing here remains unpatched in the
> equivalent DRM driver.
> 
> Does drivers/gpu/drm/omapdrm/dss/dsi.c:omap_dsi_irq_handler() need the same
> fix? It still copies the table and drops the lock:
> 
> drivers/gpu/drm/omapdrm/dss/dsi.c:omap_dsi_irq_handler() {
>     ...
>     memcpy(&dsi->isr_tables_copy, &dsi->isr_tables, sizeof(dsi->isr_tables));
>     spin_unlock(&dsi->irq_lock);
>     dsi_handle_isrs(&dsi->isr_tables_copy, irqstatus, vcstatus, ciostatus);
>     ...
> }
> 
> This could still race with a timeout in dsi_sync_vc_vp(), which creates a
> completion on the stack:
> 
> drivers/gpu/drm/omapdrm/dss/dsi.c:dsi_sync_vc_vp() {
>     DECLARE_COMPLETION_ONSTACK(completion);
>     ...
> }

Enitities with access to cerebral richness can find the link in the patch
to the version for the drm driver.

Regards,
Andreas
