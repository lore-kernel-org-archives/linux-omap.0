Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184140;
	b=pGSEuLDGhjh+Ty//G8TP5QhJxFMhnZAePxc9B+Fh0HENbIVC6RQbVq7txF2VUzYo0ybF
	 R0JF98muCDGEYaQH9DryRWKTqqzPz8JkFenzVqGGzlPzamtAjaj0yvOR6EwMADK+Uajv3
	 pfAJGFx7v+rzC+BNzo1zFkrvd3SiVVnie3ewKLSS+bJIQVJnW6ExHzK91D5Cv4HU+EHEL
	 pv9PR0umXo6Q4nlaJAPzg8ATy1ofOVKN/uJ5vBGGVnp2DN13lJowH3pg/WS7TqYeIbBpg
	 A+LTPHfdYUU0ixMxSaaSC7KBBI0oojs7QZNL97KkyNQase6sTLSdY5I3mTW7lyo2bhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184140;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HqefVXcaCxEhIu49wuMHH1PTYdplvnQs6UJ8+Hj9kwk=;
	b=Mvc/D/0WCqmRpx1z+iB4lmGSoEx+jv1O5JNzvYFKp/ojO6yiEI7LhGTBLmZSxQfKhfm+
	 cTJ/YnzD5p71+Fcr5lJjBLslSO4Y3janTK27gYRCDJXnV6weej3DZqVDq5KHWDvGedFUR
	 B+HSWHWCLl3GUONvdquh3orKCiurzUj9MBJByxzvEuTOUSAK8bShI5jXsyrGaR1EQzF3C
	 cPuQ5UiuaFz3pEMD8TXHxGIfnq2W+6v36cScEdZgc1/zjwxAOxItDzy2QjsFkCakQUvTc
	 pS87k+ughfQtpvEdXLosfV6H72DLB+q6kGrfse6Ex/f5JC+qRVUSz/Hs+fyO7HsHPiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PjGkazSK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF34606A335;
	Fri, 20 Nov 2026 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PjGkazSK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274B51F000C6;
	Fri, 20 Nov 2026 14:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795184139;
	bh=HqefVXcaCxEhIu49wuMHH1PTYdplvnQs6UJ8+Hj9kwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PjGkazSKPLft2aI71A8fYJVNGO/DtQMXszP0BZ3CAdQEaLtBa/ixTU6luQnapnJ34
	 SMiGbjLv8aQsXPqOialcO0jXpEB2GQ1FBWr7GMZE25jAXb46czt831mwJ5j2x3SwrB
	 aJm/moDzuOKGDMBbo7ypk5bT1lkwPaATJdTfGFQk=
Date: Fri, 20 Nov 2026 15:15:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Frank.Li@oss.nxp.com
Cc: Bin Liu <b-liu@ti.com>, Frank Li <Frank.Li@nxp.com>,
	"open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER" <linux-usb@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:OMAP USB SUPPORT" <linux-omap@vger.kernel.org>,
	imx@lists.linux.dev, vkoul@kernel.org
Subject: Re: [PATCH 1/1] usb: musb: use dmaengine_desc_set_callback()
Message-ID: <2026112028-unicycle-filing-6dfd@gregkh>
References: <20261102180300.3966399-1-Frank.Li@oss.nxp.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102180300.3966399-1-Frank.Li@oss.nxp.com>

On Mon, Nov 02, 2026 at 01:02:56PM -0500, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace open-coded assignments to callback, callback_result, and
> callback_param fields of struct dma_async_tx_descriptor with calls
> to the dmaengine_desc_set_callback() helper.
> 
> No functional change intended. Prepare to make struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/usb/musb/musb_cppi41.c   | 7 +++----
>  drivers/usb/musb/tusb6010_omap.c | 3 +--
>  drivers/usb/musb/ux500_dma.c     | 3 +--
>  drivers/usb/renesas_usbhs/fifo.c | 3 +--
>  4 files changed, 6 insertions(+), 10 deletions(-)

Does not apply to the usb-testing branch :(
