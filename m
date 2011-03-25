From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] OMAP: iovmm: fix SW flags passed by user
Date: Fri, 25 Mar 2011 20:30:14 +0300
Message-ID: <4D8CD126.6000405@ru.mvista.com>
References: <1301071572-25251-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59028 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065Ab1CYRbx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 13:31:53 -0400
Received: by eyx24 with SMTP id 24so559871eyx.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 10:31:52 -0700 (PDT)
In-Reply-To: <1301071572-25251-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Tony Lindgren <tony@atomide.com>, l-o <linux-omap@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, David Cohen <dacohen@gmail.com>, lak <linux-arm-kernel@lists.infradead.org>

Hello.

Omar Ramirez Luna wrote:

> Commit d038aee24dcd changes iovmm to receive flags specified by user,

    Please also specify that commit's summary for the human readers. Bare ID is 
only usable to gitweb...

> however the upper 16 bits of the flags are wiped by iovmm itself.

> This fixes IOVMF_DA_FIXED flags from being lost, and lets the user
> map its desired "device addresses".

> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

WBR, Sergei

