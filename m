From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] PM: Added sleep support to UART
Date: Tue, 16 Sep 2008 17:51:22 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE3943081BA76@vaebe110.NOE.Nokia.com>
References: <> <1221582834-21394-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:50690 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbYIPOwH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 10:52:07 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8GEpZLQ014926
	for <linux-omap@vger.kernel.org>; Tue, 16 Sep 2008 17:52:04 +0300
Content-class: urn:content-classes:message
In-Reply-To: <1221582834-21394-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero.Kristo@nokia.com, linux-omap@vger.kernel.org

Just a quick comment to this patch, there might be issues (again) with
OMAP2 as the patch has lived again a bit. So, someone should preferably
test this on OMAP2 before integrating.

This is now a standalone version of the patch and does not require GPIO
patch below to work.
