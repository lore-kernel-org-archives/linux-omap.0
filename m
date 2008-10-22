From: Rick Bronson <rick@efn.org>
Subject: ALSA sound on beagleboard
Date: Tue, 21 Oct 2008 21:57:31 -0700
Message-ID: <E1KsVml-0007JI-Eq@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:59845 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbYJVE5b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2008 00:57:31 -0400
Received: from amazonia.comcast.net (c-67-171-210-97.hsd1.or.comcast.net [67.171.210.97])
	by samwise.efn.org (Postfix) with ESMTP id 68D6417000C
	for <linux-omap@vger.kernel.org>; Tue, 21 Oct 2008 21:57:31 -0700 (PDT)
Received: from rick by amazonia.comcast.net with local (Exim 4.69)
	(envelope-from <rick@efn.org>)
	id 1KsVml-0007JI-Eq
	for linux-omap@vger.kernel.org; Tue, 21 Oct 2008 21:57:31 -0700
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

  I'd like to get arecord working on the beagleboard.  I've enabled:

CONFIG_SND_OMAP_SOC=y
CONFIG_SND_OMAP_SOC_MCBSP=y
CONFIG_SND_SOC_TWL4030=y

  But I get this upon boot:

Advanced Linux Sound Architecture Driver Version 1.0.17.                        
ASoC version 0.13.2                                                             
ALSA device list:                                                               
  No soundcards found.                                                          

  Please give me a clue on where to start.

  Thanks much.

  Rick Bronson
