From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PULL] http://www.linuxtv.org/hg/~hverkuil/v4l-dvb
Date: Wed, 11 Mar 2009 08:35:19 +0100
Message-ID: <200903110835.19471.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:1261 "EHLO
	smtp-vbr7.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbZCKHfy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 03:35:54 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, linux-omap@vger.kernel.org

Hi Mauro,

Please pull from http://www.linuxtv.org/hg/~hverkuil/v4l-dvb for the 
following:

- radio: remove uaccess include
- omap24xxcam: don't set vfl_type.

This should fix the daily build (for probably 10 seconds :-) ).

Thanks,

        Hans

diffstat:
 radio/radio-aimslab.c    |    1 -
 radio/radio-aztech.c     |    1 -
 radio/radio-cadet.c      |    1 -
 radio/radio-gemtek-pci.c |    1 -
 radio/radio-gemtek.c     |    1 -
 radio/radio-maestro.c    |    1 -
 radio/radio-maxiradio.c  |    1 -
 radio/radio-rtrack2.c    |    1 -
 radio/radio-sf16fmi.c    |    1 -
 radio/radio-sf16fmr2.c   |    1 -
 radio/radio-terratec.c   |    1 -
 radio/radio-trust.c      |    1 -
 radio/radio-typhoon.c    |    1 -
 radio/radio-zoltrix.c    |    1 -
 video/omap24xxcam.c      |    1 -
 15 files changed, 15 deletions(-)

-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG
