From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 0/2] voltage / oscillator parameter segregation
Date: Wed, 3 Aug 2011 18:29:13 +0300
Message-ID: <1312385355-17029-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58467 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650Ab1HCP3s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Aug 2011 11:29:48 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p73FTmF9018179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 3 Aug 2011 10:29:48 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep33.itg.ti.com (8.13.7/8.13.8) with ESMTP id p73FTmKu025068
	for <linux-omap@vger.kernel.org>; Wed, 3 Aug 2011 10:29:48 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p73FTlsR017137
	for <linux-omap@vger.kernel.org>; Wed, 3 Aug 2011 10:29:47 -0500 (CDT)
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Following patch attemps to separate some board specific parameters from
the core PM code. These parameters can then be specified in the board
files. Some things missing from this work currently are hooks from the
sleep code to select proper setup times based on the sleep mode... and
well, the patch should most likely be split up in multiple parts.

Beagle boart setup changes provided for reference, values on it are basically
pulled from a sleeve.

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

