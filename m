From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH 1/1] ASoC: AIC23: Fixing writes to
 non-existing registers in resume function
Date: Fri, 29 Jan 2010 11:00:04 +0000
Message-ID: <1264762804.3080.23.camel@odin>
References: <1264753735-7190-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:29053 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab0A2LAI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 06:00:08 -0500
Received: by ey-out-2122.google.com with SMTP id d26so428853eyd.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Jan 2010 03:00:06 -0800 (PST)
In-Reply-To: <1264753735-7190-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com

On Fri, 2010-01-29 at 13:58 +0530, Anuj Aggarwal wrote:
> Commit e9ff5eb2 (Fixing infinite loop in resume path) uses wrong AIC23
> register in resume function because of which register writes happen
> on some non-existing registers.
> 
> Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>


