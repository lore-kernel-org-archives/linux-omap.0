From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv7 07/12] ARM: OMAP4: PM: put all domains to OSWR during
 suspend
Date: Thu, 19 Jul 2012 08:44:42 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207190842310.432@utopia.booyaka.com>
References: <1342704392-23657-1-git-send-email-t-kristo@ti.com> <1342704392-23657-8-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57291 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547Ab2GSOon (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Jul 2012 10:44:43 -0400
In-Reply-To: <1342704392-23657-8-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, 19 Jul 2012, Tero Kristo wrote:

> Signed-off-by: Tero Kristo <t-kristo@ti.com>

This one needs at least some short description for the changelog.  Maybe 
just a brief explanation that OSWR saves more energy that CSWR, but has 
higher resume latency, and since resume from system suspend is considered 
to be a high-latency operation, OSWR is appropriate here.


- Paul
