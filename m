From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 0/4] TWL external controller support
Date: Fri, 8 Jul 2011 18:56:24 +0300
Message-ID: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35147 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751901Ab1GHP5G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 11:57:06 -0400
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lrg@ti.com, broonie@opensource.wolfsonmicro.com

Hello,

Following patches add an external controller support for TWL SMPS regulators.
This is needed because OMAP has voltage processor support which provides
interface to control a few regulators (VDD1 / VDD2 for OMAP3), and this
is shared with smartreflex.

These patches work in a way that twl regulators now provide an external
controller registration interface, and this is used by the OMAP voltage
layer during init. set_voltage / get_voltage APIs now check for presence
of external controller, and if it is there, calls are routed to external
controller.

Baseline work for these patches was done by Thomas Petezzoni.

Any comments welcome, does something like this look like it could be pushed
to regulator framework?

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

