From: Gary Thomas <gary@mlbassoc.com>
Subject: OMAP Audio
Date: Tue, 16 Feb 2010 11:19:25 -0700
Message-ID: <4B7AE1AD.7080400@mlbassoc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:45979 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932859Ab0BPST2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 13:19:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: OMAP Linux discussion <linux-omap@vger.kernel.org>

I need to connect the OMAP (3530) to a 24bit CODEC.  So far
my attempts at getting this to go have not gone well.  Then
I ran across this comment in sound/soc/omap/omap-pcm.c:
	/*
	 * Note: Regardless of interface data formats supported by OMAP McBSP
	 * or EAC blocks, internal representation is always fixed 16-bit/sample
	 */

Does this mean that this setup is just not supported?  even though
the hardware can handle it?

Thanks for any pointers or ideas on how to get this going.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
