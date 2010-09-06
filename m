From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: make filter coefficient tables human
 readable
Date: Mon, 06 Sep 2010 14:42:26 +0300
Message-ID: <1283773346.2363.25.camel@tubuntu.research.nokia.com>
References: <1282655923-32094-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:28708 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641Ab0IFLm3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 07:42:29 -0400
In-Reply-To: <1282655923-32094-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Tue, 2010-08-24 at 15:18 +0200, ext Grazvydas Ignotas wrote:
> Reorganize scaler FIR filter data as FIR value tables from raw
> register values. This makes them easier to understand and simplifies
> register programming code.
> 
> No functional changes.
> 

I think this looks fine. Applied, thanks.

 Tomi


