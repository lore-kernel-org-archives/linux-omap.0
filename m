From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/3] OMAP: McBSP: Swap CLKS source definition
Date: Wed, 6 Oct 2010 08:44:11 +0300
Message-ID: <201010060844.12046.peter.ujfalusi@nokia.com>
References: <1286281775-27692-1-git-send-email-jhnikula@gmail.com> <1286281775-27692-2-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:26172 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755234Ab0JFFoO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 01:44:14 -0400
In-Reply-To: <1286281775-27692-2-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Tuesday 05 October 2010 15:29:34 ext Jarkko Nikula wrote:
> This is just a readability and debugging improvement. As selection bit in
> DEVCONF register is cleared when using 96 MHz PRCM source and set when
> using external CLKS pin, change definitions to be sync with these.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
