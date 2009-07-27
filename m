From: Gary Thomas <gary@mlbassoc.com>
Subject: Re: OMAP camera with BT-656 sensor
Date: Mon, 27 Jul 2009 13:59:07 -0600
Message-ID: <4A6E070B.8090203@mlbassoc.com>
References: <a187869d0907270546m2be3542cla72366acfc62fb64@mail.gmail.com>	 <a187869d0907270725n7fce759bs6bcaeed70bd7f872@mail.gmail.com>	 <A24693684029E5489D1D202277BE89444A16EC65@dlee02.ent.ti.com>	 <a187869d0907270859l313b86d3nea833c7a019d35be@mail.gmail.com>	 <A24693684029E5489D1D202277BE89444A16ECD1@dlee02.ent.ti.com>	 <a187869d0907270911j74ee55b9nc872687eb32aecce@mail.gmail.com>	 <A24693684029E5489D1D202277BE89444A16ED18@dlee02.ent.ti.com>	 <a187869d0907271036meb56ce9r32c5f5e823465e87@mail.gmail.com>	 <A24693684029E5489D1D202277BE89444A16EE88@dlee02.ent.ti.com>	 <a187869d0907271145i177dcf52jb75aee758300878@mail.gmail.com> <a187869d0907271146q66112fc8l85aa37c8b1512d68@mail.gmail.com> <4A6DFBBE.6020805@mlbassoc.com> <A24693684029E5489D1D202277BE89444A16F057@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hermes.mlbassoc.com ([76.76.67.137]:2610 "EHLO
	mail.chez-thomas.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbZG0T7H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jul 2009 15:59:07 -0400
In-Reply-To: <A24693684029E5489D1D202277BE89444A16F057@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Aguirre Rodriguez, Sergio Alberto wrote:
> 
>> -----Original Message-----
>> From: Gary Thomas [mailto:gary@mlbassoc.com]
>> Sent: Monday, July 27, 2009 2:11 PM
>> To: Aguirre Rodriguez, Sergio Alberto
>> Cc: linux-omap@vger.kernel.org
>> Subject: OMAP camera with BT-656 sensor
   ... snip

>> Bottom line, I'm confused as to how I should go about getting
>> my driver/system working.  Do I use your work, or just stick
>> with the PSP base (why?)??
> 
> What I do feel is that the PSP base will fulfill better your immediate needs, but in the future, as I'm getting aware of Vaibhav changes, I'll be interested in making them part of my tree aswell, so Vaibhav could avoid rebasing the BT646 support internally everytime...

Is there a GIT tree for this?

A [hopefully] minor complication is that I'm using Tomi's DSS2
tree for the base of my port.  How can I move/merge the PSP
based support into it?  Can I just pick up the whole drivers/media
subtree and put in in place of what I have?

Thanks for your help - this myriad of trees and very disparate
support levels is really confusing to those of us on the outside...

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
