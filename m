From: Ishaq Khan <ishaq.groups@gmail.com>
Subject: MMC: driver fails to recognize insert-remove SD card after data
	transfer error 84
Date: Wed, 18 Mar 2009 14:10:47 -0500
Message-ID: <cfe5f7850903181210y1d27d6e8w20aa3f6e01e15abf@mail.gmail.com>
References: <cfe5f7850903180828k60f844c0l475e328649607e3c@mail.gmail.com>
	 <cfe5f7850903181007l3aaf402fm6683a1658b23efce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:64446 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759209AbZCRTKt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 15:10:49 -0400
Received: by yw-out-2324.google.com with SMTP id 5so193677ywb.1
        for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2009 12:10:47 -0700 (PDT)
In-Reply-To: <cfe5f7850903181007l3aaf402fm6683a1658b23efce@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I have been trying to fix a problem in the MMC driver on OMAP2430.
After rapid insert and remove SD card operation, I see the following
error message (caused due to data timeout). After this happens the
driver no longer detects insertions/removals..

[ 1013.320000] mmcblk2: error -84 transferring data, sector 7961, nr
8, card status 0x900

followed by bunch of I/O errors

[ 1013.330000] end_request: I/O error, dev mmcblk2, sector 7961
[ 1013.330000] end_request: I/O error, dev mmcblk2, sector 7962
[ 1013.330000] end_request: I/O error, dev mmcblk2, sector 7963
[ 1013.330000] end_request: I/O error, dev mmcblk2, sector 7964
[ 1013.330000] end_request: I/O error, dev mmcblk2, sector 7965
[ 1013.330000] end_request: I/O error, dev mmcblk2, sector 7966
[ 1013.330000] end_request: I/O error, dev mmcblk2, sector 7967
[ 1013.330000] end_request: I/O error, dev mmcblk2, sector 7968

I have tried a number of patches that floating around but do no good
to fix this problem. Would appreciate if someone could share their
views regarding this problem.

Thanks

Ishaq
