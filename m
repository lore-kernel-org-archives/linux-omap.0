From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: DSS2 and 2.6.36
Date: Mon, 22 Nov 2010 15:03:35 +0200
Message-ID: <AANLkTinnWLwRcfdwX5s-+c6vvhgwm6jO7miX0T5wFhS5@mail.gmail.com>
References: <A1FC6DD0-C6CA-4E03-B4DD-C3AD4CCC9619@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55817 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200Ab0KVNDh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 08:03:37 -0500
Received: by bwz15 with SMTP id 15so6083406bwz.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 05:03:36 -0800 (PST)
In-Reply-To: <A1FC6DD0-C6CA-4E03-B4DD-C3AD4CCC9619@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Erickson <marathon96@gmail.com>
Cc: linux-omap@vger.kernel.org

On Fri, Nov 12, 2010 at 8:04 PM, Grant Erickson <marathon96@gmail.com> wrote:
> I have a Mistral AM37x development board and am working on transitioning it from the 2.6.32 provided with the SDK to 2.6.36 and have run into some issues with the OMAP2 DSS driver that it seems others have encountered as well (e.g. "DSS2 broken with 36-rc1" <http://marc.info/?t=128196295000004&r=1&w=2 and "[PATCH 1/2] video: omap: vram: remove from normal memory" <http://marc.info/?t=128714705300004&r=1&w=2>).
>
> Is 2.6.37-rcY the preferred canonical tree to fast-forward to pick up the remap/allocation/reserve changes for this or is there another preferred tree (e.g. git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git or git://gitorious.org/linux-omap-dss2/linux.git)?

2.6.36 should work fine, but you need to configure the amount of VRAM
to reserve: CONFIG_OMAP2_VRAM_SIZE=6, or something like that. Previous
methods (board, omap.vram boot param) don't work any more AFAIK.

-- 
Felipe Contreras
