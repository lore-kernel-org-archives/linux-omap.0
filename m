From: <Tero.Kristo@nokia.com>
Subject: RE: getnstimeofday() and suspend
Date: Fri, 15 Aug 2008 12:32:55 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE394305E574F@vaebe110.NOE.Nokia.com>
References: <B71CE868F2BC2847B3F23C5A8EE394305AB785@vaebe110.NOE.Nokia.com> <20080813140016.GE27446@atomide.com> <B71CE868F2BC2847B3F23C5A8EE394305AB858@vaebe110.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:54955 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbYHOJd3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 05:33:29 -0400
Content-class: urn:content-classes:message
In-reply-to: <B71CE868F2BC2847B3F23C5A8EE394305AB858@vaebe110.NOE.Nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

>>Hmm, well it should get the value straight from the 32KiHZ sync timer.
>>Does that get stopped somehow during suspend?
>>
>>Tony
>>
>
>Timer is not stopped, because immediately after suspend I get 
>correct value from it (called from wakeup interrupt), but 
>after this it is reprogrammed by something, or either time 
>management code gets confused somehow.

Hi Tony,

This behavior of the getnstimeofday() is breaking pm-debug and the
serial console wakeup hack if we use suspend. Enabling RTC module seems
to fix some of the issues in some cases, but we are going to lose timer
accuracy (RTC accuracy is only 1 second.) Also, these functionalities
should not be dependant on RTC imo. Should I revert these patches to use
directly HW timer and ignore getnstimeofday() or what do you think? 

-Tero
