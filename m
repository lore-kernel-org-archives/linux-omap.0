From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCHv2 00/11] staging tidspbridge: iommu migration
Date: Mon, 4 Oct 2010 18:36:10 +0300
Message-ID: <AANLkTik2bj_nr-WG+xF7C3OQaq5biGejGDnb2z2xob8D@mail.gmail.com>
References: <1285899178-14413-1-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44993 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273Ab0JDPgM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 11:36:12 -0400
In-Reply-To: <1285899178-14413-1-git-send-email-x0095840@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fernando Guzman Lugo <x0095840@ti.com>
Cc: gregkh@suse.de, felipe.contreras@nokia.com, ameya.palande@nokia.com, nm@ti.com, Hiroshi.DOYU@nokia.com, ohad@wizery.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org

Hi,

On Fri, Oct 1, 2010 at 5:12 AM, Fernando Guzman Lugo <x0095840@ti.com> wrote:
> This set of patches remove the dspbridge custom mmu
> implementation and use iommu module instead.

I suppose the driver wouldn't work in the middle of this patch series.
I wanted to try this patches and experiment to see if I could come
with a version that doesn't break in the middle, but it turns out the
driver doesn't work at all on 2.6.36, I just sent an email with the
details.

Have you tried with the mainline? Or am I missing something?

-- 
Felipe Contreras
