From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 00/29] Move OMAP2+ over to use COMMON clock
Date: Sun, 17 Jun 2012 22:27:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1206172225450.10859@utopia.booyaka.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39555 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab2FRE1f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 00:27:35 -0400
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 14 Jun 2012, Rajendra Nayak wrote:

> OMAP3 has suspend broken in mainline, so I tested it on an
> older kernel (3.4-rc4 using my RFC series)
> Idle and OFF mode however seem to be broken for a long time,
> I wasn;t able to get it working even on 3.4 major.
> See my logs '3630 Beagle-Xm broken idle/off on 3.4' if
> I am doing anything wrong. I have CPUidle enabled in the
> kernel config.

http://www.spinics.net/lists/arm-kernel/msg173688.html


- Paul
