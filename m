From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCHv2] OMAP: McBSP: Do not enable or disable clocks on
 failed path
Date: Thu, 19 Mar 2009 14:45:45 +0200
Message-ID: <20090319144545.fb9d20e3.jarkko.nikula@nokia.com>
References: <1237376485324-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:30664 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbZCSMp3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2009 08:45:29 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2JCjEI1018967
	for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2009 14:45:25 +0200
In-Reply-To: <1237376485324-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 18 Mar 2009 12:41:25 +0100
"Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
wrote:

> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> McBSP clocks are being double enabled in the event the
> McBSP is already active. Also, they are unnecessarily
> disabled when there's no active McBSP in use. Fix this
> phenomenom by enabling and disabling the clocks at the
> proper location.
> 
> Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> ---
>  arch/arm/plat-omap/mcbsp.c |   14 ++++++++------
>  1 files changed, 8 insertions(+), 6 deletions(-)
> 
Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
