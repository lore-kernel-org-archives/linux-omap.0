From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH 3/5 v2] OMAP3: serial: Fix uart4 handling for  3630
Date: Thu, 17 Jun 2010 14:45:55 -0700
Message-ID: <87typ1jpt8.fsf@deeprootsystems.com>
References: <2232.10.24.255.18.1276697648.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36514 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757679Ab0FQVqF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 17:46:05 -0400
Received: by iwn9 with SMTP id 9so329070iwn.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Jun 2010 14:46:03 -0700 (PDT)
In-Reply-To: <2232.10.24.255.18.1276697648.squirrel@dbdmail.itg.ti.com> (Govindraj R.'s message of "Wed\, 16 Jun 2010 19\:44\:08 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

"Govindraj.R" <govindraj.raja@ti.com> writes:

> This patch makes the following:
>  - Adds missing wakeup padding register handling.
>  - Fixes a hardcode to use PER module ONLY on UART3.
>  - Muxmode usage needed for uart4 for 3630, for padconf
>    wakeup on uart4_rx line. uart4_rx signal is available
>    under mode-2 in gpmc_wait3. Thus have to ensure we are
>    in right mux mode before accesing any padconf register.
>    So ensure right mux mode for uarti padconf access.

I think this mux-mode handling should be done as a separate patch with
more description as exactly what problem this is solving.

Presumably, whatever problem you're solving not unique to 3630 UART4
as the UARTs on the other platforms can be muxed with other
peripherals as well.

Based on the way it's being mux'd (and continually re-mux'd) in this
patch, it looks like the mux settings for that pin are being
dynamically changed elsewhere in the code.  If that's the case, then
that should be better understood, and this code should likely re-mux
to the original settings when its done.

Kevin
