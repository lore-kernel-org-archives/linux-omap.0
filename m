From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv3 0/9] ARM: OMAP2+: AM33XX: Add suspend-resume support
Date: Thu, 8 Aug 2013 09:31:04 -0400
Message-ID: <52039D98.8080309@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60446 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964954Ab3HHNba (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Aug 2013 09:31:30 -0400
In-Reply-To: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>

On Tuesday 06 August 2013 01:49 PM, Dave Gerlach wrote:
> Hi,
> 
> This is the third version of the patch series for adding basic suspend-resume
> support for AM33XX, previously submitted by Vaibhav Bedia. This patchset 
> is based on 3.11-rc4 and depends on a forthcoming patchset from Suman Anna
> that adds mailbox support for the wkup_m3. The patches at [1], [2], and [3] are 
> required for the pm code to properly suspend and resume.
> 
> The PM code uses the firmware interface and expects the userspace to load 
> the WKUP_M3 binary before the suspend-resume functionality is made available.
> The binary file (and the source-code for WKUP_M3) can be obtained from the 
> 'next2' branch at [4]. The WKUP_M3 binary can either be loaded post bootup 
> via the sysfs entry './sys/devices/ocp.2/wkup_m3.4/firmware' or it can be 
> included in the kernel image as part of the build process.
> 
> Suspend to mem is tested on am335x-bone and am335x-evm.
> 
> More details on AM335x suspend-resume are provided within the commit logs
> for each patch.
> 
> Changes in v3:
> - Moved wkup_m3 code into separate driver
> - Split up ti_emif header move
> - Addressed clean-up comments
> - Removed mailbox patches
> - v2-v3 Discussion:
> http://marc.info/?l=linux-arm-kernel&m=135698501821090&w=4
> 
Please CC people who have at least reviewed the last version of
the series. Couple of patches I was CC'ed o.w I would missed this series.

Regards,
Santosh
