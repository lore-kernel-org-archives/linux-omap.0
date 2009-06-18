From: "Can Bal" <canbal@ee.bilkent.edu.tr>
Subject: How to take advantage of DSP
Date: Thu, 18 Jun 2009 13:42:21 +0300 (EEST)
Message-ID: <54206.139.179.106.36.1245321741.squirrel@newmail.bilkent.edu.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ispinoz.bcc.bilkent.edu.tr ([139.179.10.240]:47320 "EHLO
	ispinoz.bcc.bilkent.edu.tr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750964AbZFRKmO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Jun 2009 06:42:14 -0400
Received: from newmail.bilkent.edu.tr (unknown [192.168.10.203])
	by ispinoz.bcc.bilkent.edu.tr (Postfix) with ESMTP id 5CCC8759F
	for <linux-omap@vger.kernel.org>; Thu, 18 Jun 2009 13:42:24 +0300 (EEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi, I try to adapt C++ project on OMAP and want to take advantage of the
DSP. The project is a big one (multiview video codec), and I thought of
discriminating the functions that are most often called and do their
processing on DSP (filtering type of operations, with for loops).

When I tried to do this on a single function, unexpectedly the total run
time of the code increased considerably. I was using streaming to
communicate with the DSP and thought this might be the reason. So, I will
try the same with Direct Memory Mapping but I'm not very optimistic that
this will increase my runtime either.

So my question is, what would be the best approach to follow for using the
DSP to make my code more efficient? In what cases DSP is advantageous over
ARM?

Thanks a lot.

Best regards,
Can

