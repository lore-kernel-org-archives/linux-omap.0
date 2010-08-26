From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 01/20] DSS HWMOD database generation for OMAP3
Date: Thu, 26 Aug 2010 16:30:42 -0700
Message-ID: <87eidluf31.fsf@deeprootsystems.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
	<1282579089-10487-2-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57676 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab0HZXar (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 19:30:47 -0400
Received: by yxg6 with SMTP id 6so876124yxg.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 16:30:45 -0700 (PDT)
In-Reply-To: <1282579089-10487-2-git-send-email-svadivu@ti.com> (Guruswamy
	Senthilvadivu's message of "Mon, 23 Aug 2010 21:27:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com

Guruswamy Senthilvadivu <svadivu@ti.com> writes:

> From: Senthilvadivu Guruswamy <svadivu@ti.com>
>
> OMAP3 HWMOD database for DSS is added and is applicable for 34xx and 36xx.
>
> Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>

minor nit Re: $SUBJECT.  Please title the hwmod data patches using
something like this:

      OMAP3: hwmod data: add DSS, DISPC, DSI, RFBI, VENC

Kevin
