From: Patrick Radius <info@notoyota.nl>
Subject: OMAP 3430 Camera/ISP out of memory error
Date: Fri, 25 Mar 2011 11:52:57 +0100
Message-ID: <1301050377.25083.2.camel@kaas>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58898 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934195Ab1CYKx1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 06:53:27 -0400
Received: by wya21 with SMTP id 21so988574wya.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 03:53:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

i'm trying to get camera support working on a relatively new Android
port to an OMAP 3430 based phone (Samsung GT-i8320 a.k.a. Samsung H1).
However calls to VIDIOC_REQBUFS fail with a -12 (OUT OF MEMORY).
As far as I can see this return error isn't even supposed to exist,
according to the V4L2 spec.
I'm using the code from Android on the Zoom2.
The sensor is a Fujitsu M-4MO.

Any ideas on what could be wrong with the out of memory result?
Thanks!

