From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/3] ASoC: OMAP: HDMI: Update machine driver name
Date: Wed, 14 Nov 2012 10:16:56 +0000
Message-ID: <50A36F98.7060103@ti.com>
References: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com> <1352860249-26348-2-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42784 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161053Ab2KNKRC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 05:17:02 -0500
In-Reply-To: <1352860249-26348-2-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: broonie@opensource.wolfsonmicro.com, s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org

On 14/11/12 02:30, Ricardo Neri wrote:
> Being the name of a machine driver, it aims to describe the connection between
> the HDMI IP of the processor and the companion chip it uses to connect to the
> outside world. This name tries to follow the same naming convention as in
> the OMAP-ABE-TWL6040 machine driver.
>
> TPD12S015 is an HDMI companion chip for DC-DC step-up, I2C level shifter and
> low-capacitance ESD protection. This chip is used on all OMAP4 Pandaboards an
> SDPs as well as in OMAP5 EVMs.
>

Is the TPD12S015 passive or actively controlled by the CPU in this case ?

If it's passive then it's not really worth changing the driver name since 
other OMAP4/5 devices may use other HDMI companion chips (an we can reuse this 
driver without changes).

Liam
