From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: new PM branch available
Date: Wed, 14 Jan 2009 08:35:36 -0800
Message-ID: <496E1458.2070700@deeprootsystems.com>
References: <87iqoij2me.fsf@deeprootsystems.com> <3a2dabf50901140440y12b8c874j4b0da8100c763c24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:59524 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761225AbZANQfk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 11:35:40 -0500
Received: by yx-out-2324.google.com with SMTP id 8so257783yxm.1
        for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 08:35:39 -0800 (PST)
In-Reply-To: <3a2dabf50901140440y12b8c874j4b0da8100c763c24@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ramesh Gupta Guntha <grgupta77@gmail.com>
Cc: linux-omap@vger.kernel.org

Ramesh Gupta Guntha wrote:
> Hi Kevin,
> 
> On 1/14/09, Kevin Hilman <khilman@deeprootsystems.com> wrote:
>> Hello,
>>
>> The latest PM branch is now available[1].
>>
>> I've done basic testing of retention and off-mode (suspend and dynamic
>> idle) on Beagle and custom HW.  My SDP has something still keeping
>> CORE active that others have not seen, but I have yet to debug.  Any
>> other reports from SDP testing would be appreciated.
> 
> I have tested on my SDP, I too observed the similar behaviour, I am
> seeing both PER and CORE are active.
> 

Hmm, if you're seeing both PER and CORE, then UART clocks are probably 
still active.

Please try this:

# echo 1 > /sys/power/clocks_off_while_idle

then try again.

Thanks,

Kevin
