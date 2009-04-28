From: Felix Radensky <felix@embedded-sol.com>
Subject: Re: Previewer and resizer demo
Date: Tue, 28 Apr 2009 18:53:16 +0300
Message-ID: <49F7266C.3000706@embedded-sol.com>
References: <49EDDDD9.8080207@embedded-sol.com> <19F8576C6E063C45BE387C64729E739404280C6022@dbde02.ent.ti.com> <49EEA97D.9040409@embedded-sol.com> <19F8576C6E063C45BE387C64729E73940432094FD4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from vega.surpasshosting.com ([72.29.83.9]:60940 "EHLO
	vega.surpasshosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760985AbZD1PxX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 11:53:23 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E73940432094FD4@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Hiremath, Vaibhav wrote:
>>
> [Hiremath, Vaibhav] From where you got these patches? Kernel version should be enough for me to understand the release package.
>
>   
>> What I know is that
>> previewer
>> is accessible via separate character device.
>>
>>     
> [Hiremath, Vaibhav] Yes, very true. Irrespective of release package you are using Resizer and Previewer modules are exported to the user space as a stand-alone character driver.
>
> There are some changes in the IOCTL's (New Ioctl added), so I just wanted to make sure that I share buildable version of application.
>  
> Thanks,
> Vaibhav Hiremath
>
>   
>

Hi,

I hope you did not forget me. I just need some skeleton that shows how 
captured frame is forwarded to previewer.
I can work out build problems if there are any.

Thanks a lot.

Felix.
