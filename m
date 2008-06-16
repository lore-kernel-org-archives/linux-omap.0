From: James Chapman <jchapman@katalix.com>
Subject: Re: ppp on 2.6.18
Date: Mon, 16 Jun 2008 13:53:22 +0100
Message-ID: <48566242.1080306@katalix.com>
References: <a1d91fa0806160536r646577e2n7099431aa934a556@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ppp-owner@vger.kernel.org>
In-Reply-To: <a1d91fa0806160536r646577e2n7099431aa934a556@mail.gmail.com>
Sender: linux-ppp-owner@vger.kernel.org
To: mohammed shareef <mdshareef@gmail.com>
Cc: omap <linux-omap@vger.kernel.org>, linux-ppp@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

mohammed shareef wrote:
> Dear all,
> 
> i have enabled ppp services when configuring the kernel 2.6.18.
> 
> the kernel bootup  of omap5912 osk says this:
> 
> PPP generic driver version 2.4.2
> PPP Deflate Compression module registered
> PPP BSD Compression module registered
> 
> but when i type "pppd -h" in the osk console i get:
> 
> # pppd -h
> -sh: pppd: not found

You don't have the userspace pppd installed.

-- 
James Chapman
Katalix Systems Ltd
http://www.katalix.com
Catalysts for your Embedded Linux software development

