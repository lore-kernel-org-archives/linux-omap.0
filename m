From: Brian Murphy <brian.murphy@cobham.com>
Subject: The state of AM33xx power management.
Date: Thu, 28 Nov 2013 14:04:37 +0100
Message-ID: <52973F65.8060005@cobham.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod7og129.obsmtp.com ([64.18.2.122]:40123 "EHLO
	exprod7og129.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936Ab3K1NKJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Nov 2013 08:10:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi Folks,

even though I have seen some references to power management on AM33xx
class devices recently on this list it seems to me that just about the 
only omap
device without suspend/resume support in Torvalds kernel source is AM33xx.
Correct me if I am wrong.

I have looked at integrating this code:

https://github.com/dgerlach/linux-pm.git

and have had it running (after a fashion) on a slightly older kernel but 
the patches
fail to apply to the newest kernels.

Is there a secret (or not so secret, but unknown to me) place which 
contains the equivalent
of the patches above but rebased and cleaned up relative to a newer kernel?

I am willing to to whatever work is necessary to get this done and upstream
but I don't want to work in a different direction to others working on 
the same problem.

How best should I proceed?

regards
Brian
