From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/2] dspbridge: proc: fix a double-free on 2 error paths
Date: Thu, 18 Feb 2010 17:53:38 -0600
Message-ID: <4B7DD302.6010007@ti.com>
References: <ad3238a4d6769760f2bdbd19b4cde68cd3c79acf.1265991379.git.ext-phil.2.carmody@nokia.com>  <a6ac4fad65b6e1498010962a06429be40aef5e70.1265991379.git.ext-phil.2.carmody@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59128 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782Ab0BRXxm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 18:53:42 -0500
In-Reply-To: <a6ac4fad65b6e1498010962a06429be40aef5e70.1265991379.git.ext-phil.2.carmody@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Phil Carmody <ext-phil.2.carmody@nokia.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 2/12/2010 10:26 AM, Phil Carmody wrote:
> From: Phil Carmody<ext-phil.2.carmody@nokia.com>
>
> We free in the tail cleanup, so don't free before jumping there.
>
> Signed-off-by: Phil Carmody<ext-phil.2.carmody@nokia.com>
> ---
>   drivers/dsp/bridge/rmgr/proc.c |    8 +++++---
>   1 files changed, 5 insertions(+), 3 deletions(-)
>

Removed NULL assignment as agreed.

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Pushed to dspbridge.

- omar
