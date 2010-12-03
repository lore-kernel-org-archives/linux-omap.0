From: Paul Walmsley <paul@pwsan.com>
Subject: Re: UART RX wakeup from sleep not working
Date: Fri, 3 Dec 2010 03:45:32 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012030344320.17078@utopia.booyaka.com>
References: <E1POEDj-0002sN-R2@amazonia.comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52103 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755846Ab0LCKpd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 05:45:33 -0500
In-Reply-To: <E1POEDj-0002sN-R2@amazonia.comcast.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rick Bronson <rick@efn.org>
Cc: linux-omap@vger.kernel.org


By the way, if you're using a really recent kernel, you may want to see if 
sending a few breaks down the line wakes it up:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg39735.html
  
Based on your problem description, I doubt this will help, but it's worth 
a try.


- Paul
