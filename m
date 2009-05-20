From: Blazej Kot <bjk45@cornell.edu>
Subject: Gumstix Overo Low Power Standby?
Date: Wed, 20 May 2009 11:18:23 -0400
Message-ID: <E7CF933B-CAC8-4F9E-AA3F-C64F36063C8F@cornell.edu>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from granite1.mail.cornell.edu ([128.253.83.141]:64959 "EHLO
	authusersmtp.mail.cornell.edu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753526AbZETPSW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2009 11:18:22 -0400
Received: from dhcp103-57.cs.cornell.edu (dhcp103-57.cs.cornell.edu [128.84.103.57])
	(authenticated bits=0)
	by authusersmtp.mail.cornell.edu (8.13.1/8.12.10) with ESMTP id n4KFINmJ025208
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 11:18:23 -0400 (EDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

I have been working with the linux-pm kernel on the Gumstix Overo,  
seeing how low it's power consumption can go, both during the cpu "on"  
and especially while the CPU is suspended. Thus far, I've had some  
disappointing results, the best I could get is about 500mW while on,  
and 250mW while suspended (ie by running "echo mem > /sys/power/ 
state"). I am led to believe that the OMAP processor is capable of  
much lower power consumption during standby.

I am wondering if anybody in the gumstix community is looking into the  
software support for very-low-power modes on the overo. If so, I am  
wondering what the lowest power levels are which you have reached  
during standby are.

I have seen this:

http://markmail.org/message/ge5hec5f5asp7a67#query:omap%20linux 
%2080%20ma+page:1+mid:t2erlwweknakm767+state:results

Which seems to indicate the lowest power reached is 80mA at 3.3V ->  
0.264 W, which is about what I'm seeing. Is it really true that the  
overo draws a quarter of a watt when doing absolutely nothing?

Thank you,
Blazej
