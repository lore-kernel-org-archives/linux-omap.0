From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] PRCM: 34XX: Fix wrong shift value used in dpll4_m4x2_ck
 enable bit
Date: Wed, 25 Jun 2008 00:27:38 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0806250027150.5159@utopia.booyaka.com>
References: <1214372282-1862-1-git-send-email-jouni.hogander@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46570 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbYFYG1j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jun 2008 02:27:39 -0400
In-Reply-To: <1214372282-1862-1-git-send-email-jouni.hogander@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jouni Hogander <jouni.hogander@nokia.com>
Cc: linux-omap@vger.kernel.org

On Wed, 25 Jun 2008, Jouni Hogander wrote:

> Enable bit for dpll4_m4x2_ck is OMAP3430_PWRDN_DSS1_SHIFT instead of
> OMAP3430_PWRDN_CAM_SHIFT.
> 
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
