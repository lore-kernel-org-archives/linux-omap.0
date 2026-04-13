Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D723EAB2;
	Mon, 13 Apr 2026 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776106170; cv=pass; b=u8k3UgBOpeaFJuR9KH0sL6xQwWTpHLVCZ4BUgC3B1tJvKWSNNLGc/riAwtQjlQNTbiamRxuqiM5As/AMOD1Xe7io9pswajafLwG4Y9Vxzf4ETcSSBLkyQDbxA+DjHlyXIBYr6xKoi8Y8aYxFZGkORdo52PfMqM+VWudLTNftINw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776106170; c=relaxed/simple;
	bh=QP1E9clGppJ9NWL6qOBpqIa2PzR9/wwMNu+sr5RB+Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GYFZEqO29dT9OSWqp0sPNZDMjtaIsmgC1yzglIOvJY+KR8f+TFSgbqRJDzpBcAfz2jpGJGmIgz9Gkd0W3vJIIrQN9+HzqhloZlIn6w4SiBjjYyXX65py/x+d7/TzobSBtKZFRJBUOzUJOHXNxMzCNUqPm6JX19bR2t9Q/aScgIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=iyLHmEZK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="iyLHmEZK"
Received: from darkstar.musicnaut.iki.fi (unknown [83.245.248.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fvbzb2F4nz49Q3p;
	Mon, 13 Apr 2026 21:49:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1776106157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=q9pfGqloW2kqqyVE7kiHQtdBMSV/86M7juq7PDfUcZg=;
	b=iyLHmEZKnOcS6xR2jNBqaN3ctsLEA0kNDQ8hguWOH0yuWfiIryuz592uPGRjoHXR1tuobQ
	PTCWTwo+pZZM0KAGEfYz+Cn1knyW0qFooS20gEz5A9gyd55U72tEKhQYQVr6E8UchzHLrE
	2IA52Slki0Q1lfWFK/r91RLRs7Qqcubts93Y/TLtp/xiREM0jvO1AVxqK/8T2Z6/vOjZgx
	b0Vo0G6eDhxuS61HuQ5yJqdIy6sBnrtz3cWYrt9PWyRlcHlTrpT3dk3S92iDv+Z1mc3RDO
	a0CGUUPdPDkYEFy3JRNOgRFNGlqvW0iosIOF+350W72yNeAhvi0RRS6ys2alhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1776106157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=q9pfGqloW2kqqyVE7kiHQtdBMSV/86M7juq7PDfUcZg=;
	b=eHqQj2NoJ8nG0e4d+oqnyc+SZ9arl/1Us4aNG/1er0hsQUQsBlJnQr2PQOif6jWwqweBCE
	hxWxIl4R8nr7m/efQuH70bqa4quhaz7tbYNVK+P8CN98BPfJSqgCDOg5EMuv6wl3Ol2BOD
	hM2bMMSTv+C5IkuhH/cG+F4cOayDOYePvTN/N54n7td6ancyFTeBevpGCLlOU+7MbuQIqp
	oN5AiBOLDJKptlgydnZ/dJPYkz5EL3r+qxl08ciF79TBQw1vF2NszKzOYloZDqZDAUWQsf
	6p+cNbB7qu/bs7vBctePD/x4Oit7aWIwkSYm/TzRiaUFd115IkXOZURlgsxNuA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1776106157;
	b=gGD9J8NW0QvoIryyqqEaOhlSfLBj5okcYePNhZduP+dLePR5iwvnY1TKLYOpX/iAy9iNsV
	d/aAg3MtfG27fs6OaqQpXlFFXVXpegtxkKC40I8yfWRq0Qo/DvInUDATfdm4q3544i16B8
	Ay5sY4gGct770kusQxYn3ciDiXJmU03Vhv5RhJbAGOxzid6H7vZ4Zlkw2x+S+Knp3l6va+
	ZCZEYbKYe0gZJEJpRqrF5oYTIqKEJOmzFqNc7vVzIFekWjvBeXh6ot6YMbGqH5ChECL+q9
	ngURBoRlUAbb5cOESzeg4qEo/sfDGRvc7Ca392WWH+kYjFoy+9V0NJH+dlNwuw==
Date: Mon, 13 Apr 2026 21:49:12 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH] USB: omap_udc: DMA: Don't enable burst 4 mode
Message-ID: <ad06qHLclWHeSGnV@darkstar.musicnaut.iki.fi>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 65111084c63d7 ("USB: more omap_udc updates (dma and omap1710)")
added setting for DMA burst 4 mode. But I think this should be undone for
two reasons:

- It breaks DMA on 15xx boards - transfers just silently stall.

- On newer OMAP1 boards, like Nokia 770 (omap1710), there is no measurable
performance impact when testing TCP throughput with g_ether with large
15000 byte MTU size.

It's also worth noting that when the original change was made, the
OMAP_DMA_DATA_BURST_4 handling in arch/arm/plat-omap/dma.c was broken, and
actually resulted in the same as the OMAP_DMA_DATA_BURST_DIS i.e. burst
disabled. This was fixed not until a couple kernel releases later in an
unrelated commit 1a8bfa1eb998a ("[ARM] 3142/1: OMAP 2/5: Update files
common to omap1 and omap2").

So based on this it seems there was never really a very good reason to
enable this burst mode in omap_udc, so remove it now to allow 15xx DMA
to work again (it provides 2x throughput compared to PIO mode).

Fixes: 65111084c63d7 ("USB: more omap_udc updates (dma and omap1710)")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/usb/gadget/udc/omap_udc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 91139ae668f4..f3ca79cece1b 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -733,8 +733,6 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 		if (status == 0) {
 			omap_writew(reg, UDC_TXDMA_CFG);
 			/* EMIFF or SDRC */
-			omap_set_dma_src_burst_mode(ep->lch,
-						OMAP_DMA_DATA_BURST_4);
 			omap_set_dma_src_data_pack(ep->lch, 1);
 			/* TIPB */
 			omap_set_dma_dest_params(ep->lch,
@@ -756,8 +754,6 @@ static void dma_channel_claim(struct omap_ep *ep, unsigned channel)
 				UDC_DATA_DMA,
 				0, 0);
 			/* EMIFF or SDRC */
-			omap_set_dma_dest_burst_mode(ep->lch,
-						OMAP_DMA_DATA_BURST_4);
 			omap_set_dma_dest_data_pack(ep->lch, 1);
 		}
 	}
-- 
2.39.2

