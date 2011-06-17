From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 0/3] PRCM chain interrupt handler
Date: Fri, 17 Jun 2011 10:44:02 +0300
Message-ID: <1308296642.1851.18.camel@sokoban>
References: <1307625904-18629-1-git-send-email-t-kristo@ti.com> <87aadhk3ko.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37336 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757489Ab1FQHoG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 03:44:06 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5H7i5GO024385
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 02:44:05 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep35.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5H7i5QI017953
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 02:44:05 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <87aadhk3ko.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 2011-06-16 at 20:56 +0200, Hilman, Kevin wrote:
> Hi Tero,
> 
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Following set contains PRCM chain interrupt handling for OMAP3/4. 
> 
> What does this series apply to?  It doesn't seem to apply to mainline
> (v3.0-rc3) or l-o master.

You are right, it does not apply cleanly. OMAP4 part requires support
from OMAP4 PM which is not integrated yet (e.g. PRCM interrupt
handling.) I will repost the series in such format that applies on top
of PM branch and drop OMAP4 support out of it for now.

-Tero



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

