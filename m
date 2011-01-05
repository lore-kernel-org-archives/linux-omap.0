From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH v3 08/17] OMAP2,3: DSS2: Create platform_driver for
 each DSS HW IP
Date: Wed, 05 Jan 2011 13:27:03 +0200
Message-ID: <1294226823.14254.51.camel@tubuntu>
References: <1294059069-26737-1-git-send-email-svadivu@ti.com>
	 <1294059069-26737-9-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-da02.ext.nokia.com ([147.243.128.26]:35212 "EHLO
	mgw-da02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab1AEL1K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 06:27:10 -0500
In-Reply-To: <1294059069-26737-9-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: paul@pwsan.com, khilman@deeprootsystems.com, v-hiremath@ti.com, a0919096@ti.com, linux-omap@vger.kernel.org

Hi,

On Mon, 2011-01-03 at 18:21 +0530, ext Guruswamy Senthilvadivu wrote:
> From: Senthilvadivu Guruswamy <svadivu@ti.com>
> 
> Hwmod adaptation design requires each of the DSS HW IP to be a platform driver. 
> Platform driver of dsshw has to be registered before of dispc, rfbi, dsi1,
> venc and omapdisplay driver should be after all the HW IPs. Sequence it with
> arch_initcall and device_initcall_sync.

Do you know if there some extra meaning for the _sync initcalls? The
name would imply something else that just init ordering.

I don't like using multiple initcall levels in the same driver. It's
already quite complicated with omapdss, omapfb and the panel drivers.
What were the dependencies here? Could we have just one initcall which
would do the registration of platform drivers in the correct order?

Does this even work if the DSS is compiled as a module? I have the
recollection that a module can only have one initcall, and in this case
omapdss would have many.

 Tomi


