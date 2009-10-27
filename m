From: Philip Balister <philip@balister.org>
Subject: GPMC setup help
Date: Tue, 27 Oct 2009 16:41:41 -0400
Message-ID: <4AE75B05.7010701@balister.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.geekisp.com ([216.168.135.169]:40333 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932101AbZJ0Ulk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Oct 2009 16:41:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

I've been going round and round on this for a couple of days. I have a 
logic analyzer (cheap USB, that is why come edges are not quite synced) 
attached to the gpmc pins on a logicpd dev board. The read cycle timings 
are what I expect.

The write cycle seems to do one cycle OK, then thing go into the weeds.

Here are the values I write into the registers:

GPMC_CONFIG1 reg: 1200 

GPMC_CONFIG2 reg: 40400 

GPMC_CONFIG3 reg: 20201 

GPMC_CONFIG4 reg: 4030403 

GPMC_CONFIG5 reg: 1040505 

GPMC_CONFIG6 reg: 4030000

and here is a screen shot of the logic analyzer:

http://balister.dyndns.org:8008/~balister/gpmc-write.png

Philip
