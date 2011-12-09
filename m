From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv4 05/15] omap: add support for oscillator setup
Date: Fri, 09 Dec 2011 10:27:05 -0800
Message-ID: <87obvhfvnq.fsf@ti.com>
References: <1322236188-19456-1-git-send-email-t-kristo@ti.com>
	<1322236188-19456-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:41908 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751709Ab1LIS1J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 13:27:09 -0500
Received: by mail-gy0-f179.google.com with SMTP id g15so2632088ghb.10
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 10:27:08 -0800 (PST)
In-Reply-To: <1322236188-19456-6-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Fri, 25 Nov 2011 17:49:38 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com

Tero Kristo <t-kristo@ti.com> writes:

> This contains startup and shutdown times for the oscillator. By default
> use MAX_INT. 

nit: code uses ULONG_MAX

> Oscillator setup is used for calculating and setting up
> latencies for sleep modes that disable oscillator.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Otherwise, looks fine.

Kevin
