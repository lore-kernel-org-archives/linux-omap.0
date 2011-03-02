From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: VDD2 OPP and DSS
Date: Wed, 2 Mar 2011 08:40:12 +0200
Message-ID: <1299048012.2226.10.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41037 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751853Ab1CBGkW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Mar 2011 01:40:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tero Kristo <tero.kristo@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul and Tero,

Some months ago there were discussions in Nokia about the problem with
VDD2 OPP and DSS fck. The problem was (if I recall right) that the
lowest VDD2 OPP cannot be used if DSS fck is over some certain limit (it
was around 100MHz). If I understood correctly, this was also discussed
with Paul.

Do you remember this (and did I remember it right =)? What is the status
of this?

 Tomi


