From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 0/1] change prcm chain handler to support pad to irq mapping
Date: Fri, 28 Oct 2011 15:03:44 +0300
Message-ID: <1319803425-13154-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46176 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576Ab1J1MEL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Oct 2011 08:04:11 -0400
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

Hi,

The following patch supports pad to irq mapping for the PRCM IO wakeups.
This patch applies on top of the PRCM chain handler set (v9) from me. Any
comments welcome, I will most likely add this to the next version of the
PRCM chain set, but will send this as an RFC for now.

-Tero


Texas Instruments Oy, Porkkalankatu 22, 00180 Helsinki, Finland. Business ID: 0115040-6. Domicile: Helsinki
 

