From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: Determining reason for power-up : warm or cold boot
Date: Wed, 2 Feb 2011 15:08:31 -0600
Message-ID: <4D49C7CF.1070400@ti.com>
References: <66BB0CC3-00BA-4C5B-A3E7-42295A339255@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36835 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab1BBVIi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 16:08:38 -0500
In-Reply-To: <66BB0CC3-00BA-4C5B-A3E7-42295A339255@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>

On 2/2/2011 3:03 PM, Elvis Dowson wrote:
> Hi,
>         Is there a register that I can read, to determine if an OMAP34xx chip was powered up because of a cold boot (power cycled off to on), or a warm boot (software initiated reset or software initiated reboot)?
>


Yes, you can read the PRM_RSTST register at physical address 0x48307258.

Cheers
Jon
