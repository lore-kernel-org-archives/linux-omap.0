From: Rick Bronson <rick@efn.org>
Subject: Re: [FYI] TI dspbridge rebase against latest l-o
Date: Fri, 07 Nov 2008 22:38:49 -0800
Message-ID: <E1KyhT7-0002fS-6K@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:58930 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754AbYKHGiu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 8 Nov 2008 01:38:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Hiroshi,

  Thanks very much for the help.

  Here is the output from

sudo modprobe bridgedriver base_img=ddspbase_tiomap3430.dof64P GT_str="**=01234567" 

http://www.efn.org/~rick/pub/dsp.txt

  The first failure seems to be:

RG - 0: G CurrentConfig FAILED                                                  
CF - 0: CFG_GetHostResources Failed                                             

  Any ideas what's wrong?

  Thanks much.

  Rick
