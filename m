From: Selso LIBERADO <sli@cioinfoindus.fr>
Subject: Re: tidspbridge build fails
Date: Tue, 25 Sep 2012 17:39:21 +0000 (UTC)
Message-ID: <loom.20120925T193504-862@post.gmane.org>
References: <CAOSRfZ7FsVw+MOUfGZZFiCrg2Ec1iSgypdY=Lijzn_x8NpkhLw@mail.gmail.com> <loom.20120924T183345-467@post.gmane.org> <CAJ6Av5M4BWy709qLLz5HOjXL87GjTqyF6qQku-DSW1B2hNJxJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:46581 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757526Ab2IYRjk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 13:39:40 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1TGZ6h-0003yN-1C
	for linux-omap@vger.kernel.org; Tue, 25 Sep 2012 19:39:39 +0200
Received: from 195.6.193.205 ([195.6.193.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 25 Sep 2012 19:39:39 +0200
Received: from sli by 195.6.193.205 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Tue, 25 Sep 2012 19:39:39 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi !

Here what's happening when applying the patch : 

sli@SLI-V420:~/developpement/INTERNE/BEAGLEBOARD/logiciel/linux-omap$ git apply
--check ../../archive/10-17-staging-tidspbridge-Prepare-for-irqs.h-removal.patch
error: patch failed: drivers/staging/tidspbridge/core/wdt.c:25
error: drivers/staging/tidspbridge/core/wdt.c: patch does not apply

newbie question : Where is the staging-next rep ?

