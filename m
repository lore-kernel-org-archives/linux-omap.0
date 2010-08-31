From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/2] omap2: McBSP: Remove mux code for OMAP2420 McBSP2 and do cleanups
Date: Tue, 31 Aug 2010 13:53:46 +0300
Message-ID: <201008311353.46607.peter.ujfalusi@nokia.com>
References: <1281098342-5161-1-git-send-email-jhnikula@gmail.com> <1283249576-24652-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:37184 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757138Ab0HaKxv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Aug 2010 06:53:51 -0400
In-Reply-To: <1283249576-24652-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Tuesday 31 August 2010 13:12:56 ext Jarkko Nikula wrote:
> This 'legacy' OMAP2420 McBSP2 muxing code is currently broken after recent
> conversion to new mux code. The omap_mcbsp_request calling this code is
> usually called after booting whereas the omap_mux_init_signal is __init
> marked so null pointer dereference would occur.
> 
> Fix this by removing the muxing code and let the bootloader or board file
> to do it if necessary. Remove also omap2_mcbsp_ops as there is no use for
> it.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Sounds reasonable.

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
