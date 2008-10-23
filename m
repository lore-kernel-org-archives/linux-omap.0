From: Rick Bronson <rick@efn.org>
Subject: Re: ALSA sound on beagleboard
Date: Thu, 23 Oct 2008 07:27:54 -0700
Message-ID: <E1Kt1AI-0001fv-LY@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:43642 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbYJWO14 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Oct 2008 10:27:56 -0400
Received: from amazonia.comcast.net (c-67-171-210-97.hsd1.or.comcast.net [67.171.210.97])
	by samwise.efn.org (Postfix) with ESMTP id 79B04170076
	for <linux-omap@vger.kernel.org>; Thu, 23 Oct 2008 07:27:55 -0700 (PDT)
Received: from rick by amazonia.comcast.net with local (Exim 4.69)
	(envelope-from <rick@efn.org>)
	id 1Kt1AI-0001fv-LY
	for linux-omap@vger.kernel.org; Thu, 23 Oct 2008 07:27:54 -0700
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

> I got a message from someone on the beagleboard mailinglist that
> asound.conf was the culprit, no idea what the exact fix was.

  I wonder if you could dig up this guy's contact info.  I tried lots
of different asound.conf's but none of them did anything.

  Here is what I get without a asound.conf:

> arecord -L                                                                    
default:CARD=omap3beagle                                                        
    omap3beagle,                                                                
    Default Audio Device                                                        
null                                                                            
    Discard all samples (playback) or generate zero samples (capture)           
> arecord -l                                                                    
**** List of CAPTURE Hardware Devices ****                                      
card 0: omap3beagle [omap3beagle], device 0: TWL4030 twl4030-I2S-0 []           
  Subdevices: 1/1                                                               
  Subdevice #0: subdevice #0     

  Seems like everything looks okay for the default device.

  Rick
