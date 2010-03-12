From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [APPLIED] DSPBRIDGE: Camel case removal
Date: Fri, 12 Mar 2010 00:28:59 -0600
Message-ID: <4B99DF2B.1070001@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43482 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204Ab0CLG3G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Mar 2010 01:29:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Ameya.Palande@nokia.com" <Ameya.Palande@nokia.com>, "Menon, Nishanth" <nm@ti.com>

Hi All,

Camel case removal patch was pushed into dspbridge branch.

This patch removes camel case symbols picked up by script found at:

http://marc.info/?l=linux-omap&m=125353475429517&w=2

It also has Lindent changes on top of it.

The count of modifications is as follows:
166 files changed, 21359 insertions(+), 20952 deletions(-)

Note: as this is a huge patch which changes big part of bridge code, 
when running checkpatch on it, it will alert of issues which were 
already present in the code.

Regards,

Omar
