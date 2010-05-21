From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: DSS2: storage class should be before const
 qualifier
Date: Fri, 21 May 2010 11:37:32 +0300
Message-ID: <1274431052.4246.88.camel@tubuntu.research.nokia.com>
References: <1274368372-4043-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:28124 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab0EUIhu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 04:37:50 -0400
In-Reply-To: <1274368372-4043-1-git-send-email-tklauser@distanz.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tobias Klauser <tklauser@distanz.ch>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>

Hi,

On Thu, 2010-05-20 at 17:12 +0200, ext Tobias Klauser wrote:
> The C99 specification states in section 6.11.5:
> 
> The placement of a storage-class specifier other than at the beginning
> of the declaration specifiers in a declaration is an obsolescent
> feature.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Thanks! Applied to omap-dss tree.

 Tomi


