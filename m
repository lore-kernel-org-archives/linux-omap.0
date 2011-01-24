From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 00/13] OMAP: Basic DVFS Framework
Date: Mon, 24 Jan 2011 08:18:48 +0200
Message-ID: <20110124061847.GH2756@legolas.emea.dhcp.ti.com>
References: <1295618465-15234-1-git-send-email-vishwanath.bs@ti.com>
 <20110122171805.GA14774@legolas.emea.dhcp.ti.com>
 <08a041d030691db0dd00737a6342d3d1@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:34508 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751342Ab1AXGS5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 01:18:57 -0500
Received: by gxk8 with SMTP id 8so1359758gxk.41
        for <linux-omap@vger.kernel.org>; Sun, 23 Jan 2011 22:18:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <08a041d030691db0dd00737a6342d3d1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, patches@linaro.org

Hi,

On Mon, Jan 24, 2011 at 11:31:20AM +0530, Vishwanath Sripathy wrote:
> I do not think DVFS layer can be made a generic layer outside OMAP because
> of the fact that DVFS is closely coupled with OMAP device layer (for
> getting hwmod related data and clock handling), OMAP voltage layer (for
> voltage scaling and handling of dependency voltage domains) and smart
> reflex layer.

that an implementation detail. If you:

	a. make the DVFS layer so that you need a HW-glue layer which
	will use OMAP-specific APIs; or

	b. pass function pointers for the generic DVFS layer to use

(note that I'd rather have option (a)), you solve the problem, no ?

-- 
balbi
