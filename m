From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC PATCH 00/20] HWMOD Adaptation for DSS
Date: Thu, 26 Aug 2010 16:57:41 -0700
Message-ID: <87occprkp6.fsf@deeprootsystems.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55181 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753906Ab0HZX5o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Aug 2010 19:57:44 -0400
Received: by pwi7 with SMTP id 7so922640pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 26 Aug 2010 16:57:44 -0700 (PDT)
In-Reply-To: <1282579089-10487-1-git-send-email-svadivu@ti.com> (Guruswamy
	Senthilvadivu's message of "Mon, 23 Aug 2010 21:27:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guruswamy Senthilvadivu <svadivu@ti.com>
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com

Guruswamy Senthilvadivu <svadivu@ti.com> writes:

> RFC focus on the proposed design of the HWMOD adaptation to the current DSS
> driver.  DSS, DISPC, DSI, RFBI, VENC are made as platform drivers each 
> corresponding to the HWMOD class in the HWMOD database.

Hi Senthi,

Nice job on this series.  I have a handful of small comments on the
individual patches, but I also wanted to say thanks for doing an
excellent job of breaking this up into small, self-contained patches.
It makes it so much easier to review small patches with well-written
changelogs.

Thanks!

Kevin
