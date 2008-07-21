From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: [PATCH 0/2] Add clock post-rate-change notifier
Date: Mon, 21 Jul 2008 16:19:35 +0530
Message-ID: <000001c8eb1f$787c8880$68bf18ac@ent.ti.com>
References: <20080620231155.21640.89851.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41151 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756300AbYGUKuX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2008 06:50:23 -0400
In-Reply-To: <20080620231155.21640.89851.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Paul Walmsley' <paul@pwsan.com>, linux-omap@vger.kernel.org

Hi Paul,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Saturday, June 21, 2008 4:44 AM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH 0/2] Add clock post-rate-change notifier
> 
> 
> This series adds a clock rate change notifier to the OMAP clock
> framework.  Currently only post-rate-change notification is
> implemented, although pre-rate-change notification is in the works.

Was there any patch set posted after this with pre-rate change notifications
support?

I am currently working on CPUFreq patches and CPUFreq requires a pre notification 
to be able to update jiffies/BogoMips.

regards,
Rajendra

