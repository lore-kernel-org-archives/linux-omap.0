From: Heikki Krogerus <heikki.krogerus@nokia.com>
Subject: [PATCH 0/1] power_supply: twl4030_charger modification
Date: Fri, 25 Feb 2011 13:56:35 +0200
Message-ID: <1298634996-25722-1-git-send-email-heikki.krogerus@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.153]:18515 "EHLO mgw-sa03.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932079Ab1BYMaJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 07:30:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, notasas@gmail.com, cbouatmailru@gmail.com

Hi guys,

Grazvydas, I don't have hardware to test this with. If this is OK to
you, could you test it?

Felipe, was the idea that you take this with the atomic notifier
support for otg patches? I guess this is how it needs to be done in
order to keep things bisectable, right? Or does this simply go to
Anton?


Heikki Krogerus (1):
  twl4030_charger: Make the driver atomic notifier safe

 drivers/power/twl4030_charger.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

