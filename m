From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH PM] OMAP3 McSPI:  Adds context save/restore
Date: Fri, 06 Feb 2009 14:15:30 +0200
Message-ID: <498C29E2.5020303@nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02F54B9C80@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:63485 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbZBFMRP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Feb 2009 07:17:15 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02F54B9C80@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Hogander Jouni (Nokia-D/Tampere)" <jouni.hogander@nokia.com>, "V, Hemanth" <hemanthv@ti.com>

Hello,

ext Nayak, Rajendra wrote:
> From: Hemanth V <hemanthv@ti.com>
> 
> This patch adds context save/restore feature to McSPI driver.
> This includes fixes by Aaro Koskinen
> 
> Signed-off-by: Hemanth V <hemanthv@ti.com>

For some reason git-am does not take this to my tree, but when applied 
with patch it's OK. So the patch may need to be refreshed, but for the 
code itself:

Reviewed-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>

A.
