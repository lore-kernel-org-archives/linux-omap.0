From: Christian Hoffmann <chrmhoffmann@gmail.com>
Subject: Re: omap: panda rcu stall on 3.10.1
Date: Sat, 07 Sep 2013 08:23:38 +0200
Message-ID: <522AC66A.1000605@gmail.com>
References: <521DA180.9010306@gmail.com> <52203B54.70902@gmail.com> <CAGGh5h3AxogEURrQFd==zhGWpVF7eRaZPNo_Y1peC0TwS673Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGGh5h3AxogEURrQFd==zhGWpVF7eRaZPNo_Y1peC0TwS673Tw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jean-philippe francois <jp.francois@cynove.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, paulmck@linux.vnet.ibm.com
List-Id: linux-omap@vger.kernel.org

On 08/30/2013 10:10 AM, jean-philippe francois wrote:
> 2013/8/30 Christian Hoffmann <chrmhoffmann@gmail.com>:
>>
>>> This also went to: linaro-kernel@lists.linaro.org
>>
>> Hi,
>>
>> current linaro kernel on 13.07 (3.10.1.0-1-linaro-omap) shows stack below.
>> System is generally quite unstable. Light usage (postfix+dovecot...)
>>
>> Full dmesg here:
>> https://dl.dropboxusercontent.com/u/21820416/rcu.stall.panda
>>
> Hi,
>
> Does it happen when run with nohlt in the kernel command line ?

Hi,

the panda is much more stable (up now for 2 or three days) with nohlt. 
No sign of stack traces or RCU stalls.

Thank you.
Chris
