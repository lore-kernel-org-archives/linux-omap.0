From: Nishanth Menon <nm@ti.com>
Subject: Re: FIX ME in omap-cpufreq.c
Date: Fri, 5 Dec 2014 07:20:32 -0600
Message-ID: <5481B120.9050109@ti.com>
References: <54809D3F.6070108@gmail.com> <CAKohpomfgZEkQ4Nv_VqtUe9ObveB+Ymw2Q0KxJLLZmkzHbQEQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAKohpomfgZEkQ4Nv_VqtUe9ObveB+Ymw2Q0KxJLLZmkzHbQEQg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, nick <xerofoify@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-omap <linux-omap@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 12/04/2014 10:30 PM, Viresh Kumar wrote:
> On 4 December 2014 at 23:13, nick <xerofoify@gmail.com> wrote:
>> Greetings Kevin and the other maintainers of this file,
> 
> Hi,
> 
>> I am wondering why the below code still has a fix me? It seems rather trivial to fix, as all we need is the transition
>> time of the CPU. Due to this and I don't have the hardware do any of you have the hardware, can any of you tell me the
>> correct value for this if you have this hardware. Further more I will paste the code below.
> 
> Not every FIXME wants to get fixed. Believe me.
> 
> Don't just grep for FIXME's in kernel and send patches for that. It
> isn't working anymore Nick.
> 
> I understand that you want to get some name for yourself in the kernel community
> (and for sure there is nothing wrong in that), but the way you have chosen isn't
> taking you there. People aren't really happy with the way things are proceeding.
> 
> If you really want to help kernel (and yourself), start getting deeper
> knowledge of
> frameworks you have any idea of. And they try to solve some real problems.
> 
> I don't want to discourage you here, but trying to show the right path. Rest is
> upon you :)
> 

by the way, the file is redundant once we get omap3 platforms to be DT
only and will be deleted. It is meant only for legacy boot for OMAP3
at the moment.


-- 
Regards,
Nishanth Menon
