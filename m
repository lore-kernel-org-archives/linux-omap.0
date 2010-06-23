From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 04/13] OMAP: hwmod: Fix the missing braces
Date: Thu, 24 Jun 2010 05:16:51 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB032366AD26@dbde02.ent.ti.com>
References: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
 <1277336563-24988-5-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54440 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204Ab0FWXq7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 19:46:59 -0400
In-Reply-To: <1277336563-24988-5-git-send-email-khilman@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>

Kevin Hilman wrote:
> Sent: Wednesday, June 23, 2010 6:43 PM
> To: linux-omap@vger.kernel.org
> Cc: paul@pwsan.com; Cousson, Benoit; Sergei Shtylyov
> Subject: [PATCH 04/13] OMAP: hwmod: Fix the missing braces
> 
> From: Benoit Cousson <b-cousson@ti.com>
> 
> As reported by Sergei, a couple of braces were missing after
> the WARM removal patch.

s/WARM/WARN?

> 
> [07/22] OMAP: hwmod: Replace WARN by pr_warning if clock lookup failed
> 
> https://patchwork.kernel.org/patch/100756/
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Sergei Shtylyov <sshtylyov@mvista.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
