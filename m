From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [RFC][PATCH 3/8] OMAP: DSS2: Modify dss_recheck_connections
Date: Thu, 01 Jul 2010 14:31:57 +0300
Message-ID: <1277983917.2474.319.camel@tubuntu.research.nokia.com>
References: <1277980285-20996-1-git-send-email-archit@ti.com>
	 <1277980285-20996-2-git-send-email-archit@ti.com>
	 <1277980285-20996-3-git-send-email-archit@ti.com>
	 <1277980285-20996-4-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25420 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244Ab0GALcH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 07:32:07 -0400
In-Reply-To: <1277980285-20996-4-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sumit Semwal <sumit.semwal@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Mukund Mittal <mmittal@ti.com>, Samreen <samreen@ti.com>

On Thu, 2010-07-01 at 12:31 +0200, ext Archit Taneja wrote:
> From: Sumit Semwal <sumit.semwal@ti.com>
> 
> The addition of the new 2lcd manager requires modifications in the
> dss_recheck_connections patch, this function behaves the same if
> the 2lcd manager doesn't exist

Here (and also in the previous patch) you talk about 2lcd, but the code
uses lcd2.

 Tomi


