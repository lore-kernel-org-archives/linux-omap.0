From: Somnt <er.somnt@gmail.com>
Subject: Re: SDMA, RAM to RAM transfer issue
Date: Fri, 13 Jun 2008 16:58:31 +0900
Message-ID: <5b1a99070806130058u5a0840c6pd6dc0124fb7a34dc@mail.gmail.com>
References: <5b1a99070806121834o10ce0a6cxa2b8552d8e1a283c@mail.gmail.com>
	 <9E8AB4F8CD83E542A3EF3F7DD3E7C55F0547F7E7@dlee11.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:40112 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbYFMH6w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2008 03:58:52 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2438241ywe.1
        for <linux-omap@vger.kernel.org>; Fri, 13 Jun 2008 00:58:31 -0700 (PDT)
In-Reply-To: <9E8AB4F8CD83E542A3EF3F7DD3E7C55F0547F7E7@dlee11.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi! Brandon

thanks for the reply.

config register values in Hex are as follwing:

Registers val CSDP: 2
Registers val CEN: 100
Registers val CFN: 1
Registers val CSSA: 87978800
Registers val CDSA: 87978c00
Registers val CCR: 5000
Registers val CSE: 1
Registers val CSF: 1
Registers val CDE: 1
Registers val CDF: 1


values taken just before triggering DMA from kernel module.
all for channel 31.

with wishes
Somz
