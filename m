From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [RFC PATCH 5/8] misc: emif: handle frequency and voltage change
 events
Date: Thu, 16 Feb 2012 16:08:18 +0530
Message-ID: <4F3CDC9A.2000303@ti.com>
References: <1328357771-31644-1-git-send-email-aneesh@ti.com> <1328357771-31644-6-git-send-email-aneesh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:55621 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750762Ab2BPKiY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 05:38:24 -0500
In-Reply-To: <1328357771-31644-6-git-send-email-aneesh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aneesh V <aneesh@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

On Saturday 04 February 2012 05:46 PM, Aneesh V wrote:
> Change SDRAM timings and other settings as necessary
> on voltage and frequency changes. We calculate these
> register settings based on data from the device data
> sheet and inputs such a frequency, voltage state(stable
> or ramping), temperature level etc.
>
May be you want add TBD or FIXME for notifiers when they
are available. Do that in commit log as well as
in the code so that we don't forget about it.

> Signed-off-by: Aneesh V <aneesh@ti.com>
> ---
Rest of the patch looks fine.
