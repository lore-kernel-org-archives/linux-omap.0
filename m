From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH v5 01/10] OMAP4 : DSS2 : Add display type HDMI to DSS2
Date: Thu, 10 Mar 2011 18:53:43 +0200 (EET)
Message-ID: <alpine.DEB.1.10.1103101844270.23039@esdhcp041196.research.nokia.com>
References: <1299753858-12222-1-git-send-email-mythripk@ti.com>  <1299753858-12222-2-git-send-email-mythripk@ti.com> <1299764919.2017.181.camel@deskari>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:31765 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753531Ab1CJQzw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 11:55:52 -0500
In-Reply-To: <1299764919.2017.181.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: "K, Mythri P" <mythripk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Thu, 10 Mar 2011, Tomi Valkeinen wrote:
> Generally, split the lines at column, say, 78.

I think it should be 75 at most, which is also default for "fmt".

"git log" idents the comment by 4 spaces, and it would be nice to have
logs readable with an 80-column screen.

A.
