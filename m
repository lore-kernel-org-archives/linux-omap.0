From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH v2 3/6] TI816X: Update common OMAP machine specific
 sources
Date: Sat, 11 Dec 2010 06:28:31 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036A17C7A5@dbde02.ent.ti.com>
References: <1281546664-11477-1-git-send-email-hemantp@ti.com>
 <20100916222459.GQ29610@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B03569BEEA3@dbde02.ent.ti.com>
 <20101105205943.GS9264@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0369E7C04D@dbde02.ent.ti.com>
 <20101129192927.GG17222@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B0369F61ACE@dbde02.ent.ti.com>
 <20101206165308.GB8345@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53248 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757405Ab0LKA6l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 19:58:41 -0500
In-Reply-To: <20101206165308.GB8345@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Tony Lindgren wrote on Monday, December 06, 2010 10:23 PM:

[...]
>> Similarly, we will also need to add TI816X specific hwmods.
>> 
>> 4) TI816X series shares similarity with OMAP4 too - e.g., various IPs are
>> same, CM module is closer to OMAP4 than OMAP3. Thus, regaring (1) above, I
>> could use OMAP4 code instead of adding new "else if". Of course, again,
>> there are above mentioned differences too.
> 
> We really want to use same code for the shared modules so
> using feature
> based detection is the way to go.
> 
Tony,

Just wanted to confirm: so you are suggesting we do not have any
cpu_is_ti81xx() check in the code - is that correct? 

Thanks
-
Hemant

