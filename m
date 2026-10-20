Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792527822;
	b=ZlIBXUsxE4ubjEuvG/Xr71r8P+X+M9V3KbHbVnLOHXEhxtk44Jv2Hs4F+bZL4vnyWqa+
	 9z9XUysp30qycXalmmy3W7t65QiPZ/P6wdpsrTFsTRKtKvohQjJc7wptBKWJ+g4dAo25C
	 b8kWc1fynK6Y4OthlbJ1eZJS+watR5ebcgrJvw+w3Udoa4wWFDkdIQIc6aWsx87goBSbb
	 aCeuqeIa87F68ZZk6r+BR1mSB2XmtddhjP+0Mfs54bqfzT5ZLMHwxUaNovxW4iRjLHL3g
	 xx66JQJQK3J/0sWdMHBP69DC1dozSUNgXAmekUM8RLgJg8Iire97PR9mtB0kPGT7NRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792527822;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dksK0LI9fiDIV7Sk6UMzvHNbgK5hpd3kcFd8ssFu2So=;
	b=lNqRKanj3XZAhKfOHeF2AaY2Rkl0IOju8+eXJNbthlCemTOHvNFFqtVRfy6orA8K5syn
	 /W9kBPxLqUY2jp2jST26myiwsVyLUsORksoEbZlgMWXlaG/ny/YzfhQNl1EDqTwS3W8Np
	 lQ6HN0oOOJDSUbZUwwB+oCYiYDYGr/Hn7fa5+EDZU4ddzt796nnme4+1731Q5uEGWeG5h
	 A1VAo3xVEk+qPcP5B/di51XUMQfCTX9C4jV6D/BFJ7rCb9u99U7zqoWhyoas9a0IGfbIO
	 cd8SYRgNeGw3T2nDnb7Vu+mI+tObXHjW4EL89wNwOY10FTBMrzODWBnAB8oDBQsQpRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=+XLj+flM;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22253606A31C;
	Tue, 20 Oct 2026 20:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22253606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=+XLj+flM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=dksK0LI9fiDIV7Sk6UMzvHNbgK5hpd3kcFd8ssFu2So=; t=1792527821; x=1793737421; 
	b=+XLj+flMO/avX97FfAAGs7F8H+Gxuz0imXvF/WcpN17og9Bx1vVsSo0pp6AZTEj+CyFUVO5rua2
	JP8VUZPlF1fJONnV/ql0u8FkTz6BvSF9Vy5zbrAk/87DuO2SxMZB2J07lsCSdMoq23qHJtGcQnIpW
	zECbTHgoK1SM/djrCcd1QQyhgJXnQRtHqmFuvmdRW92vPRjt9WsOSiJ4++/1NA9C6GheIGb9jcn/B
	LYywhCFWneLHYsLaik2dohpf42CFaxPceAHSzw9nhtUtvq+xtKTBenG4WydXDEACX3SZBY+KdcD/j
	rhzIpfBtEtjvgs760w0NZu2NN6CB3Pd4L6RA==;
Date: Tue, 20 Oct 2026 22:23:35 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>, Aaro Koskinen
 <aaro.koskinen@iki.fi>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern
 <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] usb: ohci-omap: implement overcurrent handling for
 GPIO-based power control
Message-ID: <20261020222335.7133c8a2@kemnade.info>
In-Reply-To: <CAB_t1-ACDiUrXneHbqVy6GWcuCJqnQNdM0poRyrdv_y7G6TKzg@mail.gmail.com>
References: <CAB_t1-ACDiUrXneHbqVy6GWcuCJqnQNdM0poRyrdv_y7G6TKzg@mail.gmail.com>
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

On Mon, 19 Oct 2026 19:45:15 +0330
Muhammad Mahdi Amirpour <ampr.mhd@gmail.com> wrote:

> I do not have the hardware to test this patch, so I cannot verify it
> at runtime. Given that this is a legacy driver, I am happy to drop
> this patch and work on something else if you think that would be
> better. Otherwise, I can send a v5 addressing the Sashiko bot findings
> (the IRQ handler ordering and the probe falling-edge race).
> 
> Please let me know how you would like to proceed.

So this patch practically only used on omap1, it does not improve
maintainability (e.g. by removing the last user of some API) or
apparently not a critical bug. So it should be tested.

It should probably not be first priority to implement something you
cannot test.

@Aaro do you think that improves something valuable?

Regards,
Andreas
