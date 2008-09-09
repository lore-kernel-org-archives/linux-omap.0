From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: omapzoom tree broken?
Date: Tue, 9 Sep 2008 18:59:29 +0100
Message-ID: <20080909175929.GK8894@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57161 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbYIIR7g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 13:59:36 -0400
Received: from flint.arm.linux.org.uk ([2002:4e20:1eda:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1Kd7Uy-0005ld-4o
	for linux-omap@vger.kernel.org; Tue, 09 Sep 2008 18:59:32 +0100
Received: from linux by flint.arm.linux.org.uk with local (Exim 4.69)
	(envelope-from <linux@flint.arm.linux.org.uk>)
	id 1Kd7Uv-0002Um-Vo
	for linux-omap@vger.kernel.org; Tue, 09 Sep 2008 18:59:30 +0100
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

When trying to fetch the omapzoom tree, I get:

got a4ae90758b3c38012c875a62d0dd8a20a30e413b
walk a4ae90758b3c38012c875a62d0dd8a20a30e413b
Getting alternates list for http://git.omapzoom.org/repo/omapkernel
Getting pack list for http://git.omapzoom.org/repo/omapkernel
Getting index for pack 567cbb972dbfa42338e1269ca4a4a03ec2b1d35f
Resuming fetch of index for pack 567cbb972dbfa42338e1269ca4a4a03ec2b1d35f at byte 5890048
error: wrong index v1 file size in .git/objects/pack/pack-567cbb972dbfa42338e1269ca4a4a03ec2b1d35f.idx
Segmentation fault

Could we have it accessible via git the protocol please, rather than
http?
