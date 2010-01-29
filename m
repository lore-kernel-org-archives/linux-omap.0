From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH v2 0/5] DSPBRIDGE: centralized services initialization
Date: Thu, 28 Jan 2010 18:32:39 -0600
Message-ID: <4B622CA7.5000605@ti.com>
References: <1264553848-23555-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46222 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424Ab0A2Aco (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 19:32:44 -0500
In-Reply-To: <1264553848-23555-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

On 1/26/2010 6:57 PM, Ramirez Luna, Omar wrote:
> It is more logic to initialize services related modules inside
> services layer, even if we are planning to remove it.
>
> v2:
> - Fixed crefs build issue (patch 2) if enabling debug
>
> Omar Ramirez Luna (5):
>    DSPBRIDGE: Avoid multiple calls to SERVICES_[Init|Exit]
>    DSPBRIDGE: remove crefs for SERVICES[Init|Exit]
>    DSPBRIDGE: Remove multiple initializations of MEM module
>    DSPBRIDGE: Remove multiple initializations of REG module
>    DSPBRIDGE: Remove multiple initializations of NTFY module
>
>   drivers/dsp/bridge/gen/gs.c            |    8 +--
>   drivers/dsp/bridge/pmgr/dbll.c         |   15 +----
>   drivers/dsp/bridge/pmgr/wcd.c          |   17 +-----
>   drivers/dsp/bridge/rmgr/dbdcd.c        |   15 +-----
>   drivers/dsp/bridge/rmgr/rmm.c          |   17 +-----
>   drivers/dsp/bridge/services/mem.c      |   36 ++----------
>   drivers/dsp/bridge/services/services.c |  100 ++++++++++++--------------------
>   7 files changed, 53 insertions(+), 155 deletions(-)
>

Pushed to dspbridge.

- omar
