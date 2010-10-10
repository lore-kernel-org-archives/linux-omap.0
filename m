From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCHv3 00/11] staging tidspbridge: iommu migration
Date: Sun, 10 Oct 2010 20:32:45 +0300
Message-ID: <AANLkTimoTmhAw11jJihiuyByzKZ9KTFHvx6iw8oeLCGg@mail.gmail.com>
References: <1286310944-25035-1-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40420 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589Ab0JJRcs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Oct 2010 13:32:48 -0400
In-Reply-To: <1286310944-25035-1-git-send-email-x0095840@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fernando Guzman Lugo <x0095840@ti.com>
Cc: gregkh@suse.de, felipe.contreras@nokia.com, ameya.palande@nokia.com, nm@ti.com, Hiroshi.DOYU@nokia.com, ohad@wizery.com, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com, linux-omap@vger.kernel.org

On Tue, Oct 5, 2010 at 11:35 PM, Fernando Guzman Lugo <x0095840@ti.com> wrote:
> This set of patches remove the dspbridge custom mmu
> implementation and use iommu module instead.

I have tried this, it works for simple tests, but not real use-cases.
I applied all your iommu patches. How did you test this?

-- 
Felipe Contreras
