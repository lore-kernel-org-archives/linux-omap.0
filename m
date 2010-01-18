From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH v9 0/4] OMAP: McBSP: Use register cache
Date: Mon, 18 Jan 2010 10:07:36 +0200
Message-ID: <201001181007.36436.peter.ujfalusi@nokia.com>
References: <201001141658.32034.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54505 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab0ARIIn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 03:08:43 -0500
In-Reply-To: <201001141658.32034.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

On Thursday 14 January 2010 17:58:29 ext Janusz Krzysztofik wrote:
> Change the way McBSP registers are maintained: store values written to the
> device in a cache in order to make use of those cached values when
> convenient.
> 
> This could help for developing the McBSP context save/restore features, as
> well as solve the problem of possible register corruption, experienced on
> OMAP1510 based Amstrad Delta board at least.
> 

Please make a followup patch for the unneeded masking of status bits as we 
discussed regarding to patch 4.

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
