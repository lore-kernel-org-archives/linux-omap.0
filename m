From: Rick Bronson <rick@efn.org>
Subject: Re: ALSA sound on beagleboard
Date: Wed, 22 Oct 2008 10:37:39 -0700
Message-ID: <E1KsheN-0002oF-7M@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:44206 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757883AbYJVRiD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2008 13:38:03 -0400
Received: from amazonia.comcast.net (c-67-171-210-97.hsd1.or.comcast.net [67.171.210.97])
	by samwise.efn.org (Postfix) with ESMTP id 6793C1700B7
	for <linux-omap@vger.kernel.org>; Wed, 22 Oct 2008 10:38:02 -0700 (PDT)
Received: from rick by amazonia.comcast.net with local (Exim 4.69)
	(envelope-from <rick@efn.org>)
	id 1KsheN-0002oF-7M
	for linux-omap@vger.kernel.org; Wed, 22 Oct 2008 10:37:39 -0700
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Dave,

  Thanks for the info.  This patch did get sound output working.  But
input doesn't seem to work.  I checked that I really have audio at the
audio-in connector and that the mixer is set right:

> amixer                                                                        
Simple mixer control 'Master',0                                                 
  Capabilities: pvolume                                                         
  Playback channels: Front Left - Front Right                                   
  Limits: Playback 0 - 127                                                      
  Mono:                                                                         
  Front Left: Playback 75 [59%]                                                 
  Front Right: Playback 75 [59%]                                                
Simple mixer control 'Capture',0                                                
  Capabilities: cvolume                                                         
  Capture channels: Front Left - Front Right                                    
  Limits: Capture 0 - 127                                                       
  Front Left: Capture 84 [66%]                                                  
  Front Right: Capture 84 [66%]  

  Anyone else got it working?

  Thanks for any help.

  Rick
