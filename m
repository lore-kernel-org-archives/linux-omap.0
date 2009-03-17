From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] regulator: twl4030 VAUX3 supports 3.0V
Date: Tue, 17 Mar 2009 09:36:25 +0200
Message-ID: <49BF52F9.2030708@nokia.com>
References: <49B11EB0.30809@nokia.com>	 <200903061116.21544.david-b@pacbell.net>	 <20090306221842.GB15728@sirena.org.uk>	 <200903061448.43749.david-b@pacbell.net> <1236599245.6781.86.camel@vega.slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:39686 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbZCQHgJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Mar 2009 03:36:09 -0400
In-Reply-To: <1236599245.6781.86.camel@vega.slimlogic.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: David Brownell <david-b@pacbell.net>, Mark Brown <broonie@sirena.org.uk>, LKML <linux-kernel@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>

Liam Girdwood wrote:
> On Fri, 2009-03-06 at 14:48 -0800, David Brownell wrote:
>> On Friday 06 March 2009, Mark Brown wrote:
>>> Would it make sense to make this platform data so that if a given board
>>> requires running the chip like this it can be enabled for those boards
>>> but it's not something people might turn on because it seems useful?
>> Let's hear if it's actually needed, first.  :)
>>
>> I coded those tables so that it would be easy to kick in the
>> support for out-of-spec operation if it's really needed.  But
>> so far we don't know that it's needed, and I'd rather it not
>> be too easy to run like that.
>>
> 
> I've now reverted this patch. 

TI say we can use VAUX3 at 3V and expect no problems:

http://community.ti.com/forums/p/3777/14574.aspx

So how do we do it?

