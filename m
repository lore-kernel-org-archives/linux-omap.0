From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] OMAP: UART: don't resume UARTs that are not enabled.
Date: Wed, 24 Nov 2010 22:48:40 +0200
Message-ID: <1290631720.15533.30.camel@eowin>
References: <1290625743-8370-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:44557 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587Ab0KXUsq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 15:48:46 -0500
In-Reply-To: <1290625743-8370-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Govindraj R." <govindraj.raja@ti.com>

Hi,

On Wed, 2010-11-24 at 11:09 -0800, Kevin Hilman wrote:
> Add additional check to omap_uart_resume_idle() so that only
> enabled (specfically, idle-enabled) UARTs are allowed to resume.

typo: specifically

-- 
balbi

