From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] ARM: OMAP3+: Fix kernel panic on boot
Date: Tue, 12 Feb 2013 10:15:56 -0600
Message-ID: <511A6ABC.3080200@ti.com>
References: <1360614380-20114-1-git-send-email-jon-hunter@ti.com> <20130212100747.GA20996@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45856 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932223Ab3BLQQF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Feb 2013 11:16:05 -0500
In-Reply-To: <20130212100747.GA20996@sortiz-mobl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 02/12/2013 04:07 AM, Samuel Ortiz wrote:
> Hi Jon,
> 
> On Mon, Feb 11, 2013 at 02:26:19PM -0600, Jon Hunter wrote:
>> Commit 8a6aaa3 (mfd: twl-core: Collect global variables behind one
>> private structure (global)) removed the variable "inuse" that is used
>> to determine if the device has been initialised and now use the
>> twl_priv structure instead. This is causing the kernel to panic on
>> OMAP3+ devices using the twl driver, because we try to access the
>> twl_priv->ready member before checking if twl_priv is initialised. Fix
>> this and move this test to the beginning of the twl_i2c_read/write
>> function because twl_get_last_module() also uses the twl_priv structure.
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/mfd/twl-core.c |   16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
> Patch applied, thanks.
> I fixed the subject as it's codewise not ARM or OMAP3 related, but rather mfd
> and twl-core.

Good point! Thanks Jon
