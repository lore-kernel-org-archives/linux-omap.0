From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2/8] OMAP4: hwmod data: Add McSPI
Date: Thu, 17 Feb 2011 18:47:25 +0100
Message-ID: <4D5D5F2D.9020100@ti.com>
References: <1297938289-8678-1-git-send-email-b-cousson@ti.com> <1297938289-8678-3-git-send-email-b-cousson@ti.com> <20110217170514.GS20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42033 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757345Ab1BQRrc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 12:47:32 -0500
In-Reply-To: <20110217170514.GS20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>

On 2/17/2011 6:05 PM, Tony Lindgren wrote:
> Hi,
> 
> Noticed one cosmetic thing below.
> 
> * Benoit Cousson<b-cousson@ti.com>  [110217 02:23]:
>> Update omap4 hwmod file with McSPI info.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Signed-off-by: Charulatha V<charu@ti.com>
>> Signed-off-by: Govindraj.R<govindraj.raja@ti.com>
>> Acked-by: Grant Likely<grant.likely@secretlab.ca>
>> Reviewed-by: Kevin Hilman<khilman@ti.com>
>> ---
>    ^^^ That should not be here, it shows up in your commit.
> 
>> [b-cousson@ti.com: Remove dev_attr to prevent dependency
>> with device code. It will have to be re-added along with
>> the original series]
> 
> As the above should be part of the commit too. Care to
> refresh your branch for that?

Done. I added the USBOTG for Felipe as well.

Thanks,
Benoit

---

The following changes since commit 85e2efbb1db9a18d218006706d6e4fbeb0216213:
  Linus Torvalds (1):
        Linux 2.6.38-rc5

are available in the git repository at:

  git://gitorious.org/omap-pm/linux.git for_2.6.39/omap4_hwmod_data

Benoit Cousson (9):
      OMAP4: hwmod data: Add hwspinlock
      OMAP4: hwmod data: Add McSPI
      OMAP4: hwmod data: Add timer
      OMAP4: hwmod data: Add DSS, DISPC, DSI1&2, RFBI, HDMI and VENC
      OMAP4: hwmod data: Add mailbox
      OMAP4: hwmod data: Add DMIC
      OMAP4: hwmod data: Add McBSP
      OMAP4: hwmod data: Add AESS, McPDM, bandgap, counter_32k, MMC, KBD, ISS & IPU
      OMAP4: hwmod data: Add USBOTG

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 3119 +++++++++++++++++++++++++++-
 1 files changed, 3072 insertions(+), 47 deletions(-)
 
