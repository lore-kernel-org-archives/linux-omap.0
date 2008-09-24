From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH 0/9] HDQ driver fixes
Date: Wed, 24 Sep 2008 16:49:08 +0530 (IST)
Message-ID: <42568.192.168.10.89.1222255148.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33585 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbYIXLTo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Sep 2008 07:19:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: johnpol@2ka.mipt.ru, felipe.balbi@nokia.com, linux-omap@vger.kernel.org

Hi Tony,

I am posting a series of nine patches for the HDQ driver. The patch series
provides cleanup of the driver pointed out by Filipe's diff file, use ioremap
for HDQ base, replace usage of semaphore with mutex, fixes some commenting
style and indentation.

Regards,
Madhu

