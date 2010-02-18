From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH 1/2] dspbridge: proc: it's a pointer, not a handle
Date: Thu, 18 Feb 2010 17:53:36 -0600
Message-ID: <4B7DD300.2040700@ti.com>
References: <1265992014-7917-1-git-send-email-ext-phil.2.carmody@nokia.com>  <ad3238a4d6769760f2bdbd19b4cde68cd3c79acf.1265991379.git.ext-phil.2.carmody@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51969 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782Ab0BRXxk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 18:53:40 -0500
In-Reply-To: <ad3238a4d6769760f2bdbd19b4cde68cd3c79acf.1265991379.git.ext-phil.2.carmody@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Phil Carmody <ext-phil.2.carmody@Nokia.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 2/12/2010 10:26 AM, Phil Carmody wrote:
> From: Phil Carmody<ext-phil.2.carmody@nokia.com>
>
> If there's one thing worse than systems hungarian notation,
> it's misleading systems hungarian notation. And you don't
> need 2 copies of the pointer.
>
> Signed-off-by: Phil Carmody<ext-phil.2.carmody@nokia.com>
> ---
>   drivers/dsp/bridge/rmgr/proc.c |   25 +++++++++++--------------
>   1 files changed, 11 insertions(+), 14 deletions(-)
>

Acked-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Pushed to dspbridge.

- omar
