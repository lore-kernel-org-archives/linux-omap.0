From: Orjan Friberg <of@flatfrog.com>
Subject: Re: copy_to_user speed from dma_alloc_coherent vs. kmalloc buffer
Date: Wed, 20 Apr 2011 19:09:29 +0200
Message-ID: <4DAF1349.6020008@flatfrog.com>
References: <4DAEF7F0.4080207@flatfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hd5b91d02.k46641.sta.perspektivbredband.net ([213.185.29.2]:10607
	"EHLO fg-dc1.flatfrog.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750836Ab1DTRJc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Apr 2011 13:09:32 -0400
In-Reply-To: <4DAEF7F0.4080207@flatfrog.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 2011-04-20 17:12, Orjan Friberg wrote:
> What are my options (besides using mmap)?

It looks like kmalloc + dma_map_single for the DMA destination buffer 
and then dma_sync_single_for_{cpu,device} around the call to 
copy_to_user pretty much does the trick.  At least the %sys load 
measured with mpstat goes from 13% to 2%.

-- 
Orjan Friberg
FlatFrog Laboratories AB
