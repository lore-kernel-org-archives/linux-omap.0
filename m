From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: RE: [PATCHv3] DSPBRIDGE: Include missing info in MMU Fault
 debugging trace
Date: Mon, 14 Jun 2010 17:28:30 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043E87321E@dlee03.ent.ti.com>
References: <1276208673-6251-1-git-send-email-ernesto@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55382 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882Ab0FNW2e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jun 2010 18:28:34 -0400
In-Reply-To: <1276208673-6251-1-git-send-email-ernesto@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramos Falcon, Ernesto" <ernesto@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>

>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Ramos
>Falcon, Ernesto
>
>Some execution info is missing at the beginning of the
>trace buffer printout. This fix is to include this information
>according to the buffer contents description and
>also couple of cosmetic changes to make the traces more
>readable.
>
>This fix also uses DYNEXTBASE address to filter symbols that
>match low addresses in the hash table and are not useful to
>print. Any address below DYNEXTBASE is not valid for the DSP.
>
>Signed-off-by: Ernesto Ramos <ernesto@ti.com>
>---
> drivers/dsp/bridge/core/io_sm.c |   72 +++++++++++++++++++++++++++++----------
> 1 files changed, 54 insertions(+), 18 deletions(-)
>

I pushed this patch to have the feature in, but we need to think on how to make this code easier to read.

Pushed to dspbridge.

- omar
