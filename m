From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH-V3 3/3] ARM: OMAP3+: clock33xx: Add AM33XX clock tree
 data
Date: Thu, 26 Apr 2012 02:49:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204260246170.10308@utopia.booyaka.com>
References: <1333458578-23073-1-git-send-email-hvaibhav@ti.com> <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48073 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755134Ab2DZIta (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Apr 2012 04:49:30 -0400
In-Reply-To: <1333458578-23073-4-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>, Afzal Mohammed <afzal@ti.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, khilman@ti.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

Hello Vaibhav,

looking at Table 1-1 "Device Features" of SPRUH73D, it seems that some 
AM33xx family chips come with some features disabled, such as the 
PRU-ICSS, the SGX, Ethernet, or USB.  How will this affect the clock tree?  
For example, is it correct for us to include the PRU-ICSS clock control on 
a clock tree that is booted on an AM3352 or an AM3354?


- Paul
